import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
