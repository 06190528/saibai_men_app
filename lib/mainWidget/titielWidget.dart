import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saibai_men_app/common/data/firebaseSave.dart';
import 'package:saibai_men_app/common/language.dart';
import 'package:saibai_men_app/common/userData.dart';
import 'package:saibai_men_app/mainWidget/gameScene.dart';
import 'package:saibai_men_app/mainWidget/rankingScene.dart';
import 'package:saibai_men_app/provider.dart';
import 'package:saibai_men_app/widget/customIconButton.dart';
import 'package:saibai_men_app/widget/resultDialogWidget/buttonWidget.dart';
import 'package:saibai_men_app/widget/resultDialogWidget/doubleText.dart';
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
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // buildメソッドの完了後に実行される
        showUserSettingsDialog(ref, context);
      });
      addUserDataToRankingDataProvider(ref);
      _initialized = true; // 初期化が完了したことをマーク
    }
    final size = MediaQuery.of(context).size;
    UserData userData = ref.watch(userDataProvider);
    return Scaffold(
      body: Stack(
        alignment: Alignment.center, // Stack内の子要素を中央に配置
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
            top: size.height * 0.5, // 上から50の位置に配置
            width: size.width * 0.9, // 幅を画面幅に設定
            child: Dialog(
              insetPadding: const EdgeInsets.all(0), // Dialogのデフォルトパディングを削除
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.max, // 子ウィジェットのサイズに合わせる
                  children: [
                    DoubleText(
                      text: Language().translationSelectMode(userData.language),
                      fontSize: 30,
                      insideColor: Color.fromARGB(255, 255, 192, 1),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        BannerButton(
                          text: Language().translationHard(userData.language),
                          onPressed: () {
                            // BannerButtonのクリック時の処理を追加することができます
                          },
                          width: size.width * 0.8,
                          icon: Icons.play_arrow,
                        ),
                        Positioned(
                          left: size.width * 0.1, // 左詰にするための調整値を設定します
                          child: Image.asset(
                            'assets/images/padlock.png',
                            width: size.width * 0.3, // 適切なサイズに調整してください
                            height: size.height * 0.1, // 適切なサイズに調整してください
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    BannerButton(
                      text: Language().translationNormal(userData.language),
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
                      mainAxisAlignment: MainAxisAlignment.center, // Rowを中央に寄せる
                      children: [
                        CustomIconButton(
                          onPressed: () => showSettingsDialog(context),
                          icon: Icons.settings,
                          iconSize: size.width * 0.06,
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
                                  builder: (context) => const RankingWidget()),
                            );
                          },
                          icon: Icons.leaderboard, // IconDataを直接渡す
                          iconSize: size.width * 0.06,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void showSettingsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => UserSettingsDialog(),
  );
}
