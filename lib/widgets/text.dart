import 'package:flutter/material.dart';

class CustomText {
  static Text title(String text, {double size = 24}) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'JDR Province',
        letterSpacing: 3,
        fontSize: size,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  static Text subtitle(String text,
      {double size = 18, Color color = Colors.grey}) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
