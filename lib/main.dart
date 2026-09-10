import 'package:shadow_depths/menu.dart';
import 'package:shadow_depths/util/localization/my_localizations_delegate.dart';
import 'package:flame/flame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'util/sounds.dart';

double tileSize = 32;

class ShadowDepthsApp extends StatefulWidget {
  @override
  State<ShadowDepthsApp> createState() => _ShadowDepthsAppState();
}

class _ShadowDepthsAppState extends State<ShadowDepthsApp> {
  Locale? _locale;
  final MyLocalizationsDelegate _myLocation = const MyLocalizationsDelegate();

  void _changeLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Normal',
      ),
      home: Menu(onLocaleChange: _changeLocale),
      locale: _locale,
      supportedLocales: MyLocalizationsDelegate.supportedLocales(),
      localizationsDelegates: [
        _myLocation,
        DefaultCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: _myLocation.resolution,
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await Flame.device.setLandscape();
    await Flame.device.fullScreen();
  }
  await Sounds.initialize();
  runApp(ShadowDepthsApp());
}
