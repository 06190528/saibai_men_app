import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saibai_men_app/common/const.dart';
import 'package:saibai_men_app/common/data/firebaseSave.dart';
import 'package:saibai_men_app/provider.dart';
import 'package:saibai_men_app/scene/gatyaScene.dart';
import 'package:saibai_men_app/scene/rankingScene.dart';
import 'package:saibai_men_app/widget/characterFiled.dart';
import 'package:saibai_men_app/widget/customIconButton.dart';
import 'package:saibai_men_app/widget/dialog/gameModeSelectDialog.dart';
import 'package:saibai_men_app/widget/dialog/settingDialog.dart';
import 'package:saibai_men_app/widget/rankingCircleWidget.dart';
import 'package:saibai_men_app/widget/showCoinWidget.dart';

class HomeScene extends ConsumerWidget {
  HomeScene({Key? key}) : super(key: key);

  // 初回のみ実行するフラグ
  bool _initialized = false;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final CharacterField characterField = CharacterField();
    characterField.addBackground('titleScene.jpg');
    characterField.addCharacter(
        8, size.height / 2, Vector2(size.width / 2, size.height / 2));
    if (!_initialized) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await saveUserDataFromLocalToProvider(ref);
        if (isReleaseMode) {
          await getAndSaveRankingDataFromIFirebaseToProvider(ref);
        }
        showUserSettingsDialog(ref, context);
      });
      _initialized = true;
    }
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: GameWidget(
              game: characterField,
            ),
          ),
          Positioned(
            top: size.height * 0.05,
            left: size.width * 0.05,
            child: RankingCircle(
              size: size.width * 0.15,
            ),
          ),
          Positioned(
            bottom: size.height * 0.05,
            left: size.width * 0.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomIconButton(
                  onPressed: () => showSettingsDialog(context),
                  icon: Icons.settings,
                  iconSize: size.width * 0.06,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  borderRadius: BorderRadius.circular(10),
                ),
                CustomIconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RankingWidget()),
                    );
                  },
                  icon: Icons.leaderboard,
                  iconSize: size.width * 0.06,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  borderRadius: BorderRadius.circular(10),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: size.height * 0.05,
            right: size.width * 0.05,
            child: CustomIconButton(
              onPressed: () => showDialog(
                context: context,
                barrierDismissible: true,
                barrierColor: Colors.transparent,
                builder: (BuildContext context) {
                  return GameModeSelectDialog();
                },
              ),
              icon: Icons.play_arrow,
              iconSize: size.width * 0.06,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Positioned(
            top: size.height * 0.05,
            right: size.width * 0.05,
            child: Column(
              children: [
                ShowCoinWidget(
                  width: size.width * 0.2,
                  height: size.height * 0.07,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomIconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GatyaScene()),
                        );
                      },
                      icon: Icons.card_giftcard,
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
          if (ref.watch(isLoadingProvider)) ...[
            Positioned(
              bottom: size.height * 0.5, // 下から10%の位置に配置
              right: size.width * 0.5,
              child: const CircularProgressIndicator(),
            )
          ],
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
