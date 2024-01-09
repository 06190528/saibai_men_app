import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saibai_men_app/provider.dart';

class EnemyCountText extends ConsumerWidget {
  const EnemyCountText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(
      '${ref.watch(enemyCounterProvider)}',
      style: const TextStyle(
        fontFamily: 'CustomFont', // カスタムフォントを使用
        fontSize: 40, // フォントサイズ
        fontWeight: FontWeight.bold, // フォントの太さ
        fontStyle: FontStyle.italic, // フォントスタイルをイタリックに
        color: Colors.black, // テキストの色
        letterSpacing: 1.0, // 文字の間隔
        wordSpacing: 1.0, // 単語の間隔
        shadows: [
          Shadow(
            blurRadius: 2.0,
            color: Colors.black,
            offset: Offset(2.0, 2.0),
          ),
        ],
      ),
    );
  }
}
