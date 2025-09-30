//
//  MeditationTimerInteractable.swift
//  TalkToBudda
//
//  Created by mac on 6/5/25.
//

import Foundation

protocol MeditationTimerInteractable: AnyObject {
    var output: MeditationTimerInteractorOutput? { get set }
    func startTimer()
    func pauseTimer()
    func stopTimer()
}

protocol MeditationTimerInteractorOutput: AnyObject {
    func timerUpdated(to timeString: String)
}

final class MeditationTimerInteractor: MeditationTimerInteractable {
    weak var output: MeditationTimerInteractorOutput?

    private var timer: Timer?
    private var remainingSeconds: Int = 0
    private var isPlaying: Bool = false
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.remainingSeconds += 1
            if self.remainingSeconds > 60 * 60 * 60 {
                self.stopTimer()
            }
            self.output?.timerUpdated(to: self.timeFormatted())
        }
        isPlaying = true
    }

    func pauseTimer() {
        if isPlaying {
            timer?.invalidate()
            isPlaying = false
        } else {
            startTimer()
        }
    }

    func stopTimer() {
        timer?.invalidate()
        remainingSeconds = 0
    }

    private func timeFormatted() -> String {
        let minutes = remainingSeconds / 60
        let seconds = remainingSeconds % 60
        return String(format: "00:%02d:%02d", minutes, seconds)
    }
}
