# TalkToBuddha - API Key Setup

## Setting up OpenAI API Key

To use this app, you need to configure your OpenAI API key:

1. Copy the template file:
   ```bash
   cp Info.plist.template Info.plist
   ```

2. Replace `YOUR_OPENAI_API_KEY_HERE` in `Info.plist` with your actual OpenAI API key:
   ```xml
   <key>OpenAI_API_Key</key>
   <string>sk-your-actual-api-key-here</string>
   ```

3. Make sure `Info.plist` is in your `.gitignore` file to prevent committing secrets.

## Security Notes

- Never commit your actual API key to version control
- The `Info.plist` file is already added to `.gitignore`
- Use the template file (`Info.plist.template`) for sharing with other developers
