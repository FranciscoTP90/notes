import 'colors.dart';
import 'package:flutter/material.dart';

class ThemeApp {
  static final ThemeData themeDataDark = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: ColorsApp.dark,
      primaryColor: ColorsApp.blue,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: ColorsApp.dark,
        elevation: 0.0,
        titleTextStyle: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      ),
      dividerTheme:
          DividerThemeData(color: ColorsApp.whiteBackground.withOpacity(0.2)),
      floatingActionButtonTheme:
          const FloatingActionButtonThemeData(backgroundColor: ColorsApp.blue));

  static final ThemeData themeLight = ThemeData.light().copyWith(
    scaffoldBackgroundColor: ColorsApp.whiteBackground,
    dividerTheme: DividerThemeData(color: ColorsApp.grey.withOpacity(0.2)),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: ColorsApp.whiteBackground,
      elevation: 0.0,
      iconTheme: IconThemeData(color: ColorsApp.dark),
      titleTextStyle: TextStyle(
          color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold),
    ),
  );
}
