import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';

Future<void> requestReview(BuildContext context) async {
  print('requestReview');

  // RateMyAppインスタンスを指定された条件で初期化
  final RateMyApp rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 0, // アプリインストール後すぐにダイアログを表示する条件を満たす
    remindDays: 2, // 「後で」を選択した場合、2日後に再提示
    minLaunches: 0, // 起動回数に基づく条件を満たす（初回起動から表示可能）
    remindLaunches: 0, // 「後で」を選択した場合、次回起動時に再提示
  );

  await rateMyApp.init();

  if (rateMyApp.shouldOpenDialog) {
    // ignore: use_build_context_synchronously
    rateMyApp.showRateDialog(
      context,
      title: 'Rate this app',
      message:
          'If you like this app, please take a little bit of your time to review it!',
      rateButton: 'RATE',
      noButton: 'NO THANKS',
      laterButton: 'MAYBE LATER',
      listener: (button) {
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
        return true;
      },
    );
  } else {
    print('e');
  }
}
