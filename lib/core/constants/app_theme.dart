import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color pureWhite = Color(0xFFFFFFFF);
  static const Color pureBlack = Color(0xFF000000);

  static const Color colorYellow = Color(0xFFf8be42);
  static const Color colorGreen = Color(0xFF70b971);

  static const Color lightPrimaryColor = Color(0xFF5346af);
  static const Color lightPrimaryColorDark = Color(0xFF3a317a);
  static const Color lightAccentColor = Color(0xFFe1886f);
  static const Color lightAccentColorDark = Color(0xFF9e5f4e);

  static const Color lightBackgroundColor = Color(0xFFf5f5ff);

  static ThemeData lightTheme = ThemeData(
    fontFamily: 'Poppins',
    primaryColor: lightPrimaryColor,
    backgroundColor: lightBackgroundColor,
    scaffoldBackgroundColor: lightBackgroundColor,
    colorScheme: const ColorScheme(
      primary: lightPrimaryColor,
      primaryVariant: lightPrimaryColorDark,
      secondary: lightAccentColor,
      secondaryVariant: lightAccentColorDark,
      surface: pureWhite,
      background: lightBackgroundColor,
      error: Colors.red,
      onPrimary: pureWhite,
      onSecondary: pureWhite,
      onSurface: pureBlack,
      onBackground: pureBlack,
      onError: pureWhite,
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      color: pureWhite,
      foregroundColor: lightPrimaryColor,
    ),
  );
}

extension ExtraTheme on ThemeData {
  Color get primaryFontColor =>
      brightness == Brightness.light ? AppTheme.pureBlack : AppTheme.pureWhite;
}
