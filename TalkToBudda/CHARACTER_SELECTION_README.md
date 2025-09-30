# Character Selection Feature

## Overview
This feature allows users to select different spiritual guides/characters for each conversation in the TalkToBuddha app. Each character has unique personality traits, greetings, and guidance styles.

## Implementation Details

### 1. Character Models
- **CharacterType**: Enum defining available characters (Buddha, Monk, Zen Master, Meditation Guide, Spiritual Teacher)
- **Character**: Struct containing character information (name, description, avatar, greeting)

### 2. Data Structure Updates
- **ConversationCodable**: Added `selectedCharacter` property
- **ConversationObject**: Added `selectedCharacter` field for Realm persistence
- **ChatDataManager**: Updated to handle character selection in conversations

### 3. UI Components
- **CharacterSelectionViewController**: Full-screen character selection interface
- **ChatViewController**: Added character selection button and character display
- **ConversationCell**: Shows selected character in conversation history

### 4. Character Types Available
1. **Buddha** - The enlightened one, sharing wisdom and compassion
2. **Wise Monk** - A devoted monk with deep spiritual insights
3. **Zen Master** - A master of Zen philosophy and mindfulness
4. **Meditation Guide** - A gentle guide for your meditation journey
5. **Spiritual Teacher** - A wise teacher of spiritual principles

### 5. Features
- Character selection for new conversations
- Character-specific greetings
- Character information display in conversation history
- Ability to change character during conversation
- Persistent character selection per conversation

### 6. Usage
1. When starting a new conversation, users are prompted to select a character
2. Users can change character using the "Choose Guide" button
3. Each character provides unique responses and guidance
4. Character selection is saved with the conversation

### 7. Technical Implementation
- VIPER architecture maintained
- Realm database integration
- Protocol-based character selection delegation
- Character-specific greeting messages
- UI updates based on selected character

## Files Modified/Created
- `AppModules/Chat/Entity/Character.swift` - Character models
- `AppModules/CharacterSelection/CharacterSelectionViewController.swift` - Character selection UI
- `AppModules/Services/Realm/ConversationObject.swift` - Updated data model
- `AppModules/Services/ChatDataManager.swift` - Character management methods
- `AppModules/Chat/ChatViewController.swift` - Character selection integration
- `AppModules/Chat/ChatInterfaces.swift` - Updated protocols
- `AppModules/Chat/ChatPresenter.swift` - Character selection handling
- `AppModules/Chat/ChatInteractor.swift` - Character-specific responses
- `AppModules/History/ConversationCell.swift` - Character display in history
- `CharacterSelectionTest.swift` - Test implementation
