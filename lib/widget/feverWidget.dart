import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saibai_men_app/common/ad_helper.dart';
import 'package:saibai_men_app/common/const.dart';
import 'package:saibai_men_app/common/language.dart';
import 'package:saibai_men_app/common/data/userData.dart';
import 'package:saibai_men_app/provider.dart';
import 'package:saibai_men_app/widget/adwidget/bannerAd.view.dart';
import 'package:saibai_men_app/widget/resultDialogWidget/buttonWidget.dart';
import 'package:saibai_men_app/widget/resultDialogWidget/doubleText.dart';

class PauseWidget extends ConsumerWidget {
  final Function()? offGamePause;
  PauseWidget({this.offGamePause, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    UserData userData = ref.watch(userDataProvider);
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
            top: screenHeight / 10,
            width: screenWidth * 0.9,
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 222, 222, 222), // ボタンの背景色
                borderRadius: BorderRadius.circular(20), // 角丸設定
                border: Border.all(
                  color: Colors.black, // 枠線の色
                  width: 1, // 枠線の太さ
                ),
              ),
              // width: screenWidth * 0.3, // 横幅を screenWidth * 0.7 に設定
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                  children: [
                    DoubleText(
                      text: Language().translationPause(userData.language),
                      fontSize: screenWidth * 0.1,
                      insideColor: Color.fromARGB(255, 255, 192, 1),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              bottom: screenHeight * 0.2, // 下から10%の位置に配置
              child: Column(
                children: [
                  BannerButton(
                    text: Language().translationContinue(userData.language),
                    onPressed: () {
                      offGamePause!();
                    },
                    width: screenWidth * 0.7,
                    icon: Icons.play_arrow,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  BannerButton(
                    text: Language().translationRestart(userData.language),
                    onPressed: () {
                      ref.read(dinoGameProvider.notifier).reset();
                      ref.read(showResultDialogProvider.state).state = false;
                      ref.read(enemyCounterProvider.state).state = 0;
                      ref.read(isGameActiveProvider.state).state = false;
                      ref.read(createStartButtonFlag.state).state = true;
                      ref.read(pauseProvider.state).state = false;
                      ref.read(bgmAudioProvider).stop();
                      ref.read(usedContinueProvider.state).state = false;
                      ref.read(bgmSpeedProvider.state).state = 1.0;
                    },
                    width: screenWidth * 0.7,
                    icon: Icons.replay,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
