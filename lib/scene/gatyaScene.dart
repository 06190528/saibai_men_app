import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saibai_men_app/common/const.dart';
import 'package:saibai_men_app/common/data/firebaseSave.dart';
import 'package:saibai_men_app/common/language.dart';
import 'package:saibai_men_app/logic/audio.dart';
import 'package:saibai_men_app/logic/gameWidgetLogic.dart';
import 'package:saibai_men_app/provider.dart';
import 'package:saibai_men_app/widget/characterFiled.dart';
import 'package:saibai_men_app/widget/dialog/showGetCharacter.dart';
import 'package:saibai_men_app/widget/resultDialogWidget/buttonWidget.dart';
import 'package:saibai_men_app/widget/showCoinWidget.dart';
import 'dart:math' as math;

final onTapedGatyaScreenProvider = StateProvider<bool>((ref) => false);
final onTapedGatyaButtonProvider = StateProvider<bool>((ref) => false);

class GatyaScene extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onTaped = ref.watch(onTapedGatyaScreenProvider);
    final size = MediaQuery.of(context).size;
    final language = ref.watch(userDataProvider.notifier).state.language;
    final coinCount = ref.watch(getCoinCountProvider);
    final touchAvailable = coinCount >= gaytaOnceCoin;
    final animetionText = touchAvailable
        ? Language().translationTouch(language)
        : Language().translationNotEnoughCoins(language);
    final left = touchAvailable ? size.width * 0.30 : size.width * 0.05;
    final onTapedGatyaButton = ref.watch(onTapedGatyaButtonProvider);
    final CharacterField characterField = CharacterField();
    characterField.addBackground('titleScene.jpg');
    characterField.addGatya(
        size.height / 2, Vector2(size.width / 2, size.height / 2), onTaped);
    Audio sound = Audio();
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: GameWidget(
              game: characterField,
            ),
          ),
          if (onTapedGatyaButton) ...[
            if (ref.watch(isLoadingProvider)) ...[
              Positioned(
                bottom: size.height * 0.5, // 下から10%の位置に配置
                right: size.width * 0.5,
                child: const CircularProgressIndicator(),
              )
            ],
            if (!onTaped)
              Positioned(
                top: size.height * 0.5,
                left: left,
                child: AnimatedTextKit(
                  pause: const Duration(milliseconds: 0),
                  repeatForever: true, // アニメーションを無限に繰り返す
                  isRepeatingAnimation: true,
                  animatedTexts: [
                    ScaleAnimatedText(
                      animetionText,
                      textStyle: TextStyle(
                        fontSize: size.width * 0.1, // フォントサイズ
                        fontWeight: FontWeight.bold, // フォントの太さ
                        fontStyle: FontStyle.italic, // フォントスタイルをイタリックに
                        color: Colors.black, // テキストの色
                        shadows: const [
                          Shadow(
                            blurRadius: 1.0,
                            color: Colors.black,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            GestureDetector(
              onTap: () async {
                if (!onTaped) {
                  onPressedGatya(context, ref, sound);
                }
              },
            ),
          ],
          if (!onTapedGatyaButton) ...[
            Positioned(
              left: size.width * 0.15,
              bottom: size.height * 0.1,
              child: Column(
                children: [
                  BannerButton(
                    text: Language().translationGatyaByCoins(language),
                    onPressed: () {
                      ref.read(onTapedGatyaButtonProvider.state).state = true;
                    },
                    width: size.width * 0.7,
                    icon: Icons.monetization_on,
                  ),
                  SizedBox(height: size.height * 0.05),
                  BannerButton(
                    text: Language().translationGetCoins(language),
                    onPressed: () {
                      GameWidgetLogic(context, ref).watchRewardAd(
                          size.width * 0.05,
                          () => GameWidgetLogic(context, ref)
                              .getCoin(gaytaOnceCoin * 2));
                    },
                    width: size.width * 0.7,
                    icon: Icons.ad_units,
                  ),
                ],
              ),
            ),
            // Positioned(
            //   bottom: size.height * 0.05,
            //   left: size.width * 0.05,
            //   child: BannerButton(
            //     text: '',
            //     onPressed: () {
            //       Navigator.pop(context);
            //     },
            //     width: size.width * 0.1,
            //     icon: Icons.arrow_back,
            //   ),
            // ),
          ],
          Positioned(
              top: size.height * 0.05,
              right: size.width * 0.05,
              child: ShowCoinWidget(
                  width: size.width * 0.2, height: size.height * 0.07)),
        ],
      ),
    );
  }
}

Future<void> onPressedGatya(
    BuildContext context, WidgetRef ref, Audio sound) async {
  final coinCount = ref.watch(getCoinCountProvider);
  if (coinCount < gaytaOnceCoin) {
    return;
  }
  sound.play('sounds/gatyaSound.mp3');
  ref.read(onTapedGatyaScreenProvider.state).state = true;
  math.Random random = math.Random();
  final randamNumber = random.nextInt(lastCharacterIndex + 1);
  ref.read(getCoinCountProvider.state).state -= gaytaOnceCoin;
  ref
      .read(userDataProvider.notifier)
      .updateUserCoinData(ref.read(getCoinCountProvider.state).state);
  await UserDataService()
      .saveUserDataToLocal(ref.read(userDataProvider).toMap());
  Future.delayed(const Duration(milliseconds: 1600), () {
    sound.play('sounds/getCharacter.mp3');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ShowGetCharacter(characterIndex: randamNumber);
      },
    );
    Future.delayed(const Duration(milliseconds: 1600), () {
      sound.dispose();
    });
  });
  adduserCharactersAndSaveToLocal(ref, randamNumber);
}

Future<void> adduserCharactersAndSaveToLocal(WidgetRef ref, int random) async {
  final nowuserCharacters = ref.read(userDataProvider).userCharacters;
  final newuserCharacters = nowuserCharacters | (1 << random);
  ref
      .read(userDataProvider.notifier)
      .updateUserCharactersData(newuserCharacters);
  await UserDataService()
      .saveUserDataToLocal(ref.read(userDataProvider).toMap());
}
