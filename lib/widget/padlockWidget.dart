import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saibai_men_app/common/language.dart';
import 'package:saibai_men_app/provider.dart';
import 'package:saibai_men_app/widget/resultDialogWidget/doubleText.dart';

class PadlockWidget extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => PadlockWidgetState();
}

class PadlockWidgetState extends ConsumerState<PadlockWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size; // 画面サイズを取得します
    final userData = ref.watch(userDataProvider);

    return Container(
      width: size.width * 0.25, // コンテナの幅を設定します
      height: size.height * 0.3, // コンテナの高さを設定します
      child: Stack(
        children: <Widget>[
          Image.asset(
            'assets/images/padlock.png',
            width: size.width * 0.25, // 適切なサイズに調整してください
            height: size.height * 0.3, // 適切なサイズに調整してください
          ),
          Positioned(
            top: size.height * 0.15,
            left: 0,
            child: Container(
                width: size.width * 0.25, // テキストコンテナの幅を画像の幅と同じに設定します
                height: size.height, // テキストコンテナの高さを画像の高さと同じに設定します
                alignment: Alignment.center, // テキストをコンテナの中央に配置します
                child: Column(
                  children: [
                    DoubleText(
                        text: '400',
                        fontSize: size.width * 0.05,
                        insideColor: Colors.white),
                    DoubleText(
                      fontSize: size.width * 0.03,
                      text: Language().translationScore(userData.language),
                      insideColor: Colors.white,
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
