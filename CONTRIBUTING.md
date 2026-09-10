# Contributing to Shadow Depths

Thanks for your interest in contributing! Here's how to get started.

## Development Setup

1. **Install Flutter** (3.22.3 or later)
   ```bash
   flutter doctor
   ```

2. **Clone the repo**
   ```bash
   git clone https://github.com/Developer-Parth/Shadow-Depths.git
   cd Shadow-Depths
   ```

3. **Install dependencies**
   ```bash
   flutter pub get
   ```

4. **Run the game**
   ```bash
   flutter run -d chrome      # Web
   flutter run -d windows     # Windows
   flutter run -d linux       # Linux
   flutter run -d android     # Android
   ```

## Project Structure

```
lib/
├── main.dart                 # Entry point
├── menu.dart                 # Main menu & language selector
├── game.dart                 # Game world setup
├── player/                   # Knight player logic
├── enemies/                  # Goblin, Imp, Mini-Boss, Boss
├── npc/                      # Wizard & Kid NPCs
├── decoration/               # Torch, Key, Door, Spikes, Potions
├── interface/                # HUD (health bar, score)
├── util/                     # Sprite sheets, sounds, localization
│   └── localization/         # Translation system (127 languages)
└── widgets/                  # Custom radio buttons, game controller
```

## Contributing Guidelines

### Code Style

- Follow existing code patterns — look at neighboring files before writing new ones
- Use `flutter analyze --no-fatal-infos` to check for issues
- No unnecessary comments unless explicitly asked

### Commits

- One file per commit, one push per commit
- Use descriptive commit messages (e.g., `Add goblin idle animation` not `Update file`)

### Adding Translations

Translation files live in `resources/lang/`. Each file is a flat JSON object with these keys:

```json
{
  "play_cap": "PLAY",
  "credits_cap": "CREDITS",
  "powered_by": "Built by ",
  "built_with": "Built with ",
  "talk_wizard_1": "Hello my young knight!\nWhat are you doing here?",
  "talk_player_1": "...",
  "talk_wizard_2": "...",
  "talk_player_2": "...",
  "talk_wizard_3": "...",
  "talk_kid_1": "...",
  "talk_boss_1": "...",
  "talk_player_3": "...",
  "talk_boss_2": "...",
  "talk_kid_2": "...",
  "talk_player_4": "...",
  "play_again_cap": "PLAY AGAIN",
  "congratulations": "CONGRATULATIONS!",
  "thanks": "Thank you for playing Shadow Depths!\n...",
  "door_without_key": "I think I need a key to get through here!"
}
```

- Keep `\n` for line breaks in dialogue strings
- Keep the `:-)` emoticon in `talk_player_4`
- Keep "Shadow Depths" untranslated in the `thanks` string
- Use the native script for each language (e.g., `ja.json` uses Japanese, `ar.json` uses Arabic)
- The language display name in `lib/util/localization/languages.dart` must use the native name

### Adding a New Language

1. Create `resources/lang/{code}.json` with all 19 keys translated
2. Add the language entry to `lib/util/localization/languages.dart`:
   - Add to `languageNames` map (code → native display name)
   - Add to `languageOrder` list (in the correct position)
3. Commit each file separately

### Reporting Issues

- Use [GitHub Issues](https://github.com/Developer-Parth/Shadow-Depths/issues)
- Include steps to reproduce, expected vs actual behavior
- Mention your platform (Android, iOS, Web, Windows, Linux)

## License

By contributing, you agree that your contributions will be licensed under the [MIT License](LICENSE).
