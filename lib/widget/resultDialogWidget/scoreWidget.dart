import 'package:flutter/material.dart';

class ScoreWidget extends StatelessWidget {
  // 外部から受け取るテキストを保存するための変数
  final String? text;
  final double? width;
  final double? fontSize;
  final String? score;
  final Color? color;
  final BorderRadius? borderRadius;
  // コンストラクタでtextを受け取る
  const ScoreWidget(
      {super.key,
      required this.text,
      required this.width,
      required this.fontSize,
      required this.score,
      required this.color,
      required this.borderRadius});

  @override
  Widget build(BuildContext context) {
    final actualWidth = width ?? MediaQuery.of(context).size.width;
    final actualHeight = fontSize! * 2.2;
    return Container(
      width: actualWidth,
      height: actualHeight,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: borderRadius ?? BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text ?? '',
            style: TextStyle(fontSize: fontSize ?? 24, color: Colors.black),
          ),
          if (score != null)
            Text(
              score!,
              style: TextStyle(fontSize: fontSize ?? 24, color: Colors.black),
            ),
        ],
      ),
    );
  }
}
