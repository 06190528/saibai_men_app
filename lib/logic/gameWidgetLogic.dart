import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saibai_men_app/common/firebase/firebaseSave.dart';
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
  Future<void> onGameOver() async {
    final gameOverSprite = GameOverSprite(game.dinoPlayer.position);
    game.updateSpeed(0);
    game.stopGame();
    game.add(gameOverSprite);
    ref.read(showResultDialog.state).state = true;
    ref.read(bgmAudioProvider).setLoop(false);
    await ref.read(bgmAudioProvider).stop();
    explosionAudio.play('sounds/explosion.mp3');
    ref.read(isGameActiveProvider.state).state = false;
    game.removeEnemys();
    ref
        .read(userDataProvider.state)
        .state
        .scoreList
        .add(ref.read(enemyCounterProvider));
    setUserData(ref.read(userDataProvider.state).state);
    print(ref.read(userDataProvider.state).state.scoreList);
  }

  Future<void> enemyCount(int id) async {
    ref.read(enemyCounterProvider.state).state++;
    if (ref.read(enemyCounterProvider.state).state % 30 == 29) {
      game.updateSpeed(ref.read(speedProvider.state).state *= 1.05);
      ref
          .read(bgmAudioProvider)
          .setSpeed(ref.read(bgmSpeedProvider.state).state *= 1.05);
      game.updateTime(ref.read(timeProvider.state).state *= 0.9);
    } else if (ref.read(enemyCounterProvider.state).state % 30 == 10) {
      game.addDeathblow();
    }
    game.enemies.removeWhere((e) => e.id == id);
  }

  Future<void> onGamePause() async {
    ref.read(isGameActiveProvider.state).state = false;
    game.pauseEngine();
    ref.read(bgmAudioProvider).setLoop(false);
    await ref.read(bgmAudioProvider).stop();
    ref.read(pauseProvider.state).state = true;
  }

  Future<void> onGameResume() async {
    ref.read(isGameActiveProvider.state).state = true;
    game.resumeEngine();
    ref.read(bgmAudioProvider).setLoop(true);
    await ref.read(bgmAudioProvider).play('sounds/sub_bgm.mp3');
    ref.read(pauseProvider.state).state = false;
  }

  Future<void> onPressedStartButton() async {
    ref.read(isGameActiveProvider.state).state = true;
    final dinoGame = game;
    dinoGame.startGame();
    ref.read(createStartButtonFlag.state).state = false;
    ref.read(bgmAudioProvider).play('sounds/sub_bgm.mp3');
    ref.read(bgmAudioProvider).setLoop(true);
    game.updateSpeed(ref.read(speedProvider.state).state =
        min(screenSize.height, screenSize.width) / 2);
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
    game.updateSpeed(ref.read(speedProvider));
    ref.read(bgmAudioProvider).setLoop(true);
    await ref.read(bgmAudioProvider).play('sounds/sub_bgm.mp3');
    ref.read(pauseProvider.state).state = false;
  }
}
