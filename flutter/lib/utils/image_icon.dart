import 'package:flutter/material.dart';
import 'package:mono_kit/functions/functions.dart';

/// Iconがfor webのSafari上で表示されないので画像で誤魔化す
class AssetsIcon extends StatelessWidget {
  const AssetsIcon(
    this.icon, {
    Key key,
  }) : super(key: key);

  final AssetsIcons icon;

  @override
  Widget build(BuildContext context) {
    return ImageIcon(
      Image.asset(
        'assets/icons/${enumValueToString(icon)}.png',
        scale: 2,
      ).image,
    );
  }
}

enum AssetsIcons {
  menu,
}
