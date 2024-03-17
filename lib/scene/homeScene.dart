import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saibai_men_app/common/data/firebaseSave.dart';
import 'package:saibai_men_app/widget/dialog/gameModeSelectDialog.dart';
import 'package:saibai_men_app/widget/dialog/settingDialog.dart';
import 'package:saibai_men_app/widget/rankingCircleWidget.dart';

class HomeScene extends ConsumerWidget {
  HomeScene({Key? key}) : super(key: key);

  // 初回のみ実行するフラグ
  bool _initialized = false;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final showGameModeSelectDialogProvider =
        StateProvider<bool>((ref) => false);
    final showGameModeSelectDialog =
        ref.watch(showGameModeSelectDialogProvider);
    if (!_initialized) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showUserSettingsDialog(ref, context);
      });
      _initialized = true;
    }
    return Scaffold(
      body: Stack(
        alignment: Alignment.center, // Stack内の子要素を中央に配置
        children: [
          Center(
            child: Container(
              width: size.width,
              height: size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/titleScene.jpg'),
                  fit: BoxFit.cover, // 背景全体に画像を表示
                ),
              ),
            ),
          ),
          GameModeSelectDialog(),
          Positioned(
            top: size.height * 0.15,
            left: size.width * 0.1,
            child: RankingCircle(
              size: size.width * 0.15,
            ),
          ),
          // ]
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
