import 'package:flutter/material.dart';
import 'package:tesis_firmonec/configuration/configuration.dart';

class AppTheme {


  static ThemeData lightTheme = ThemeData(

    useMaterial3: true,

    primaryColor: LightColorPalette.primaryColor(),
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.light,
    ),
  );


  static ThemeData darkTheme = ThemeData(

    useMaterial3: true,

    primaryColor: DarkColorPalette.primaryColor(),
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.dark,
    ),
  );
}
