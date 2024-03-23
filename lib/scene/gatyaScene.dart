import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saibai_men_app/common/const.dart';
import 'package:saibai_men_app/common/data/firebaseSave.dart';
import 'package:saibai_men_app/common/language.dart';
import 'package:saibai_men_app/logic/audio.dart';
import 'package:saibai_men_app/provider.dart';
import 'package:saibai_men_app/widget/characterFiled.dart';
import 'package:saibai_men_app/widget/dialog/showGetCharacter.dart';
import 'package:saibai_men_app/widget/showCoinWidget.dart';
import 'dart:math' as math;

final onTapedProvider = StateProvider<bool>((ref) => false);

class GatyaScene extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onTaped = ref.watch(onTapedProvider);
    final size = MediaQuery.of(context).size;
    final language = ref.watch(userDataProvider.notifier).state.language;
    final coinCount = ref.watch(getCoinCountProvider);
    final touchAvailable = coinCount >= 5;
    final animetionText = touchAvailable
        ? Language().translationTouch(language)
        : Language().translationNotEnoughCoins(language);
    final left = touchAvailable ? size.width * 0.30 : size.width * 0.05;
    final CharacterField characterField = CharacterField();
    characterField.addBackground('titleScene.jpg');
    characterField.addGatya(
        size.height / 2, Vector2(size.width / 2, size.height / 2), onTaped);
    Audio sound = Audio();
    return Scaffold(
      body: GestureDetector(
        onTap: () async {
          if (!onTaped) {
            if (coinCount < 5) {
              return;
            }
            sound.play('sounds/gatyaSound.mp3');
            ref.read(onTapedProvider.state).state = true;
            math.Random random = math.Random();
            ref.read(getCoinCountProvider.state).state -= 5;
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
                  return ShowGetCharacter(
                      characterIndex: random.nextInt(lastCharacterIndex + 1));
                },
              );
              Future.delayed(const Duration(milliseconds: 1600), () {
                sound.dispose();
              });
            });
          }
        },
        child: Stack(
          children: [
            Center(
              child: GameWidget(
                game: characterField,
              ),
            ),
            Positioned(
                top: size.height * 0.05,
                right: size.width * 0.05,
                child: ShowCoinWidget(
                    width: size.width * 0.2, height: size.height * 0.07)),
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
            if (ref.watch(isLoadingProvider)) ...[
              Positioned(
                bottom: size.height * 0.5, // 下から10%の位置に配置
                right: size.width * 0.5,
                child: const CircularProgressIndicator(),
              )
            ],
          ],
        ),
      ),
    );
  }
}
