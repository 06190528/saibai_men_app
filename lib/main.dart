import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:saibai_men_app/common/data/firebaseSave.dart';
import 'package:saibai_men_app/mainWidget/titielWidget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  initializeUserData(); //　ローカルにユーザーデータがない場合は初期値を設定
  runApp(
    ProviderScope(
      // observers: [UserDataObserver()],
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // これを追加
        home: TitleScene(),
      ),
    ),
  );
}
