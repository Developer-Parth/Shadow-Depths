# Shadow Depths

![Flutter](https://img.shields.io/badge/Made%20with-Flutter-blue.svg)
![Version](https://img.shields.io/badge/version-1.0.0-brightgreen)
![Platforms](https://img.shields.io/badge/platforms-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Windows%20%7C%20Linux-lightgrey)
![Languages](https://img.shields.io/badge/languages-127-brightgreen)

A top-down 2D action RPG dungeon crawler. Descend into the dark depths as a brave Knight on a mission to rescue a kidnapped child from the creatures that dwell below.

## About the Game

You are a Knight, the fifth sent into the dungeon to rescue a kidnapped child. None of your predecessors returned alive. Armed with a sword and a fireball, you must fight through hordes of enemies, find the silver key, and face the Boss lurking in the depths to bring the child home.

### Gameplay Features

- **Exploration** — navigate a dark 50x50 dungeon lit only by torches
- **Combat** — melee sword attacks and ranged fireballs, gated by a stamina system
- **Enemies** — Goblins, Imps, Mini-Bosses, and a final Boss that summons reinforcements as its health drops
- **Puzzles** — find the silver key to unlock the door blocking your path
- **Dynamic Lighting** — a global darkness overlay pierced by your own glow and flickering torchlight
- **NPCs & Story** — dialogue-driven narrative from the Wizard and the Kid
- **127 Languages** — full in-game language selector with native-script display names
- **Two Control Schemes** — virtual joystick (mobile) or keyboard (desktop)

### Controls

| Action | Keyboard | Mobile |
|--------|----------|--------|
| Move | Arrow keys | Joystick |
| Melee attack | Space | Button |
| Ranged attack | Z | Button |

## Screenshots

![Screenshots](media/print1.jpg)
![Screenshots](media/print2.jpg)
![Screenshots](media/print3.jpg)

## Download

- [GitHub Releases](https://github.com/Developer-Parth/Shadow-Depths/releases) — prebuilt APK
- [Play in Browser](https://developer-parth.github.io/Shadow-Depths/)

Or build it yourself:

```bash
flutter build apk        # Android
flutter build web        # Web
flutter build windows    # Windows
flutter build linux      # Linux
```

## Getting Started

This is a [Flutter](https://flutter.dev) project.

```bash
git clone https://github.com/Developer-Parth/Shadow-Depths.git
cd Shadow-Depths
flutter pub get
flutter run -d chrome     # Web
flutter run -d windows    # Windows
flutter run -d linux      # Linux
flutter run -d android    # Android
```

## Supported Platforms

| Platform | Status |
|----------|--------|
| Android  | Supported |
| iOS      | Supported |
| Web      | Supported |
| Windows  | Supported |
| Linux    | Supported |

## Technology Stack

- **Language:** Dart
- **Framework:** Flutter
- **Map Editor:** Tiled
- **Localization:** 127 languages with in-game selector

## Contributing

Contributions are welcome! See [CONTRIBUTING.md](CONTRIBUTING.md) for setup instructions, code style, and how to add translations.

## Credits

### Packages
- [flutter](https://flutter.dev)
- [flame_audio](https://pub.dev/packages/flame_audio)
- [flame_splash_screen](https://pub.dev/packages/flame_splash_screen)
- [url_launcher](https://pub.dev/packages/url_launcher)

### Sprites
- [DungeonTileset II](https://0x72.itch.io/dungeontileset-ii) by 0x72
- [Simple Dungeon Crawler](https://o-lobster.itch.io/simple-dungeon-crawler-16x16-pixel-pack) by o-lobster

## License

This project (excluding third-party sprites and assets, which remain the property of their respective authors) is released under the [MIT License](LICENSE).

---

Built by [Parth Thukral](https://parththukral.xyz).
