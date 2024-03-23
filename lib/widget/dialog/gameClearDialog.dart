import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saibai_men_app/common/ad_helper.dart';
import 'package:saibai_men_app/common/const.dart';
import 'package:saibai_men_app/common/language.dart';
import 'package:saibai_men_app/common/data/userData.dart';
import 'package:saibai_men_app/logic/gameModeLogic.dart';
import 'package:saibai_men_app/logic/gameWidgetLogic.dart';
import 'package:saibai_men_app/logic/othersLogic.dart';
import 'package:saibai_men_app/scene/homeScene.dart';
import 'package:saibai_men_app/provider.dart';
import 'package:saibai_men_app/widget/adwidget/bannerAd.view.dart';
import 'package:saibai_men_app/widget/adwidget/interstitialAdWidget.dart';
import 'package:saibai_men_app/widget/adwidget/rewardAdWidget.dart';
import 'package:saibai_men_app/widget/dialog/modeReleaseAnnounceDialog.dart';
import 'package:saibai_men_app/widget/resultDialogWidget/buttonWidget.dart';
import 'package:saibai_men_app/widget/resultDialogWidget/doubleText.dart';
import 'package:saibai_men_app/widget/showCoinWidget.dart';
import 'package:saibai_men_app/widget/resultDialogWidget/scoreWidget.dart';

class GameClearOrOverDialog extends ConsumerWidget {
  const GameClearOrOverDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GameWidgetLogic gameWidgetLogic = GameWidgetLogic(context, ref);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    ref.watch(userDataProvider).coin;
    UserData userData = ref.watch(userDataProvider);
    bool isClear = ref.read(enemyCounterProvider) >= modeGoal(ref);
    String resultText = isClear
        ? Language().translationGameClear(userData.language)
        : Language().translationGameOver(userData.language);
    if (isClear) {
      final userScoreList =
          ref.watch(userDataProvider.notifier).state.scoreList;
      final gameGoal = modeGoal(ref);
      int clearCount = userScoreList.where((e) => e >= gameGoal).length;
      if (clearCount <= 1) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showDialog(
            context: context,
            builder: (context) {
              return const ModeReleaseAnnounceDialog();
            },
          );
        });
      }
    }

    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Stack(
        alignment: Alignment.center,
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
            top: screenHeight / 10,
            width: screenWidth * 0.8,
            child: Dialog(
              insetPadding: const EdgeInsets.all(0),
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DoubleText(
                      text: resultText,
                      fontSize: screenWidth * 0.06,
                      insideColor: Color.fromARGB(255, 255, 192, 1),
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
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (!isClear) ...[
            Positioned(
              bottom: screenHeight * 0.1,
              child: Column(
                children: [
                  BannerButton(
                    text: Language().translationRestart(userData.language),
                    onPressed: () async {
                      if (userData.scoreList.length % 5 == 4) {
                        AdInterstitial().createAd();
                        await Future.delayed(const Duration(seconds: 1));
                      }
                      if (ref.read(enemyCounterProvider) >= 60) {
                        requestReview(context);
                        Navigator.of(context).pop();
                      }
                      gameWidgetLogic.resetAllProvider();
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
                          screenWidth,
                          () => GameWidgetLogic(context, ref).continueGame(),
                        );
                      },
                      width: screenWidth * 0.6,
                      icon: Icons.refresh_outlined,
                    ),
                ],
              ),
            ),
          ] else if (isClear)
            Positioned(
              bottom: screenHeight * 0.1, // 下から10%の位置に配置
              child: Column(
                children: [
                  BannerButton(
                    text: Language().translationBack(userData.language),
                    onPressed: () async {
                      if (userData.scoreList.length % 5 == 4) {
                        AdInterstitial().createAd();
                        await Future.delayed(const Duration(seconds: 1));
                      }
                      if (ref.read(enemyCounterProvider) >= 60) {
                        requestReview(context);
                      }
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScene()),
                      );
                      gameWidgetLogic.resetAllProvider();
                    },
                    width: screenWidth * 0.6,
                    icon: Icons.replay,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          if (ref.watch(isLoadingProvider.state).state)
            Positioned(
              bottom: screenHeight * 0.5,
              right: screenWidth * 0.5,
              child: const CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
