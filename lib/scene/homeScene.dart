import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saibai_men_app/common/const.dart';
import 'package:saibai_men_app/common/data/firebaseSave.dart';
import 'package:saibai_men_app/common/language.dart';
import 'package:saibai_men_app/provider.dart';
import 'package:saibai_men_app/scene/gatyaScene.dart';
import 'package:saibai_men_app/scene/rankingScene.dart';
import 'package:saibai_men_app/ui/gameUi.dart';
import 'package:saibai_men_app/widget/characterFiled.dart';
import 'package:saibai_men_app/widget/customIconButton.dart';
import 'package:saibai_men_app/widget/dialog/gameModeSelectDialog.dart';
import 'package:saibai_men_app/widget/dialog/settingDialog.dart';
import 'package:saibai_men_app/widget/rankingCircleWidget.dart';
import 'package:saibai_men_app/widget/resultDialogWidget/doubleText.dart';
import 'package:saibai_men_app/widget/showCoinWidget.dart';
import 'dart:math' as math;

class HomeScene extends ConsumerWidget {
  HomeScene({Key? key}) : super(key: key);

  // 初回のみ実行するフラグ
  bool _initialized = false;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<characterPositon> _addedCharacterPositions =
        []; // 既に追加されたキャラクターの位置を追跡するリスト
    final size = MediaQuery.of(context).size;
    final screenSize = Vector2(size.width, size.height);
    final nowUserCharacter = ref.read(nowUserCharacterProvider);
    final characterSize = size.width * 0.15;
    final CharacterField characterField = CharacterField();
    final nowUserCharacterPosition =
        Vector2(size.width / 2, size.height - characterSize * 2);
    characterField.addBackground('titleScene.jpg');
    characterField.addCharacter(
        nowUserCharacter, characterSize * 2, nowUserCharacterPosition);
    _addedCharacterPositions
        .add(characterPositon(nowUserCharacter, nowUserCharacterPosition));
    final language = ref.watch(userDataProvider.notifier).state.language;
    addUserCharacters(_addedCharacterPositions, ref, size, screenSize,
        characterField, characterSize);
    if (!_initialized) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await saveUserDataFromLocalToProvider(ref);
        await showUserSettingsDialog(ref, context);
        await Future.delayed(const Duration(milliseconds: 1));
        if (isReleaseMode) {
          await getAndSaveRankingDataFromIFirebaseToProvider(ref);
        }
      });
      _initialized = true;
    }
    return Scaffold(
      body: GestureDetector(
        onTapUp: (TapUpDetails details) => identificatTouchedCharacter(
            details, _addedCharacterPositions, characterSize, ref),
        child: Stack(
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
                padding: EdgeInsets.symmetric(horizontal: 5),
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
                      Column(
                        children: [
                          CustomIconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GatyaScene()),
                              );
                            },
                            icon: Icons.card_giftcard,
                            iconSize: size.width * 0.06,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          IntrinsicWidth(
                            child: IntrinsicHeight(
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.all(1), // 適切なパディングを設定
                                    child: DoubleText(
                                      text:
                                          Language().translationGatya(language),
                                      fontSize: characterSize * 0.2,
                                      insideColor:
                                          Color.fromARGB(255, 255, 192, 1),
                                    ),
                                  )),
                            ),
                          ),
                        ],
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
            Positioned(
              top: size.height * 0.9,
              left: size.width * 0.5 - characterSize * 0.25 * 4,
              child: IntrinsicWidth(
                child: IntrinsicHeight(
                  child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(1), // 適切なパディングを設定
                        child: DoubleText(
                          text: Language().translationSortieCharacter(language),
                          fontSize: characterSize * 0.25,
                          insideColor: Color.fromARGB(255, 255, 192, 1),
                        ),
                      )),
                ),
              ),
            ),
          ],
        ),
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

class characterPositon {
  final int characterIndex;
  final Vector2 position;
  characterPositon(this.characterIndex, this.position);
}

void addUserCharacters(
  List<characterPositon> addedCharacterPositions,
  WidgetRef ref,
  Size size,
  Vector2 screenSize,
  CharacterField characterField,
  double characterSize,
) {
  final userCharacters = ref.watch(userDataProvider).userCharacters;
  final nowUserCharacter = ref.watch(userDataProvider).nowUserCharacter;
  for (int i = 0; i <= lastCharacterIndex; i++) {
    if ((userCharacters & (1 << i)) != 0) {
      final characterIndex = i;
      if (characterIndex == nowUserCharacter) {
        continue;
      }
      bool isOverlapping;
      Vector2 newPosition;
      final Vector2 offset = Vector2(size.width * 0.15, size.height * 0.15);
      final Vector2 adjustedScreenSize = screenSize - offset * 2;
      do {
        isOverlapping = false;
        newPosition = Vector2(
          math.Random().nextDouble() * adjustedScreenSize.x + offset.x,
          math.Random().nextDouble() * adjustedScreenSize.y + offset.y,
        );

        for (var i = 0; i < addedCharacterPositions.length; i++) {
          final position = addedCharacterPositions[i].position;
          if (position.distanceTo(newPosition) < characterSize * 2) {
            isOverlapping = true;
            break;
          }
        }
      } while (isOverlapping);
      characterField.addCharacter(characterIndex, characterSize, newPosition);
      addedCharacterPositions
          .add(characterPositon(characterIndex, newPosition));
    } else {
      continue;
    }
  }
}

Future<void> identificatTouchedCharacter(
  TapUpDetails details,
  List<characterPositon> addedCharacterPositions,
  double characterSize,
  WidgetRef ref,
) async {
  // タップされた座標を取得
  final tapPosition = details.localPosition;

  for (int i = 0; i < addedCharacterPositions.length; i++) {
    // 各キャラクターの中心座標を取得
    final characterCenter = addedCharacterPositions[i].position;

    final distance = (tapPosition.dx - characterCenter.x).abs() +
        (tapPosition.dy - characterCenter.y).abs();

    if (distance < characterSize / 2) {
      await updateNowUserCharacter(
          ref, addedCharacterPositions[i].characterIndex);
      break;
    }
  }
}

Future<void> updateNowUserCharacter(WidgetRef ref, int index) async {
  ref.read(nowUserCharacterProvider.state).state = index;
  ref.watch(dinoGameProvider.state).state =
      DinoGame(ref.read(nowUserCharacterProvider));
  ref.read(userDataProvider.notifier).updateNowUserCharacter(index);
  await UserDataService()
      .saveUserDataToLocal(ref.read(userDataProvider).toMap());
}
