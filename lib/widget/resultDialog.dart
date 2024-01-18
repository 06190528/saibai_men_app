import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saibai_men_app/common/firebase/firebaseSave.dart';
import 'package:saibai_men_app/provider.dart';
import 'package:saibai_men_app/widget/adwidget/rewardAdWidget.dart';
import 'package:saibai_men_app/widget/resultDialogWidget/buttonWidget.dart';
import 'package:saibai_men_app/widget/resultDialogWidget/doubleText.dart';
import 'package:saibai_men_app/widget/resultDialogWidget/scoreWidget.dart';

class Result extends ConsumerWidget {
  const Result({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Stack(
        alignment: Alignment.center, // Stack内の子要素を中央に配置
        children: [
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
                    const DoubleText(
                      text: '結果',
                      fontSize: 30,
                      insideColor: Color.fromARGB(255, 255, 192, 1),
                    ),
                    ScoreWidget(
                        text: 'スコア',
                        width: screenWidth,
                        fontSize: 30,
                        score: '${ref.watch(enemyCounterProvider)}',
                        color: const Color.fromARGB(255, 125, 124, 124),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                        )),
                    ScoreWidget(
                      text: 'ベストスコア',
                      width: screenWidth,
                      fontSize: 20,
                      score: "0",
                      // score: '${sortScoreList(ref.watch(userDataProvider))[1]}',
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
          Positioned(
            bottom: screenHeight * 0.1, // 下から10%の位置に配置
            child: Column(
              children: [
                BannerButton(
                  text: 'リスタート',
                  onPressed: () {
                    ref.read(dinoGameProvider.notifier).reset();
                    ref.read(showResultDialog.state).state = false;
                    ref.read(enemyCounterProvider.state).state = 0;
                    ref.read(isGameActiveProvider.state).state = false;
                    ref.read(createStartButtonFlag.state).state = true;
                    ref.read(pauseProvider.state).state = false;
                    ref.read(bgmAudioProvider).stop();
                    ref.read(usedContinueProvider.state).state = false;
                    ref.read(bgmSpeedProvider.state).state = 1.0;
                  },
                  width: screenWidth * 0.6,
                  icon: Icons.replay,
                ),
                if (!ref.watch(usedContinueProvider.state).state)
                  BannerButton(
                    text: 'コンティニュー',
                    onPressed: () {
                      RewardAdLoader(ref: ref).loadAndShowRewardAd(context);
                    },
                    width: screenWidth * 0.6,
                    icon: Icons.refresh_outlined,
                  ),
              ],
            ),
          ),
          if (ref.watch(loadingRewardAdProvider.state).state)
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
