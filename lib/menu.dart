import 'dart:async' as async;

import 'package:bonfire/bonfire.dart';
import 'package:shadow_depths/game.dart';
import 'package:shadow_depths/util/custom_sprite_animation_widget.dart';
import 'package:shadow_depths/util/enemy_sprite_sheet.dart';
import 'package:shadow_depths/util/localization/languages.dart';
import 'package:shadow_depths/util/localization/strings_location.dart';
import 'package:shadow_depths/util/player_sprite_sheet.dart';
import 'package:shadow_depths/util/sounds.dart';
import 'package:shadow_depths/widgets/custom_radio.dart';
import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Menu extends StatefulWidget {
  final Function(Locale)? onLocaleChange;

  const Menu({Key? key, this.onLocaleChange}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  static bool _splashShown = false;
  bool showSplash = !_splashShown;
  int currentPosition = 0;
  late async.Timer _timer;
  List<Future<SpriteAnimation>> sprites = [
    PlayerSpriteSheet.idleRight(),
    EnemySpriteSheet.goblinIdleRight(),
    EnemySpriteSheet.impIdleRight(),
    EnemySpriteSheet.miniBossIdleRight(),
    EnemySpriteSheet.bossIdleRight(),
  ];

  @override
  void dispose() {
    Sounds.stopBackgroundSound();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: showSplash ? buildSplash() : buildMenu(),
    );
  }

  Widget buildMenu() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Shadow Depths",
                style: TextStyle(
                    color: Colors.white, fontFamily: 'Normal', fontSize: 30.0),
              ),
              SizedBox(
                height: 20.0,
              ),
              if (sprites.isNotEmpty)
                SizedBox(
                  height: 100,
                  width: 100,
                  child: CustomSpriteAnimationWidget(
                    animation: sprites[currentPosition],
                  ),
                ),
              SizedBox(
                height: 30.0,
              ),
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    minimumSize: Size(100, 40),
                  ),
                  child: Text(
                    getString('play_cap'),
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Normal',
                      fontSize: 17.0,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Game()),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              DefectorRadio<bool>(
                value: false,
                label: 'Keyboard',
                group: Game.useJoystick,
                onChange: (value) {
                  setState(() {
                    Game.useJoystick = value;
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              DefectorRadio<bool>(
                value: true,
                group: Game.useJoystick,
                label: 'Joystick',
                onChange: (value) {
                  setState(() {
                    Game.useJoystick = value;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              _buildLanguageSelector(),
              SizedBox(
                height: 20,
              ),
              if (!Game.useJoystick)
                SizedBox(
                  height: 80,
                  width: 200,
                  child: Sprite.load('keyboard_tip.png').asWidget(),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 20,
          margin: EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      getString('powered_by'),
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Normal',
                          fontSize: 12.0),
                    ),
                    InkWell(
                      onTap: () {
                        _launchURL('https://parththukral.xyz');
                      },
                      child: Text(
                        'Parth Thukral',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                          fontFamily: 'Normal',
                          fontSize: 12.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageSelector() {
    Locale currentLocale = Localizations.localeOf(context);
    String currentCode = currentLocale.countryCode != null
        ? '${currentLocale.languageCode}-${currentLocale.countryCode}'
        : currentLocale.languageCode;
    String currentName = languageNames[currentCode] ??
        languageNames[currentLocale.languageCode] ??
        'English';

    return InkWell(
      onTap: () => _showLanguagePicker(context),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white24),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.language, color: Colors.white70, size: 16),
            SizedBox(width: 8),
            Text(
              currentName,
              style: TextStyle(
                color: Colors.white70,
                fontFamily: 'Normal',
                fontSize: 14.0,
              ),
            ),
            SizedBox(width: 4),
            Icon(Icons.arrow_drop_down, color: Colors.white70, size: 16),
          ],
        ),
      ),
    );
  }

  void _showLanguagePicker(BuildContext context) {
    Locale currentLocale = Localizations.localeOf(context);
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Select Language',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Normal',
                  fontSize: 18.0,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: languageOrder.length,
                itemBuilder: (context, index) {
                  String code = languageOrder[index];
                  String name = languageNames[code]!;
                  Locale locale = codeToLocale(code);
                  bool isSelected =
                      currentLocale.languageCode == locale.languageCode &&
                          currentLocale.countryCode == locale.countryCode;
                  return ListTile(
                    title: Text(
                      name,
                      style: TextStyle(
                        color: isSelected ? Colors.blue : Colors.white,
                        fontFamily: 'Normal',
                        fontSize: 14.0,
                      ),
                    ),
                    trailing: isSelected
                        ? Icon(Icons.check, color: Colors.blue, size: 18)
                        : null,
                    onTap: () {
                      widget.onLocaleChange?.call(locale);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildSplash() {
    return FlameSplashScreen(
      theme: FlameSplashTheme.dark,
      onFinish: (BuildContext context) {
        _splashShown = true;
        setState(() {
          showSplash = false;
        });
        startTimer();
      },
    );
  }

  void startTimer() {
    _timer = async.Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        currentPosition++;
        if (currentPosition > sprites.length - 1) {
          currentPosition = 0;
        }
      });
    });
  }

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}
