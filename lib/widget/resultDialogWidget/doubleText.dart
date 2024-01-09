import 'package:flutter/material.dart';

class DoubleText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color insideColor;

  const DoubleText({
    super.key,
    required this.text,
    required this.fontSize,
    required this.insideColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // 影（外枠）部分
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold, // 文字を太くする
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
            fontWeight: FontWeight.w400, // 文字を太くすると内側の太さも一致
            color: insideColor, // 内側の色
          ),
        ),
      ],
    );
  }
}
