import 'package:flutter/material.dart';

class DoubleIcon extends StatelessWidget {
  final IconData iconData;
  final double size;
  final Color insideColor;

  const DoubleIcon({
    super.key,
    required this.iconData,
    required this.size,
    required this.insideColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center, // アイコンを重ねる
      children: <Widget>[
        // 影（外枠）部分
        Icon(
          iconData,
          size: size,
          color: Colors.black, // 外枠の色
        ),
        // アイコンの内側部分
        Icon(
          iconData,
          size: size * 0.95, // 内側のアイコンは少し小さくする
          color: insideColor, // 内側の色
        ),
      ],
    );
  }
}
