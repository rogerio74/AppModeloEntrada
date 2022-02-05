import 'package:flutter/material.dart';

class AppModeloEntradaTheme {
  static const _prymaryColor = 0xFF0f0882;
  static const _whiteColor = 0xFFFFFFFF;

  static const MaterialColor color = MaterialColor(
    _prymaryColor,
    <int, Color>{
      100: Color(0XFFEEEEEE),
      200: Color(0X8A000000),
      300: Color(0xFF00d4ff),
      400: Color(0xFFF44336),
      500: Color(0xFF160bac),
      600: Color(_prymaryColor),
      700: Color(_whiteColor),
    },
  );

  static ButtonStyle elevatedButtonStyle({
    Color color = const Color(_prymaryColor),
  }) {
    return ElevatedButton.styleFrom(
      primary: color,
    );
  }

  static ThemeData theme = ThemeData(
    primaryColor: color.shade600,
    elevatedButtonTheme: ElevatedButtonThemeData(style: elevatedButtonStyle()),
    appBarTheme: AppBarTheme(
        backgroundColor: color.shade500,
        titleTextStyle: theme.textTheme.headline2
            ?.copyWith(color: color.shade700, fontWeight: FontWeight.bold)),
    textTheme: const TextTheme(
      headline1: TextStyle(
        color: Color(_prymaryColor),
      ),
      headline2: TextStyle(
        fontFamily: 'MochiyPopOne',
        color: Color(_prymaryColor),
      ),
      headline3: TextStyle(
        fontFamily: 'MochiyPopOne',
        fontSize: 16,
        color: Color(_prymaryColor),
      ),
      headline5: TextStyle(
          fontFamily: 'MochiyPopOne',
          fontWeight: FontWeight.bold,
          color: Color(_prymaryColor),
          fontSize: 25.0),
      headline6: TextStyle(
        fontFamily: 'MochiyPopOne',
        fontSize: 18,
        color: Color(_prymaryColor),
      ),
      bodyText1: TextStyle(
        fontFamily: 'MochiyPopOne',
        fontSize: 150,
        color: Color(_prymaryColor),
      ),
      button: TextStyle(
        color: Color(_whiteColor),
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ),
    dialogTheme: DialogTheme(
        backgroundColor: color.shade100,
        titleTextStyle: theme.textTheme.headline3,
        contentTextStyle: theme.textTheme.headline3?.copyWith(fontSize: 14)),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            backgroundColor: color.shade600,
            textStyle: theme.textTheme.button)),
  );
}
