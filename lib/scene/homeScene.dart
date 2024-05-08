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
import 'package:saibai_men_app/widget/resultDialogWidget/buttonWidget.dart';
import 'package:saibai_men_app/widget/resultDialogWidget/doubleText.dart';
import 'package:saibai_men_app/widget/showCoinWidget.dart';

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
    final characterSize = size.width * 0.1;
    final CharacterField characterField = CharacterField();
    final nowUserCharacterPosition =
        Vector2(size.width / 2, size.height - characterSize * 3);
    characterField.addBackground('titleScene.jpg');
    _addedCharacterPositions
        .add(characterPositon(nowUserCharacter, nowUserCharacterPosition));
    final language = ref.watch(userDataProvider).language;
    addUserCharactersToFiled(_addedCharacterPositions, ref, size, screenSize,
        characterField, characterSize, nowUserCharacterPosition);
    if (!_initialized) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await saveUserDataFromLocalToProvider(ref);
        await showUserSettingsDialog(ref, context);
        await Future.delayed(const Duration(milliseconds: 1));
        if (isReleaseMode) {
          // await getAndSaveRankingDataFromIFirebaseToProvider(ref);
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
              child: BannerButton(
                text: Language().translationStart(language),
                onPressed: () => showDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierColor: Colors.transparent,
                  builder: (BuildContext context) {
                    return GameModeSelectDialog();
                  },
                ),
                width: size.width * 0.4,
                icon: Icons.play_arrow,
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
                bottom: size.height * 0.5,
                right: size.width * 0.5,
                child: const CircularProgressIndicator(),
              )
            ],
            Positioned(
              bottom: size.height * 0.12,
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

Future<void> addUserCharactersToFiled(
  List<characterPositon> addedCharacterPositions,
  WidgetRef ref,
  Size size,
  Vector2 screenSize,
  CharacterField characterField,
  double characterSize,
  Vector2 nowUserCharacterPosition,
) async {
  await setSpriteSheetImagesProvider(ref);
  final userCharacters = ref.watch(userDataProvider).userCharacters;
  final nowUserCharacter = ref.watch(userDataProvider).nowUserCharacter;
  final spriteImages = ref.watch(spriteSheetImagesProvider);
  for (int i = 0; i <= lastCharacterIndex; i++) {
    if ((userCharacters & (1 << i)) != 0) {
      final characterIndex = i;
      if (characterIndex == nowUserCharacter) {
        characterField.addCharacter(
          nowUserCharacter,
          characterSize * 2.5,
          nowUserCharacterPosition,
          spriteImages[characterIndex],
        );
        continue;
      }
      const int characterNum = 8;
      var posX = i % characterNum;
      var posY = (i / characterNum).toInt();
      Vector2 newPosition;
      final Vector2 offset =
          Vector2(size.width * 0.1, size.height * 0.2); // 画面の端からのオフセット
      final Vector2 adjustedScreenSize = screenSize - offset * 2;
      newPosition = Vector2(
        posX * (adjustedScreenSize.x) / characterNum +
            offset.x +
            characterSize / 2,
        posY * (adjustedScreenSize.y * 1.2) / characterNum +
            offset.y +
            characterSize / 2,
      );

      characterField.addCharacter(characterIndex, characterSize, newPosition,
          spriteImages[characterIndex]);
      addedCharacterPositions
          .add(characterPositon(characterIndex, newPosition));
    } else {
      continue;
    }
    await Future.delayed(Duration.zero);
  }
}

Future<void> identificatTouchedCharacter(
  TapUpDetails details,
  List<characterPositon> addedCharacterPositions,
  double characterSize,
  WidgetRef ref,
) async {
  final tapPosition = details.localPosition;

  for (int i = 0; i < addedCharacterPositions.length; i++) {
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
