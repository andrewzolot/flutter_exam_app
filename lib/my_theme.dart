import 'package:flutter/material.dart';

ThemeData getMyTheme() => ThemeData(
  fontFamily: "Georgia",
  colorScheme: ColorScheme.fromSwatch(
    brightness: Brightness.light,
    primarySwatch: Colors.amber,
  ),
);
