import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saibai_men_app/common/ad_helper.dart';
import 'package:saibai_men_app/common/const.dart';
import 'package:saibai_men_app/common/language.dart';
import 'package:saibai_men_app/logic/gameWidgetLogic.dart';
import 'package:saibai_men_app/provider.dart';
import 'package:saibai_men_app/ui/gameUi.dart';
import 'package:saibai_men_app/widget/adwidget/bannerAd.view.dart';
import 'package:saibai_men_app/widget/deathBlowWidget.dart';
import 'package:saibai_men_app/widget/enemyCountTextWIdget.dart';
import 'package:saibai_men_app/widget/dialog/gameClearDialog.dart';
import 'package:saibai_men_app/widget/gameWidgetArea.dart';
import 'package:saibai_men_app/widget/dialog/resultDialog.dart';

class GameScene extends ConsumerWidget {
  GameScene({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final gameMode = ref.read(gameModeProvider);
    final userData = ref.watch(userDataProvider);
    final userMaxScore = ref.watch(userMaxScoreProvider);
    GameWidgetLogic gameWidgetLogic = GameWidgetLogic(context, ref);
    return Scaffold(
      body: Stack(
        children: [
          GameWidgetArea(),
          if (ref.watch(showResultDialogProvider)) ...[
            if (gameMode == 2) ...[
              Container(
                child: const Result(),
              ),
            ] else ...[
              Container(
                child: const GameClearOrOverDialog(),
              ),
            ],
          ],
          if (ref.watch(isGameActiveProvider)) ...[
            Positioned(
              top: size.height * 0.05,
              right: size.width * 0.01,
              child: const Column(
                children: [
                  EnemyCountText(),
                ],
              ),
            ),
            Positioned(
                top: size.height * 0.6,
                right: size.width * 0.01,
                child: Column(
                  children: [
                    if (ref.watch(deathblowCountProvider) >= 1) ...[
                      if (gameMode == 1 && userMaxScore < 50) ...[
                        SizedBox(
                          width: size.width * 0.15,
                          height: size.width * 0.05,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              AnimatedTextKit(
                                pause: const Duration(milliseconds: 100),
                                repeatForever: true, // アニメーションを無限に繰り返す
                                isRepeatingAnimation: true,
                                animatedTexts: [
                                  ScaleAnimatedText(
                                    Language()
                                        .translationTouch(userData.language),
                                    textStyle: TextStyle(
                                      fontSize: size.width * 0.035, // フォントサイズ
                                      fontWeight: FontWeight.bold, // フォントの太さ
                                      fontStyle:
                                          FontStyle.italic, // フォントスタイルをイタリックに
                                      color: Colors.black, // テキストの色
                                      shadows: const [
                                        Shadow(
                                          blurRadius: 1.0,
                                          color: Colors.black,
                                          offset: Offset(2.0, 2.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                      SizedBox(
                        width: size.width * 0.2,
                        height: size.width * 0.15,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Center(
                              child: DeathBlowWidget(
                                  onActivateSpecialMove:
                                      gameWidgetLogic.activateSpecialMove),
                            ),
                          ],
                        ),
                      ),
                    ]
                  ],
                )),
          ],
          if (ref.watch(swipeFlagProvider))
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.swipe,
                    size: size.width * 0.2,
                    color: Colors.blue,
                  ),
                  AnimatedTextKit(
                    pause: const Duration(milliseconds: 0),
                    repeatForever: true, // アニメーションを無限に繰り返す
                    isRepeatingAnimation: true,
                    animatedTexts: [
                      ScaleAnimatedText(
                        Language().translationRunAway(userData.language),
                        textStyle: TextStyle(
                          fontSize: size.width * 0.1, // フォントサイズ
                          fontWeight: FontWeight.bold, // フォントの太さ
                          fontStyle: FontStyle.italic, // フォントスタイルをイタリックに
                          color: Colors.red, // テキストの色
                          shadows: const [
                            Shadow(
                              blurRadius: 1.0,
                              color: Colors.black,
                              offset: Offset(2.0, 2.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          if (isReleaseMode)
            Positioned(
              bottom: 0,
              child: BannerAdWidget(
                adUnitId: AdHelper.bannerAdUnitId,
                width: size.width,
              ),
            ),
        ],
      ),
    );
  }
}
