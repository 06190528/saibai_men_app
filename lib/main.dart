import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rush_time_app/provider/langage_provider.dart';
import 'package:rush_time_app/provider/time_provider.dart';
import 'package:rush_time_app/view/select.view.dart';
import 'package:provider/provider.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // MobileAds.instance.initialize();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LanguageProvider>(
          create: (context) => LanguageProvider(),
        ),
        ChangeNotifierProvider<SetTime>(
          create: (context) => SetTime(),
        ),
      ],
      child: Main(), // あなたのメインウィジェット
    ),
  );
  //アプリ全体で広告表示したいならこっち
  MobileAds.instance.initialize();
}

class Main extends StatelessWidget {
  const Main({super.key});

  //アプリの一部の画面で広告を表示したいならこっち
  // Future<InitializationStatus> _initGoogleMobileAds() {
  //   // TODO: Initialize Google Mobile Ads SDK
  //   return MobileAds.instance.initialize();
  // }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainView(title: 'rush hour'),
      debugShowCheckedModeBanner: false, // この行を追加
    );
  }
}
