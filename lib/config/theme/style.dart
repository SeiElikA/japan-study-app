import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color.dart';

ThemeData customTheme() {
  return ThemeData(
      brightness: Brightness.light,
      primaryColor: MyColor.mainColor,
      primarySwatch: MyColor.mainColor.toMaterialColor(),
      iconTheme: IconThemeData(color: MyColor.whiteColor),
      cardColor: Colors.white,
      backgroundColor: Colors.grey.shade200,
      scaffoldBackgroundColor: MyColor.whiteColor,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: MyColor.whiteColor),
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.transparent),
      ),
      radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.all(MyColor.mainColor)),
      accentColor: MyColor.mainColor,
      fontFamily: "GenSenRounded"
  );
}

extension ColorConversion on Color {
  MaterialColor toMaterialColor() {
    final List strengths = <double>[.05];
    final Map<int, Color> swatch = {};
    final r = red, g = green, b = blue;

    for (var i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }

    for (final strength in strengths) {
      final ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }

    return MaterialColor(value, swatch);
  }
}
