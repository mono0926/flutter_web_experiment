import 'package:flutter/material.dart';

ThemeData buildTheme() {
  final base = ThemeData.light();
  const fontFamily = 'Hiragino Maru Gothic ProN';
  return base.copyWith(
    primaryColor: Colors.pink,
    splashFactory: InkRipple.splashFactory,
    primaryTextTheme: base.primaryTextTheme.apply(
      fontFamily: fontFamily,
    ),
    accentTextTheme: base.accentTextTheme.apply(
      fontFamily: fontFamily,
    ),
    textTheme: base.textTheme.apply(
      fontFamily: fontFamily,
    ),
    cardTheme: base.cardTheme.copyWith(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}
