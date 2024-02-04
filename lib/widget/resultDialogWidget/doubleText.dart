import 'package:flutter/material.dart';

class DoubleText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color insideColor;

  const DoubleText({
    Key? key,
    required this.text,
    required this.fontSize,
    required this.insideColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Stack(
        children: <Widget>[
          // 影（外枠）部分
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 3
                  ..color = Colors.black),
          ),
          // テキストの内側部分
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w400,
              color: insideColor,
              letterSpacing: fontSize * 0.031, // 文字間隔を調整する値を設定
            ),
          ),
        ],
      ),
    );
  }
}
