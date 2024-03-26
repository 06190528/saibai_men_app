import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saibai_men_app/common/ad_helper.dart';
import 'package:saibai_men_app/common/const.dart';
import 'package:saibai_men_app/common/language.dart';
import 'package:saibai_men_app/common/data/userData.dart';
import 'package:saibai_men_app/logic/gameWidgetLogic.dart';
import 'package:saibai_men_app/logic/othersLogic.dart';
import 'package:saibai_men_app/scene/rankingScene.dart';
import 'package:saibai_men_app/provider.dart';
import 'package:saibai_men_app/widget/adwidget/bannerAd.view.dart';
import 'package:saibai_men_app/widget/adwidget/interstitialAdWidget.dart';
import 'package:saibai_men_app/widget/customIconButton.dart';
import 'package:saibai_men_app/widget/resultDialogWidget/buttonWidget.dart';
import 'package:saibai_men_app/widget/resultDialogWidget/doubleText.dart';
import 'package:saibai_men_app/widget/showCoinWidget.dart';
import 'package:saibai_men_app/widget/resultDialogWidget/scoreWidget.dart';

class Result extends ConsumerWidget {
  const Result({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GameWidgetLogic gameWidgetLogic = GameWidgetLogic(context, ref);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    UserData userData = ref.watch(userDataProvider);
    String resultText = Language().translationResult(userData.language);
    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Stack(
        alignment: Alignment.center, // Stack内の子要素を中央に配置
        children: [
          if (isReleaseMode)
            Positioned(
              top: 0,
              child: BannerAdWidget(
                adUnitId: AdHelper.bannerAdUnitId,
                width: screenWidth,
              ),
            ),
          Positioned(
            top: screenHeight / 10, // 上から50の位置に配置
            width: screenWidth * 0.9, // 幅を画面幅に設定
            child: Dialog(
              insetPadding: const EdgeInsets.all(0), // Dialogのデフォルトパディングを削除
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // 子ウィジェットのサイズに合わせる
                  children: [
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Rowのアイテムを中央揃えにする
                      children: [
                        Expanded(
                          child: Center(
                            child: DoubleText(
                              text: resultText,
                              fontSize: screenWidth * 0.06,
                              insideColor: Color.fromARGB(255, 255, 192, 1),
                            ),
                          ),
                        ),
                        CustomIconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RankingWidget()),
                            );
                          },
                          icon: Icons.leaderboard, // IconDataを直接渡す
                          iconSize: screenWidth * 0.045,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ],
                    ),
                    ScoreWidget(
                        text: Language().translationScore(userData.language),
                        width: screenWidth,
                        fontSize: screenWidth * 0.06,
                        score: '${ref.watch(enemyCounterProvider)}',
                        color: const Color.fromARGB(255, 125, 124, 124),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                        )),
                    ScoreWidget(
                      text: Language().translationBestScore(userData.language),
                      width: screenWidth,
                      fontSize: screenWidth * 0.04,
                      score: ref
                          .watch(userDataProvider)
                          .scoreList
                          .reduce(max)
                          .toString(),
                      color: const Color.fromARGB(255, 162, 160, 160),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end, // 右詰めに配置
                      children: [
                        ShowCoinWidget(
                          width: screenWidth * 0.2,
                          height: screenWidth * 0.1,
                          addPlusButton: false,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: screenHeight * 0.1, // 下から10%の位置に配置
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BannerButton(
                  text: Language().translationRestart(userData.language),
                  onPressed: () async {
                    if (userData.scoreList.length % 5 == 4) {
                      ref.read(isLoadingProvider.state).state = true;
                      await AdInterstitial().createAd(
                          ref,
                          () => {
                                Navigator.of(context).pop(),
                                gameWidgetLogic.resetAllProvider(),
                              });
                    } else {
                      if (ref.read(enemyCounterProvider) >= 60) {
                        requestReview(context);
                        Navigator.of(context).pop();
                      }
                      gameWidgetLogic.resetAllProvider();
                    }
                  },
                  width: screenWidth * 0.6,
                  icon: Icons.replay,
                ),
                const SizedBox(height: 20),
                if (!ref.watch(usedContinueProvider.state).state)
                  BannerButton(
                    text: Language().translationContinue(userData.language),
                    onPressed: () async {
                      GameWidgetLogic(context, ref).watchRewardAd(
                        screenWidth * 0.05,
                        () => GameWidgetLogic(context, ref).continueGame(),
                      );
                    },
                    width: screenWidth * 0.6,
                    icon: Icons.refresh_outlined,
                  ),
              ],
            ),
          ),
          if (ref.watch(isLoadingProvider.state).state)
            Positioned(
              bottom: screenHeight * 0.5, // 下から10%の位置に配置
              right: screenWidth * 0.5,
              child: const CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
