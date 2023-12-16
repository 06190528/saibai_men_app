import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rush_time_app/common/full_screen_ads_view.dart';
import 'package:rush_time_app/logic/%20alarm.dart';
import 'package:rush_time_app/main.dart';
import 'package:rush_time_app/provider/reviewCountProvider.dart';
import 'package:rush_time_app/view/widget/alarm_finished_dialog.dart';
import 'package:rush_time_app/view/widget/requestReview.dart';

void processPer100min(
    Duration remainingTime,
    DateTime targetTime,
    ValueNotifier<Duration> remainingTimeNotifier,
    BuildContext context,
    bool finished,
    ReviewProvider reviewProvider,
    Timer? timer,
    AdInterstitial adInterstitial) {
  remainingTime = targetTime.difference(DateTime.now());
  remainingTimeNotifier.value = remainingTime;
  if (remainingTimeNotifier.value.isNegative) {
    timer?.cancel(); // タイマーをキャンセルする
    finished = true;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const Main(),
      ),
    );
  }
  //残り時間が0秒になったらの処理
  if (remainingTimeNotifier.value < const Duration(seconds: 1) && !finished) {
    startAlarm();
    timer?.cancel(); // タイマーをキャンセルする
    finished = true;
    showAlarmFinishedDialog(context).then((_) {
      // ダイアログが閉じられたら新しい画面に遷移
      if (!reviewProvider.reviewFlag) {
        //レビューしてくれたから広告出す
        adInterstitial.showAd().then((_) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Main()),
          );
        });
      } else {
        //レビューしてくれない
        if (reviewProvider.reviewCount % 100 == 3) {
          showDialog(
            context: context,
            builder: (_) => const ReviewDialog(),
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
}
