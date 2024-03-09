import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saibai_men_app/common/ad_helper.dart';
import 'package:saibai_men_app/common/const.dart';
import 'package:saibai_men_app/common/language.dart';
import 'package:saibai_men_app/common/userData.dart';
import 'package:saibai_men_app/logic/gameModeLogic.dart';
import 'package:saibai_men_app/logic/gameWidgetLogic.dart';
import 'package:saibai_men_app/logic/othersLogic.dart';
import 'package:saibai_men_app/mainWidget/titielWidget.dart';
import 'package:saibai_men_app/provider.dart';
import 'package:saibai_men_app/widget/adwidget/bannerAd.view.dart';
import 'package:saibai_men_app/widget/adwidget/interstitialAdWidget.dart';
import 'package:saibai_men_app/widget/adwidget/rewardAdWidget.dart';
import 'package:saibai_men_app/widget/resultDialogWidget/buttonWidget.dart';
import 'package:saibai_men_app/widget/resultDialogWidget/doubleText.dart';
import 'package:saibai_men_app/widget/resultDialogWidget/scoreWidget.dart';

class GameClearOrOverDialog extends ConsumerWidget {
  const GameClearOrOverDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GameWidgetLogic gameWidgetLogic = GameWidgetLogic(context, ref);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    UserData userData = ref.watch(userDataProvider);
    bool isClear = ref.read(enemyCounterProvider) >= modeGoal(ref);
    String resultText = isClear
        ? Language().translationGameClear(userData.language)
        : Language().translationGameOver(userData.language);
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
                    DoubleText(
                      text: resultText,
                      fontSize: 30,
                      insideColor: Color.fromARGB(255, 255, 192, 1),
                    ),
                    ScoreWidget(
                        text: Language().translationScore(userData.language),
                        width: screenWidth,
                        fontSize: 30,
                        score: '${ref.watch(enemyCounterProvider)}',
                        color: const Color.fromARGB(255, 125, 124, 124),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                        )),
                    ScoreWidget(
                      text: Language().translationBestScore(userData.language),
                      width: screenWidth,
                      fontSize: 20,
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
                  ],
                ),
              ),
            ),
          ),
          if (!isClear) ...[
            Positioned(
              bottom: screenHeight * 0.1, // 下から10%の位置に配置
              child: Column(
                children: [
                  BannerButton(
                    text: Language().translationRestart(userData.language),
                    onPressed: () async {
                      if (userData.scoreList.length % 5 == 4) {
                        AdInterstitial().createAd();
                        await Future.delayed(const Duration(seconds: 1));
                      }
                      if (ref.read(enemyCounterProvider) >= 100) {
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
                        // 同意ダイアログを表示
                        final bool isAgreed = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                Language().translationWatchAdToContinue(
                                    userData.language),
                                style: TextStyle(fontSize: screenWidth * 0.05),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text(Language()
                                      .translationNo(userData.language)),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(false); // ユーザーが同意しない
                                  },
                                ),
                                TextButton(
                                  child: Text(Language()
                                      .translationYes(userData.language)),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(true); // ユーザーが同意する
                                  },
                                ),
                              ],
                            );
                          },
                        );
                        // ユーザーが同意した場合にリワード広告をロードして表示
                        if (isAgreed) {
                          RewardAdLoader(ref: ref).loadAndShowRewardAd(context);
                        }
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
                        await Future.delayed(const Duration(seconds: 3));
                        //ちゃんと書く
                      }
                      if (ref.read(enemyCounterProvider) >= 100) {
                        requestReview(context);
                      }
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => TitleScene()),
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
              bottom: screenHeight * 0.5, // 下から10%の位置に配置
              right: screenWidth * 0.5,
              child: const CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
