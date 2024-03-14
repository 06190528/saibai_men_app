import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saibai_men_app/common/language.dart';
import 'package:saibai_men_app/common/userData.dart';
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
    final feverFlag = ref.watch(feverFlagProvider);
    UserData userData = ref.watch(userDataProvider);
    game.speed = ref.read(speedProvider.state).state;
    game.EnemyCount = (id) {
      gameWidgetLogic.enemyCount(id);
    };
    game.touchEnemy = () async {
      print('${feverFlag} feverFlag');
      if (!feverFlag) {
        print(feverFlag);
        print('game over');
        gameWidgetLogic.onGameOver();
      } else {
        print('defever');
        gameWidgetLogic.deFever();
      }
    };
    game.getItem = () async {
      gameWidgetLogic.getItem();
    };
    return Stack(
      children: [
        GameWidget(
          game: game,
        ),
        if (ref.read(createStartButtonFlag))
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: screenSize.height * 0.2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BannerButton(
                    width: screenSize.width * 0.6,
                    text: Language().translationStart(userData.language),
                    onPressed: () async {
                      ref.read(createStartButtonFlag.state).state = false;
                      gameWidgetLogic.onPressedStartButton();
                    },
                    icon: Icons.play_arrow,
                  ),
                  const SizedBox(height: 20),
                  BannerButton(
                    width: screenSize.width * 0.6,
                    text: Language().translationBack(userData.language),
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    icon: Icons.play_arrow,
                  ),
                ],
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
        ],
      ],
    );
  }
}
