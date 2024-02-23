import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saibai_men_app/logic/directions.dart';
import 'package:saibai_men_app/provider.dart';
import 'package:saibai_men_app/ui/gameUi.dart';

class IsGameActiveTrueWidget extends ConsumerWidget {
  final Function()? onGamePause;
  IsGameActiveTrueWidget({this.onGamePause, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DinoGame game = ref.watch(dinoGameProvider);
    Size screenSize = MediaQuery.of(context).size;
    return Stack(
      children: [
        GestureDetector(
          onPanUpdate: (details) {
            final offset = details.delta;
            final swipeThreshold = 8;
            if (offset.dx.abs() > swipeThreshold ||
                offset.dy.abs() > swipeThreshold) {
              if (offset.dx.abs() > offset.dy.abs()) {
                if (offset.dx > 0) {
                  game.onArrowKeyChanged(Direction.right);
                } else {
                  game.onArrowKeyChanged(Direction.left);
                }
              } else {
                if (offset.dy > 0) {
                  game.onArrowKeyChanged(Direction.down);
                } else {
                  game.onArrowKeyChanged(Direction.up);
                }
              }
            }
          },
        ),
        Positioned(
            top: screenSize.height * 0.05,
            child: SizedBox(
              width: screenSize.width * 0.08,
              height: screenSize.width * 0.08,
              child: FloatingActionButton(
                onPressed: () async {
                  if (onGamePause != null) {
                    onGamePause!(); // nullチェック後に関数を呼び出す
                  }
                },
                child: Icon(Icons.pause), // ボタンのアイコンを切り替える
              ),
            ))
      ],
    );
  }
}
