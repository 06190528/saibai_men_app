import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saibai_men_app/common/data/firebaseSave.dart';
import 'package:saibai_men_app/logic/audio.dart';
import 'package:saibai_men_app/provider.dart';
import 'package:saibai_men_app/ui/explosionUi.dart';
import 'package:saibai_men_app/ui/gameUi.dart';

class GameWidgetLogic {
  WidgetRef ref;
  BuildContext context;

  GameWidgetLogic(this.context, this.ref);
  late DinoGame game = ref.read(dinoGameProvider);
  late Audio explosionAudio = ref.read(explosionAudioProvider);
  late Size screenSize = MediaQuery.of(context).size;
  bool evolutionSound1Flag = false;
  Future<void> onGameOver() async {
    final gameOverSprite = GameOverSprite(game.dinoPlayer.position);
    game.removeEnemys();
    game.updateSpeed(0, ref);
    game.stopGame();
    game.add(gameOverSprite);
    ref.read(bgmAudioProvider).setLoop(false);
    ref.read(isGameActiveProvider.state).state = false;
    ref.read(userDataProvider).scoreList.add(ref.read(enemyCounterProvider));
    ref.read(showResultDialog.state).state = true;
    ref.read(kiAudioProvider).stop();
    game.updateTime(ref.read(timeProvider.state).state = 1.2);
    await ref.read(bgmAudioProvider).stop();
    explosionAudio.play('sounds/explosion.mp3');
    setUserDataToIFirebase(ref.read(userDataProvider));
    await UserDataService()
        .saveUserDataToLocal(ref.read(userDataProvider).toMap());
    addUserDataToRankingDataProvider(ref);
  }

  Future<void> enemyCount(int id) async {
    final bool evolutionFlag = ref.read(evolutionFlagProvider.state).state;
    int enemyCount = ref.read(enemyCounterProvider.state).state;
    ref.read(enemyCounterProvider.state).state++;
    if (ref.read(enemyCounterProvider) % 59 == 0) {
      for (int i = 0; i < 4; i++) {
        game.addEnemy();
      }
    }
    if (enemyCount % 30 >= 29) {
      game.updateSpeed(ref.read(speedProvider.state).state *= 1.05, ref);
      game.updateTime(ref.read(timeProvider.state).state *= 0.93);
    } else if (enemyCount % 25 == 10) {
      game.addDeathblow();
    }
    // if (enemyCount / 1 > 1 && evolutionFlag == false) {
    //   ref.read(evolutionFlagProvider.state).state = true;
    //   evolution();
    // }
    game.enemies.removeWhere((e) => e.id == id);
  }

  Future<void> onGamePause() async {
    ref.read(isGameActiveProvider.state).state = false;
    game.pauseEngine();
    ref.read(bgmAudioProvider).setLoop(false);
    await ref.read(bgmAudioProvider).stop();
    ref.read(pauseProvider.state).state = true;
    ref.read(kiAudioProvider).stop();
  }

  Future<void> onGameResume() async {
    ref.read(isGameActiveProvider.state).state = true;
    game.resumeEngine();
    ref.read(bgmAudioProvider).setLoop(true);
    await ref.read(bgmAudioProvider).resume();
    ref.read(pauseProvider.state).state = false;
    ref.read(kiAudioProvider).resume();
  }

  Future<void> onPressedStartButton() async {
    ref.read(isGameActiveProvider.state).state = true;
    final dinoGame = game;
    dinoGame.startGame();
    ref.read(bgmAudioProvider).play('sounds/bgm.wav');
    ref.read(bgmAudioProvider).setLoop(true);
    ref.read(bgmAudioProvider).setVolume(0.3);
    game.updateSpeed(
        ref.read(speedProvider.state).state =
            min(screenSize.height, screenSize.width) / 2.8,
        ref);
    ref.read(deathblowCountProvider.state).state = 0;
  }

  Future<void> activateSpecialMove() async {
    ref.read(enemyCounterProvider.state).state += game.enemies.length;
    game.attackEnemy();
    ref.read(attackBgmProvider).play('sounds/specialMove.mp3');
    ref.read(deathblowCountProvider.state).state--;
  }

  Future<void> continueGame() async {
    ref.read(loadingRewardAdProvider.state).state = false;
    ref.read(usedContinueProvider.state).state = true;
    game.startGame();
    ref.read(isGameActiveProvider.state).state = true;
    ref.read(showResultDialog.state).state = false;
    game.updateSpeed(ref.read(speedProvider), ref);
    ref.read(bgmAudioProvider).setLoop(true);
    await ref.read(bgmAudioProvider).play('sounds/bgm.wav');
    ref.read(pauseProvider.state).state = false;
  }

  void evolution() async {
    game.evolution();
    // 最初のサウンドを再生します。
    ref.read(kiAudioProvider).play('sounds/ki1.1.mp3');
    await Future.delayed(const Duration(milliseconds: 1800));
    ref.read(kiAudioProvider).play('sounds/ki1.2.mp3');
    ref.read(kiAudioProvider).setLoop(true);
  }

  void resetAllProvider() {
    ref.read(dinoGameProvider.notifier).reset();
    ref.read(showResultDialog.state).state = false;
    ref.read(enemyCounterProvider.state).state = 0;
    ref.read(isGameActiveProvider.state).state = false;
    ref.read(createStartButtonFlag.state).state = true;
    ref.read(pauseProvider.state).state = false;
    ref.read(bgmAudioProvider).stop();
    ref.read(usedContinueProvider.state).state = false;
    ref.read(bgmSpeedProvider.state).state = 1.0;
    ref.read(speedProvider.state).state = 0;
    ref.read(timeProvider.state).state = 1.2;
    ref.read(evolutionFlagProvider.state).state = false;
    ref.read(deathblowCountProvider.state).state = 0;
    ref.read(loadingRewardAdProvider.state).state = false;
    ref.read(kiAudioProvider).stop();
  }
}
