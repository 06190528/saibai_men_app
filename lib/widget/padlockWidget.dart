import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saibai_men_app/common/language.dart';
import 'package:saibai_men_app/provider.dart';
import 'package:saibai_men_app/widget/resultDialogWidget/doubleText.dart';

class PadlockWidget extends ConsumerStatefulWidget {
  final String text;
  final Size size;

  // コンストラクタにtext引数を追加
  const PadlockWidget({Key? key, required this.text, required this.size})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PadlockWidgetState();
}

class _PadlockWidgetState extends ConsumerState<PadlockWidget> {
  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(userDataProvider);
    final width = widget.size.width;
    final height = widget.size.height;

    return Container(
      width: width * 0.25, // コンテナの幅を設定
      height: height * 0.3, // コンテナの高さを設定
      child: Stack(
        children: <Widget>[
          Image.asset(
            'assets/images/padlock.png',
            width: width * 0.25,
            height: height * 0.3,
          ),
          Positioned(
            top: height * 0.15,
            left: 0,
            child: Container(
              width: width * 0.25,
              height: height,
              alignment: Alignment.center,
              child: Column(
                children: [
                  DoubleText(
                    text: widget.text,
                    fontSize: width * 0.05,
                    insideColor: Colors.white,
                  ),
                  DoubleText(
                    fontSize: width * 0.03,
                    text: Language().translationScore(userData.language),
                    insideColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
