import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rush_time_app/provider/langage_provider.dart';
import 'package:rush_time_app/provider/reviewCountProvider.dart';
import 'package:flutter/services.dart';

class ReviewDialog extends StatelessWidget {
  const ReviewDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);
    final reviewProvider = Provider.of<ReviewProvider>(context);

    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      width: width / 2,
      child: AlertDialog(
        title: Text(languageProvider.requestForReview(),
            style: TextStyle(fontSize: width / 22.5)), // 動的なタイトル
        actions: <Widget>[
          TextButton(
            child: Text(languageProvider.okText(),
                style: TextStyle(fontSize: width / 30)), // 動的なテキスト
            onPressed: () {
              reviewProvider.setReviewFlag(true);
              ReviewRequest.requestReview(); // 理解してない
              Navigator.of(context).pop();
            },
          ),
          SizedBox(width: width / 30), // ここに空白を追加
          TextButton(
            child: Text(languageProvider.laterText(),
                style: TextStyle(fontSize: width / 30)), // 動的なテキスト
            onPressed: () {
              // レビューページへのリダイレクトなどの処理をここに書く
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

//評価ダイアログのためにいるらしい
class ReviewRequest {
  static const platform = MethodChannel('app.channel.shared/review');

  static Future<void> requestReview() async {
    try {
      await platform.invokeMethod('requestReview');
    } on PlatformException catch (e) {
      print("Failed to invoke method: '${e.message}'.");
    }
  }
}
