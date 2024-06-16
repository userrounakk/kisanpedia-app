import 'package:flutter/material.dart';

const MaterialColor theme = MaterialColor(_themePrimaryValue, <int, Color>{
  50: Color(0xFFE4EDE8),
  100: Color(0xFFBCD3C6),
  200: Color(0xFF90B5A0),
  300: Color(0xFF639779),
  400: Color(0xFF41815D),
  500: Color(_themePrimaryValue),
  600: Color(0xFF1C633A),
  700: Color(0xFF185832),
  800: Color(0xFF134E2A),
  900: Color(0xFF0B3C1C),
});
const int _themePrimaryValue = 0xFF206B40;

const MaterialColor themeAccent = MaterialColor(_themeAccentValue, <int, Color>{
  100: Color(0xFF75FF9F),
  200: Color(_themeAccentValue),
  400: Color(0xFF0FFF57),
  700: Color(0xFF00F549),
});
const int _themeAccentValue = 0xFF42FF7B;
