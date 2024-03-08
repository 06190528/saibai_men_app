import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saibai_men_app/common/data/firebaseSave.dart';
import 'package:saibai_men_app/common/userData.dart';
import 'package:saibai_men_app/logic/audio.dart';
import 'package:saibai_men_app/logic/gameModeLogic.dart';
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
  final bool evolutionSound1Flag = false;

  Future<void> gameClear() async {
    game.removeEnemys();
    game.updateSpeed(0, ref);
    game.stopGame();
    ref.read(bgmSpeedProvider.state).state = 1.0;
    ref.read(bgmAudioProvider).setLoop(false);
    ref.read(isGameActiveProvider.state).state = false;
    ref.read(userDataProvider).scoreList.add(ref.read(enemyCounterProvider));
    ref.read(showResultDialog.state).state = true;
    ref.read(kiAudioProvider).stop();
    await ref.read(bgmAudioProvider).stop();
    ref.read(bgmAudioProvider).play('sounds/game_clear.mp3');
    ref.read(gameClearFlagProvider.state).state = true;
    setUserDataToIFirebase(ref.read(userDataProvider));
    await UserDataService()
        .saveUserDataToLocal(ref.read(userDataProvider).toMap());
    addUserDataToRankingDataProvider(ref);
    setUserScoreMaxToProvider(ref);
  }

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
    await ref.read(bgmAudioProvider).stop();
    explosionAudio.play('sounds/explosion.mp3');
    setUserDataToIFirebase(ref.read(userDataProvider));
    await UserDataService()
        .saveUserDataToLocal(ref.read(userDataProvider).toMap());
    addUserDataToRankingDataProvider(ref);
    setUserScoreMaxToProvider(ref);
  }

  Future<void> enemyCount(int id) async {
    int enemyCount = ref.read(enemyCounterProvider.state).state;
    int gameMode = ref.read(gameModeProvider);
    ref.read(enemyCounterProvider.state).state++;
    ref.read(evolutionCountProvider.state).state++;
    if (ref.read(enemyCounterProvider) % 59 == 0) {
      for (int i = 0; i < 4; i++) {
        game.addEnemy();
      }
    }
    if (enemyCount % modeCreateEnemiesTime(ref) >=
        modeCreateEnemiesTime(ref) - 1) {
      game.updateSpeed(
          ref.read(speedProvider.state).state *= modeSpeedTime(ref), ref);
      game.updateTime(
          ref.read(enemyCreateTimeProvider.state).state *= modeUpdateTime(ref));
    } else if (enemyCount % 15 == 5) {
      //アイテムを出現させる
      game.addDeathblow();
      game.enemyKindsIncrement();
    }
    if (gameMode != 2) {
      if (enemyCount >= modeGoal(ref)) {
        gameClear();
      }
    }
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
    if (ref.read(gameModeProvider) == 0) {
      ref.watch(swipeFlagProvider.state).state = true;
      await Future.delayed(const Duration(milliseconds: 3000));
      ref.watch(swipeFlagProvider.state).state = false;
    }
    ref.read(isGameActiveProvider.state).state = true;
    final dinoGame = game;
    dinoGame.startGame();
    ref.read(bgmAudioProvider).play('sounds/bgm.mp3');
    ref.read(bgmAudioProvider).setLoop(true);
    ref.read(bgmAudioProvider).setVolume(0.3);
    initializeGameModeProvider(ref, screenSize, dinoGame);
    ref.read(deathblowCountProvider.state).state = 1;
    ref.read(evolutionCountProvider.state).state = 0;
  }

  Future<void> activateSpecialMove() async {
    ref.read(enemyCounterProvider.state).state += game.enemies.length;
    game.attackEnemy();
    ref.read(attackBgmProvider).play('sounds/specialMove.mp3');
    ref.read(goatSoundsProvider).play('sounds/goat_sounds2.mp3');
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
    await ref.read(bgmAudioProvider).play('sounds/bgm.mp3');
    ref.read(pauseProvider.state).state = false;
  }

  void evolution() async {
    print('evolution');
    ref.read(evolutionFlagProvider.state).state = true; // evolutionFlagを更新
    game.evolution();
    // Timer(const Duration(seconds: 3), () {
    //   ref.read(kiAudioProvider).play('sounds/ki1.2.mp3');
    //   ref.read(kiAudioProvider).setLoop(true);
    // });
    ref.read(evolutionBgmProvider).play('sounds/evolution_bgm.mp3');
    ref.read(evolutionBgmProvider).setLoop(true);
    print(
        'evolutionFlagProvider.state: ${ref.read(evolutionFlagProvider.state)}');
  }

  void deEvolution() {
    print('deEvolution');
    ref.read(kiAudioProvider).stop();
    ref.read(evolutionCountProvider.state).state = 0;
    ref.read(evolutionFlagProvider.state).state = false;
    ref.read(evolutionBgmProvider).stop();
    game.deEvolution();
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
    ref.read(enemyCreateTimeProvider.state).state = 1.2;
    ref.read(evolutionFlagProvider.state).state = false;
    ref.read(deathblowCountProvider.state).state = 1;
    ref.read(loadingRewardAdProvider.state).state = false;
    ref.read(kiAudioProvider).stop();
    ref.read(gameClearFlagProvider.state).state = false;
    ref.read(evolutionCountProvider.state).state = 0;
  }
}
