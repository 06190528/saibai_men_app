import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saibai_men_app/logic/gameWidgetLogic.dart';
import 'package:saibai_men_app/provider.dart';
import 'package:saibai_men_app/widget/gameActiveWidget.dart';
import 'package:saibai_men_app/widget/pauseWidget.dart';
import 'package:saibai_men_app/widget/resultDialogWidget/buttonWidget.dart';

class GameWidgetArea extends ConsumerWidget {
  const GameWidgetArea({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GameWidgetLogic gameWidgetLogic = GameWidgetLogic(context, ref);
    final pauseFlag = ref.watch(pauseProvider);
    final screenSize = MediaQuery.of(context).size;
    final game = ref.watch(dinoGameProvider);
    final isGameActive = ref.watch(isGameActiveProvider);
    game.speed = ref.read(speedProvider.state).state;
    game.EnemyCount = (id) {
      gameWidgetLogic.enemyCount(id);
    };
    game.onGameOver = (id) async {
      gameWidgetLogic.onGameOver();
    };
    game.activateSpecialMove = () async {
      ref.read(deathblowCountProvider.state).state++;
      ref.read(getItemBgmProvider).play('sounds/getItemSound.mp3');
    };
    return Stack(
      children: [
        GameWidget(
          game: game,
        ),
        if (ref.read(createStartButtonFlag))
          Center(
            child: Align(
              alignment: const Alignment(0.0, 0.2), // x軸は中央、y軸は少し下に
              child: BannerButton(
                width: screenSize.width * 0.6,
                text: 'スタート',
                onPressed: () async {
                  gameWidgetLogic.onPressedStartButton();
                },
                icon: Icons.play_arrow, // 再生アイコンを使用
              ),
            ),
          ),
        if (isGameActive) ...[
          IsGameActiveTrueWidget(
            onGamePause: () async {
              gameWidgetLogic.onGamePause();
            },
          )
        ],
        if (pauseFlag) ...[
          PauseWidget(
            offGamePause: () async {
              gameWidgetLogic.onGameResume();
            },
          )
        ]
      ],
    );
  }
}
