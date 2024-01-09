import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:saibai_men_app/common/firebase/firebaseSave.dart';
import 'package:saibai_men_app/mainWidget/gameScene.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  await saveUserData();
  runApp(
    ProviderScope(
      child: MaterialApp(
        home: GameScene(),
      ),
    ),
  );
}
