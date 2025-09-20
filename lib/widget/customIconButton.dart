import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final Color backgroundColor;
  final Color foregroundColor;
  final double iconSize;
  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;

  CustomIconButton({
    required this.onPressed,
    required this.icon,
    this.backgroundColor = const Color.fromARGB(255, 255, 212, 82),
    this.foregroundColor = Colors.white,
    required this.iconSize,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    required this.borderRadius,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: padding, // 外側の余白
      decoration: BoxDecoration(
        color: backgroundColor, // 背景色
        borderRadius: borderRadius, // 角を丸める
        border: Border.all(
          color: Colors.black, // 枠線の色
          width: iconSize * 0.1, // 枠線の太さ
        ),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: borderRadius,
        child: Padding(
          padding: EdgeInsets.all(iconSize / 4),
          child: Icon(
            icon,
            color: foregroundColor,
            size: iconSize,
          ),
        ),
      ),
    );
  }
}
