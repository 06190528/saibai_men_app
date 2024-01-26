import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saibai_men_app/common/data/firebaseSave.dart';
import 'package:saibai_men_app/common/language.dart';
import 'package:saibai_men_app/common/userData.dart';
import 'package:saibai_men_app/mainWidget/gameScene.dart';
import 'package:saibai_men_app/mainWidget/rankingWIdget.dart';
import 'package:saibai_men_app/provider.dart';
import 'package:saibai_men_app/widget/customIconButton.dart';
import 'package:saibai_men_app/widget/resultDialogWidget/buttonWidget.dart';
import 'package:saibai_men_app/widget/settingDialog.dart';

class TitleScene extends ConsumerWidget {
  TitleScene({Key? key}) : super(key: key);

  // 初回のみ実行するフラグ
  bool _initialized = false;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!_initialized) {
      saveUserDataFromLocalToProvider(ref);
      getAndSaveRankingDataFromIFirebaseToProvider(ref);
      _initialized = true; // 初期化が完了したことをマーク
    }
    final size = MediaQuery.of(context).size;
    UserData userData = ref.watch(userDataProvider);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/titleScene.png'),
                fit: BoxFit.cover, // 背景全体に画像を表示
              ),
            ),
          ),
          Positioned(
            left: size.width * 0.1,
            bottom: size.height * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                BannerButton(
                  text: Language().translationStart(userData.language),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GameScene()),
                    );
                  },
                  width: size.width * 0.8,
                  icon: Icons.play_arrow,
                ),
                const SizedBox(width: 20),
                Row(
                  children: [
                    CustomIconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) => UserSettingsDialog());
                      },
                      icon: Icons.settings,
                      iconSize: 24.0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    SizedBox(width: size.width * 0.3),
                    CustomIconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RankingWidget()),
                        );
                      },
                      icon: Icons.leaderboard, // IconDataを直接渡す
                      iconSize: 24.0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
