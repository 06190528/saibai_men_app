import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rush_time_app/logic/%20alarm.dart';
import 'package:rush_time_app/logic/time.dart';
import 'package:rush_time_app/common/ad_helper.dart';
import 'package:rush_time_app/provider/langage_provider.dart';
import 'package:rush_time_app/provider/reviewCountProvider.dart';
import 'package:rush_time_app/view/widget/alarm_finished_dialog.dart';
import 'package:rush_time_app/view/widget/banner.view.dart';
import 'package:rush_time_app/common/full_screen_ads_view.dart';
import 'package:rush_time_app/provider/time_provider.dart';
import 'package:rush_time_app/main.dart';
import 'package:provider/provider.dart';
import 'package:rush_time_app/view/widget/requestReview.dart';

class CountDownPage extends StatefulWidget {
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

  void didChangeDependencies() {
    super.didChangeDependencies();
    reviewProvider = Provider.of<ReviewProvider>(context);
    // ここでタイマーの設定など、依存するオブジェクトに基づく初期化を行います
  }

  @override
  void initState() {
    super.initState();
    adInterstitial.createAd();
    final setTime = Provider.of<SetTime>(context, listen: false);
    targetTime = setTime.getTime();
    remainingTime = targetTime.difference(DateTime.now());
    bool finished = false;
    // 1秒ごとに残り時間を更新するタイマーを開始します
    timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      // ここにタイマーの処理を記述

      remainingTime = targetTime.difference(DateTime.now());
      remainingTimeNotifier.value = remainingTime;
      if (remainingTimeNotifier.value.isNegative) {
        timer.cancel(); // タイマーをキャンセルする
        finished = true;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Main(),
          ),
        );
      }
      //残り時間が0秒になったらアラームを鳴らし全画面広告出す
      if (remainingTimeNotifier.value < const Duration(seconds: 1) &&
          !finished) {
        startAlarm();
        timer.cancel(); // タイマーをキャンセルする
        finished = true;
        showAlarmFinishedDialog(context).then((_) {
          // ダイアログが閉じられたら新しい画面に遷移
          if (reviewProvider.reviewFlag) {
            print('レビューしてくれた');
            //レビューしてくれたから広告出す
            adInterstitial.showAd().then((_) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Main()),
              );
            });
          } else {
            print('reviewProvider.reviewCount: ${reviewProvider.reviewCount}');
            //レビューしてくれない
            if (reviewProvider.reviewCount % 100 == 3) {
              print('レビューしてくれない');
              showDialog(
                context: context,
                builder: (_) => ReviewDialog(),
              ).then((_) {
                // ダイアログが閉じられた後に実行する処理
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Main()),
                );
              });
            } else {
              adInterstitial.showAd().then((_) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Main()),
                );
              });
            }
            reviewProvider.setReviewCount(reviewProvider.reviewCount + 1);
          }
        });
      }
    });
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
          MyAdWidget(
            // AdMobのバナー広告を表示
            adUnitId: AdHelper.bannerAdUnitId,
            width: MediaQuery.of(context).size.width,
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
            TextButton(
              child: Text('${languageProvider.cancelText()}',
                  style: TextStyle(fontSize: width / 15)),
              onPressed: () {
                stopAlarm();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Main(),
                  ),
                );
              },
            ),
          ]),
          Spacer(), // TextButtonとContainerの間に余白が追加
          Container(
            child: MyAdWidget(
              // AdMobのバナー広告を表示
              adUnitId: AdHelper.bannerAdUnitId,
              width: MediaQuery.of(context).size.width,
            ),
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
