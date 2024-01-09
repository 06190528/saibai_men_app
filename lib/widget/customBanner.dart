import 'package:flutter/material.dart';

class CustomBanner extends StatelessWidget {
  final String text;

  const CustomBanner({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'ここは静的なバナーです',
      style: TextStyle(
        fontFamily: 'CustomFont', // カスタムフォントを使用
        fontSize: 40, // フォントサイズ
        fontWeight: FontWeight.bold, // フォントの太さ
        fontStyle: FontStyle.italic, // フォントスタイルをイタリックに
        color: Colors.black, // テキストの色
        letterSpacing: 1.0, // 文字の間隔
        wordSpacing: 1.0, // 単語の間隔
        decoration: TextDecoration.underline,
        shadows: const [
          Shadow(
            blurRadius: 2.0,
            color: Colors.black,
            offset: Offset(2.0, 2.0),
          ),
        ],
        background: Paint()
          ..color = Color.fromARGB(0, 213, 119, 119), // テキストの背景色
      ),
    );
  }
}
