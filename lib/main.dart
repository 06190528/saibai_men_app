import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:saibai_men_app/common/data/firebaseSave.dart';
import 'package:saibai_men_app/firebase_options.dart';
import 'package:saibai_men_app/mainWidget/titielWidget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase Appが初期化されていない場合にのみ初期化する
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  MobileAds.instance.initialize();
  initializeUserData(); // ローカルにユーザーデータがない場合は初期値を設定

  runApp(
    ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TitleScene(),
      ),
    ),
  );
}
