import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saibai_men_app/common/data/firebaseSave.dart';
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
  final bool feverSound1Flag = false;

  Future<void> gameClear() async {
    game.removeEnemies();
    game.updateSpeed(0, ref);
    game.stopGame();
    ref.read(bgmSpeedProvider.state).state = 1.0;
    ref.read(bgmAudioProvider).setLoop(false);
    ref.read(isGameActiveProvider.state).state = false;
    ref.read(userDataProvider).scoreList.add(ref.read(enemyCounterProvider));
    ref.read(showResultDialog.state).state = true;
    await ref.read(bgmAudioProvider).stop();
    ref.read(feverBgmProvider).stop();
    await ref.read(bgmAudioProvider).play('sounds/game_clear.mp3');
    ref.read(gameClearFlagProvider.state).state = true;
    await getCoin();
    print('gameClear');
    setUserDataToIFirebase(ref.read(userDataProvider));
    await UserDataService()
        .saveUserDataToLocal(ref.read(userDataProvider).toMap());
    addUserNewMaxScoreToRankingListProviderAndGetUserRanking(ref);
  }

  Future<void> onGameOver() async {
    final gameOverSprite = GameOverSprite(game.dinoPlayer.position);
    game.removeEnemies();
    game.updateSpeed(0, ref);
    game.stopGame();
    game.add(gameOverSprite);
    ref.read(bgmAudioProvider).setLoop(false);
    ref.read(isGameActiveProvider.state).state = false;
    ref.read(userDataProvider).scoreList.add(ref.read(enemyCounterProvider));
    ref.read(showResultDialog.state).state = true;
    await ref.read(bgmAudioProvider).stop();
    ref.read(feverBgmProvider).stop();
    await explosionAudio.play('sounds/explosion.mp3');
    await getCoin();
    setUserDataToIFirebase(ref.read(userDataProvider));
    await UserDataService()
        .saveUserDataToLocal(ref.read(userDataProvider).toMap());
    addUserNewMaxScoreToRankingListProviderAndGetUserRanking(
      ref,
    );
  }

  Future<void> enemyCount(int id) async {
    int enemyCount = ref.read(enemyCounterProvider.state).state;
    int gameMode = ref.read(gameModeProvider);
    ref.read(enemyCounterProvider.state).state++;
    ref.read(feverCountProvider.state).state++;
    if (ref.read(enemyCounterProvider) % 49 == 0) {
      for (int i = 0; i < 6; i++) {
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
    ref.read(feverBgmProvider).stop();
  }

  Future<void> onGameResume() async {
    ref.read(isGameActiveProvider.state).state = true;
    game.resumeEngine();
    ref.read(bgmAudioProvider).setLoop(true);
    await ref.read(bgmAudioProvider).resume();
    ref.read(pauseProvider.state).state = false;
    if (ref.read(feverFlagProvider.state).state)
      ref.read(feverBgmProvider).resume();
  }

  Future<void> onPressedStartButton() async {
    if (ref.read(gameModeProvider) == 1 &&
        ref.read(userMaxScoreProvider) < 50) {
      ref.watch(swipeFlagProvider.state).state = true;
      await Future.delayed(const Duration(milliseconds: 2000));
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
    ref.read(feverCountProvider.state).state = 0;
    ref.read(enemyCounterProvider.state).state = 1000;
  }

  Future<void> activateSpecialMove() async {
    ref.read(enemyCounterProvider.state).state += game.enemies.length;
    if (!ref.watch(feverFlagProvider)) {
      ref.read(feverCountProvider.state).state += game.enemies.length;
    }
    game.attackEnemy();
    ref.read(attackBgmProvider).play('sounds/specialMove.mp3');
    ref.read(goatSoundsProvider).play('sounds/goat_sounds2.mp3');
    ref.read(deathblowCountProvider.state).state--;
  }

  Future<void> continueGame() async {
    ref.read(isLoadingProvider.state).state = false;
    ref.read(usedContinueProvider.state).state = true;
    game.startGame();
    ref.read(isGameActiveProvider.state).state = true;
    ref.read(showResultDialog.state).state = false;
    game.updateSpeed(ref.read(speedProvider), ref);
    ref.read(bgmAudioProvider).setLoop(true);
    await ref.read(bgmAudioProvider).play('sounds/bgm.mp3');
    ref.read(pauseProvider.state).state = false;
  }

  void fever() async {
    ref.read(feverFlagProvider.state).state = true; // feverFlagを更新
    game.fever();
    ref.read(feverBgmProvider).play('sounds/fever_bgm.mp3');
    ref.read(feverBgmProvider).setLoop(true);
    print('feverFlagProvider.state: ${ref.read(feverFlagProvider.state)}');
  }

  void deFever() {
    final gameOverSprite = GameOverSprite(game.dinoPlayer.position);
    game.add(gameOverSprite);
    explosionAudio.play('sounds/explosion.mp3');
    print('defever');
    ref.read(feverCountProvider.state).state = 0;
    ref.read(feverFlagProvider.state).state = false;
    ref.read(feverBgmProvider).stop();
    game.defever();
  }

  void getItem() {
    ref.read(deathblowCountProvider.state).state++;
    ref.read(goatSoundsProvider).play('sounds/goat_sounds2.mp3');
  }

  Future<void> getCoin() async {
    final enemyCount = ref.read(enemyCounterProvider);
    final coin = (enemyCount / 100).floor();
    ref.read(getCoinCountProvider.state).state =
        ref.read(userDataProvider).coin;
    final coinSound = Audio(); // 1つのインスタンスを作成

    for (var i = 0; i < coin; i++) {
      coinSound.play('sounds/getCoinSound.mp3');
      await Future.delayed(Duration(milliseconds: 250)); // 0.2秒待つ
      if (i != coin - 1) coinSound.stop();
      ref.read(getCoinCountProvider.state).state++;
    }
    ref
        .read(userDataProvider.notifier)
        .updateUserCoinData(ref.read(getCoinCountProvider));
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
    ref.read(feverFlagProvider.state).state = false;
    ref.read(deathblowCountProvider.state).state = 1;
    ref.read(isLoadingProvider.state).state = false;
    ref.read(gameClearFlagProvider.state).state = false;
    ref.read(feverCountProvider.state).state = 0;
    ref.read(feverBgmProvider).stop();
  }
}
