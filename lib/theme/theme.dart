import 'package:flutter/material.dart';

class AppModeloEntradaTheme {
  static const _prymaryColor = 0xFF0f0882;

  static const MaterialColor color = MaterialColor(
    _prymaryColor,
    <int, Color>{
      100: Color(0XFFEEEEEE),
      200: Color(0X8A000000),
      300: Color(0xFF00d4ff),
      400: Color(0xFFF44336),
      500: Color(0xFF160bac),
      600: Color(_prymaryColor),
      700: Color(0xFFFFFFFF),
      800: Colors.black
    },
  );

  static ButtonStyle elevatedButtonStyle({
    Color color = const Color(_prymaryColor),
  }) {
    return ElevatedButton.styleFrom(
      elevation: 10,
      primary: color,
    );
  }

  static ThemeData theme = ThemeData(
    iconTheme: IconThemeData(color: color.shade500, size: 30),
    primaryColor: color.shade600,
    elevatedButtonTheme: ElevatedButtonThemeData(style: elevatedButtonStyle()),
    appBarTheme: AppBarTheme(
      backgroundColor: color.shade500,
      titleTextStyle: const TextStyle(
        fontFamily: 'MochiyPopOne',
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: color.shade600),
    textTheme: TextTheme(
      subtitle2: TextStyle(
        color: color.shade800,
      ),
      subtitle1: TextStyle(
        fontFamily: 'MochiyPopOne',
        fontSize: 14,
        color: color.shade600,
        fontWeight: FontWeight.normal,
      ),
      button: TextStyle(
        color: color.shade700,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: color.shade100,
      titleTextStyle: TextStyle(
        fontFamily: 'MochiyPopOne',
        fontSize: 16,
        color: color.shade600,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: color.shade600,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
            fontFamily: 'MochiyPopOne', fontSize: 16, color: color.shade600)),
  );
}
