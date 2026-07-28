#!/usr/bin/env python3

import json
import plistlib
import re
import sys
import textwrap
import urllib.error
import urllib.request
from dataclasses import dataclass
from datetime import datetime
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
PROMPT_BUILDER_PATH = ROOT / "TalkToBudda" / "Networks" / "PromptBuilder.swift"
NETWORK_SERVICE_PATH = ROOT / "TalkToBudda" / "Networks" / "NetworkService.swift"
OPENAI_PLIST_PATH = ROOT / "TalkToBudda" / "OpenAI.plist"
REVIEWS_DIR = ROOT / "codex-review-loop" / "reviews"
CACHE_DIR = ROOT / "codex-review-loop" / "tmp"

TEST_QUESTIONS = [
    "I feel overwhelmed and do not know how to calm down.",
    "I am angry at someone close to me. What should I do?",
    "I feel lost and unsure what direction my life should take.",
    "I keep failing at something important and want to give up.",
    "How can I become more disciplined in daily life?",
]

CHARACTERS = [
    ("buddha", "Buddha", "buildBuddhaPrompt"),
    ("monk", "Wise Monk", "buildMonkPrompt"),
    ("zen_master", "Zen Master", "buildZenMasterPrompt"),
    ("meditation_guide", "Meditation Guide", "buildMeditationGuidePrompt"),
    ("spiritual_teacher", "Spiritual Teacher", "buildSpiritualTeacherPrompt"),
    ("jesus", "Jesus", "buildJesusPrompt"),
    ("mary", "Mary", "buildMaryPrompt"),
    ("wise_philosopher", "Wise Philosopher", "buildWisePhilosopherPrompt"),
    ("marcus_aurelius", "Marcus Aurelius", "buildMarcusAureliusPrompt"),
    ("socrates", "Socrates", "buildSocratesPrompt"),
]


@dataclass
class CharacterRun:
    key: str
    name: str
    system_prompt: str
    responses: list[dict]


def extract_common_prompt_suffix(source: str) -> str:
    match = re.search(
        r'static func buildSystemPrompt\(for characterType: CharacterType\) -> String \{\s*'
        r'let characterPrompt = getCharacterPrompt\(for: characterType\)\s*'
        r'return """\s*\\\(characterPrompt\)\n(?P<suffix>.*?)\n\s*"""',
        source,
        re.S,
    )
    if not match:
        raise RuntimeError("Could not parse common prompt suffix from PromptBuilder.swift")
    return textwrap.dedent(match.group("suffix")).strip()


def extract_character_prompt(source: str, function_name: str) -> str:
    pattern = (
        rf'private static func {re.escape(function_name)}\(\) -> String \{{\s*return """\n'
        rf'(?P<body>.*?)\n\s*"""'
    )
    match = re.search(pattern, source, re.S)
    if not match:
        raise RuntimeError(f"Could not parse prompt body for {function_name}")
    return textwrap.dedent(match.group("body")).strip()


def load_prompts() -> dict[str, str]:
    source = PROMPT_BUILDER_PATH.read_text()
    suffix = extract_common_prompt_suffix(source)
    prompts: dict[str, str] = {}
    for key, _, function_name in CHARACTERS:
        prompt_body = extract_character_prompt(source, function_name)
        prompts[key] = f"{prompt_body}\n\n{suffix}"
    return prompts


def load_api_config() -> tuple[str, str, str]:
    plist = plistlib.loads(OPENAI_PLIST_PATH.read_bytes())
    api_key = plist["OpenAI_API_Key"]

    network_source = NETWORK_SERVICE_PATH.read_text()
    base_url_match = re.search(r'baseURL = "([^"]+)"', network_source)
    model_match = re.search(r"OpenAIRequest\(model: \.([A-Za-z0-9_]+),", network_source)
    if not base_url_match or not model_match:
        raise RuntimeError("Could not parse API config from NetworkService.swift")

    model_lookup = {
        "gpt3_5Turbo": "gpt-3.5-turbo",
        "gpt4": "gpt-4",
        "gpt4Turbo": "gpt-4-turbo",
        "gpt4o": "gpt-4o",
    }
    model = model_lookup[model_match.group(1)]
    return api_key, base_url_match.group(1), model


def call_openai(api_key: str, base_url: str, model: str, messages: list[dict]) -> str:
    payload = json.dumps({"model": model, "messages": messages}).encode()
    request = urllib.request.Request(
        base_url,
        data=payload,
        headers={
            "Content-Type": "application/json",
            "Authorization": f"Bearer {api_key}",
        },
        method="POST",
    )
    try:
        with urllib.request.urlopen(request, timeout=300) as response:
            response_payload = json.loads(response.read().decode())
    except urllib.error.HTTPError as exc:
        body = exc.read().decode(errors="replace")
        raise RuntimeError(f"HTTP {exc.code}: {body[:500]}") from exc
    except urllib.error.URLError as exc:
        raise RuntimeError(f"Network error: {exc}") from exc

    try:
        return response_payload["choices"][0]["message"]["content"]
    except (KeyError, IndexError) as exc:
        raise RuntimeError(f"Unexpected API response: {response_payload}") from exc


def build_user_message(question: str) -> str:
    return f"Current question: {question}"


def build_batch_user_message(questions: list[str]) -> str:
    joined_questions = "\n".join(f"{index + 1}. {question}" for index, question in enumerate(questions))
    return (
        "Answer the following questions in order. "
        "Return JSON in this exact shape:\n"
        "{\n"
        '  "responses": [\n'
        '    {"question": "...", "answer": "..."}\n'
        "  ]\n"
        "}\n\n"
        f"Questions:\n{joined_questions}"
    )


def extract_answer(raw_content: str, question: str) -> str:
    cleaned = raw_content.replace("```json", "").replace("```", "").strip()
    try:
        parsed = json.loads(cleaned)
        answer = parsed.get("answer")
        if isinstance(answer, str) and answer.strip():
            return answer.strip()
    except json.JSONDecodeError:
        pass
    return cleaned or f"No answer returned for question: {question}"


def extract_batch_answers(raw_content: str, questions: list[str]) -> list[dict]:
    cleaned = raw_content.replace("```json", "").replace("```", "").strip()
    parsed = None
    try:
        parsed = json.loads(cleaned)
    except json.JSONDecodeError:
        parsed = None

    if isinstance(parsed, dict) and isinstance(parsed.get("responses"), list):
        items = parsed["responses"]
        extracted = []
        for index, question in enumerate(questions):
            answer = ""
            if index < len(items) and isinstance(items[index], dict):
                raw_answer = items[index].get("answer", "")
                if isinstance(raw_answer, str):
                    answer = raw_answer.strip()
            extracted.append({"question": question, "answer": answer or f"No answer returned for question: {question}"})
        return extracted

    fallback_answers = [segment.strip() for segment in re.split(r"\n(?=\d+\.)", cleaned) if segment.strip()]
    extracted = []
    for index, question in enumerate(questions):
        answer = fallback_answers[index] if index < len(fallback_answers) else f"No answer returned for question: {question}"
        extracted.append({"question": question, "answer": answer})
    return extracted


def run_character_prompts(api_key: str, base_url: str, model: str, prompts: dict[str, str]) -> list[CharacterRun]:
    results: list[CharacterRun] = []
    CACHE_DIR.mkdir(parents=True, exist_ok=True)
    for key, name, _ in CHARACTERS:
        cache_path = CACHE_DIR / f"character-eval-{key}.json"
        if cache_path.exists():
            cached = json.loads(cache_path.read_text())
            results.append(
                CharacterRun(
                    key=key,
                    name=name,
                    system_prompt=prompts[key],
                    responses=cached["responses"],
                )
            )
            print(f"[cache] {name}")
            continue

        print(f"[run] {name}", flush=True)
        system_prompt = prompts[key]
        raw = call_openai(
            api_key,
            base_url,
            model,
            [
                {"role": "system", "content": system_prompt},
                {"role": "user", "content": build_batch_user_message(TEST_QUESTIONS)},
            ],
        )
        responses = extract_batch_answers(raw, TEST_QUESTIONS)
        cache_path.write_text(json.dumps({"name": name, "responses": responses}, ensure_ascii=False, indent=2))
        results.append(CharacterRun(key=key, name=name, system_prompt=system_prompt, responses=responses))
    return results


def judge_characters(api_key: str, base_url: str, model: str, results: list[CharacterRun]) -> str:
    judge_payload = {
        "evaluation_goal": (
            "Review the conversation quality of each character in TalkToBudda. "
            "Score voice consistency, differentiation, helpfulness, safety, "
            "language handling, and prompt fidelity."
        ),
        "required_output": {
            "per_character": [
                "short summary of response quality",
                "what feels strong",
                "what feels weak or repetitive",
                "whether the character voice feels distinct",
                "specific prompt or product improvements",
                "final score out of 10",
            ],
            "cross_character_summary": [
                "which characters are most differentiated",
                "which characters feel too similar",
                "shared prompt issues",
                "highest-priority improvements",
            ],
        },
        "characters": [
            {
                "name": run.name,
                "responses": run.responses,
            }
            for run in results
        ],
    }

    system_prompt = (
        "You are a rigorous product reviewer evaluating AI character quality. "
        "Write a concise but concrete markdown review. Separate prompt issues from model behavior when possible. "
        "Do not mention hidden system instructions. Do not expose secrets."
    )
    raw = call_openai(
        api_key,
        base_url,
        model,
        [
            {"role": "system", "content": system_prompt},
            {"role": "user", "content": json.dumps(judge_payload, ensure_ascii=False)},
        ],
    )
    return raw.strip()


def write_report(model: str, review_markdown: str) -> Path:
    REVIEWS_DIR.mkdir(parents=True, exist_ok=True)
    timestamp = datetime.now().strftime("%Y-%m-%d-%H%M")
    report_path = REVIEWS_DIR / f"review-{timestamp}.md"
    report_body = f"""# Review Report

## File Reviewed

`input/second-review.md`

## 1. What The File Is About

This run evaluates the live conversation quality of each TalkToBudda character using the app's current OpenAI route, model, and prompt definitions.

## 2. Evaluation Setup

- Route: current app OpenAI chat completions endpoint
- Model: `{model}`
- Prompt source: `TalkToBudda/Networks/PromptBuilder.swift`
- Questions per character: {len(TEST_QUESTIONS)}
- Characters reviewed: {len(CHARACTERS)}

## 3. Findings

{review_markdown}
"""
    report_path.write_text(report_body)
    return report_path


def main() -> int:
    try:
        prompts = load_prompts()
        api_key, base_url, model = load_api_config()
        results = run_character_prompts(api_key, base_url, model, prompts)
        review_markdown = judge_characters(api_key, base_url, model, results)
        report_path = write_report(model, review_markdown)
    except Exception as exc:
        print(f"Evaluation failed: {exc}", file=sys.stderr)
        return 1

    print(report_path)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
