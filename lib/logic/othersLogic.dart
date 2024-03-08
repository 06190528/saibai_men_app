import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';

void requestReview(BuildContext context) {
  final RateMyApp rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 1,
    minLaunches: 3,
    remindDays: 3,
    remindLaunches: 3,
  );

  rateMyApp.init().then((_) {
    if (rateMyApp.shouldOpenDialog) {
      rateMyApp.showRateDialog(
        context,
        title: 'Rate this app', // ダイアログのタイトル
        message:
            'If you like this app, please take a little bit of your time to review it!', // ダイアログのメッセージ
        rateButton: 'RATE', // レートボタンのテキスト
        noButton: 'NO THANKS', // 「いいえ」ボタンのテキスト
        laterButton: 'MAYBE LATER', // 「後で」ボタンのテキスト
        listener: (button) {
          // ボタンのリスナー
          switch (button) {
            case RateMyAppDialogButton.rate:
              print('Clicked on "Rate"');
              break;
            case RateMyAppDialogButton.later:
              print('Clicked on "Later"');
              break;
            case RateMyAppDialogButton.no:
              print('Clicked on "No"');
              break;
          }

          return true; // ダイアログを閉じる
        },
        // ダイアログのスタイルやアクションをカスタマイズする他のパラメータもここに追加可能
      );
    }
  });
}
