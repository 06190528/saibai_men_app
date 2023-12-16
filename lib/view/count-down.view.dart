import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rush_time_app/logic/procesPer100MIn.dart';
import 'package:rush_time_app/logic/time.dart';
import 'package:rush_time_app/common/ad_helper.dart';
import 'package:rush_time_app/provider/langage_provider.dart';
import 'package:rush_time_app/provider/reviewCountProvider.dart';
import 'package:rush_time_app/view/widget/Butoon/plusMinusButtonVIew.dart';
import 'package:rush_time_app/view/widget/banner.view.dart';
import 'package:rush_time_app/common/full_screen_ads_view.dart';
import 'package:rush_time_app/provider/time_provider.dart';
import 'package:provider/provider.dart';
import 'package:rush_time_app/view/widget/Butoon/textButtonView.dart';

class CountDownPage extends StatefulWidget {
  const CountDownPage({super.key});

  @override
  // _CountDownPageState createState() => _CountDownPageState();
  State<CountDownPage> createState() => _CountDownPageState();
}

class _CountDownPageState extends State<CountDownPage> {
  final ValueNotifier<Duration> remainingTimeNotifier =
      ValueNotifier(Duration.zero);
  late DateTime targetTime;
  Duration remainingTime = Duration.zero;
  Timer? timer;
  AdInterstitial adInterstitial = AdInterstitial();
  late ReviewProvider reviewProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    reviewProvider = Provider.of<ReviewProvider>(context);
    // ここでタイマーの設定など、依存するオブジェクトに基づく初期化を行います
    final setTime = Provider.of<SetTime>(context, listen: true);
    targetTime = setTime.getTime();
    remainingTime = targetTime.difference(DateTime.now());
    bool finished = false;
    // 1秒ごとに残り時間を更新するタイマーを開始します
    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      // ここにタイマーの処理を記述
      processPer100min(remainingTime, targetTime, remainingTimeNotifier,
          context, finished, reviewProvider, timer, adInterstitial);
    });
  }

  @override
  void initState() {
    super.initState();
    adInterstitial.createAd();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);
    final setTime = Provider.of<SetTime>(context);
    DateTime setedTime = setTime.getTime();
    //print('カウントダウン${formattedTime}');
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BannerAdWidget(
            // AdMobのバナー広告を表示
            adUnitId: AdHelper.bannerAdUnitId,
            width: width,
          ),
          Column(children: [
            ValueListenableBuilder<Duration>(
                valueListenable: remainingTimeNotifier,
                builder: (context, remainingTime, child) {
                  // 引数として渡されるremainingTimeを使用
                  return Center(
                    child: Text(
                        remainingTimeNotifier.value.inSeconds < 0
                            ? 'Error'
                            : DurationToString(remainingTime),
                        style: TextStyle(
                            fontSize: width / 5, color: Colors.white)),
                  );
                }),
            ValueListenableBuilder<Duration>(
              valueListenable: remainingTimeNotifier,
              builder: (context, remainingTime, child) {
                // 引数として渡されるremainingTimeを使用
                return Text(
                  remainingTime.inSeconds < 0
                      ? 'Error'
                      : '${languageProvider.aramTiemString()} : ${DateTimeToString(setedTime)}',
                  style: TextStyle(fontSize: width / 15, color: Colors.white),
                );
              },
            ),
            const Row(
              children: [
                Spacer(),
                PlusMinusButton(isPlus: true),
                CancelTextButtonView(),
                PlusMinusButton(isPlus: false),
                Spacer(),
              ],
            ),
          ]),
          const Spacer(), // TextButtonとContainerの間に余白が追加
          Container(
            child: BannerAdWidget(
                // AdMobのバナー広告を表示
                adUnitId: AdHelper.bannerAdUnitId,
                width: width),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel(); // タイマーをキャンセル
    super.dispose();
  }
}
