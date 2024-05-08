import 'dart:math';
import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saibai_men_app/common/const.dart';
import 'package:saibai_men_app/provider.dart';
import 'package:saibai_men_app/ui/gameUi.dart';

void initializeGameModeProvider(WidgetRef ref, Size size, DinoGame game) {
  final gameMode = ref.read(gameModeProvider);
  double speedTime = 0;
  if (gameMode == 1) {
    speedTime = 4;
    game.updateEnemyCreateTime(
        ref.read(enemyCreateTimeProvider.state).state = 2);
  } else if (gameMode == 2) {
    speedTime = 3;
    game.updateEnemyCreateTime(
        ref.read(enemyCreateTimeProvider.state).state = 1.2);
  }
  game.updateSpeed(
      ref.read(speedProvider.state).state =
          min(size.height, size.width) / speedTime,
      ref);
}

int modeGoal(WidgetRef ref) {
  final gameMode = ref.read(gameModeProvider);
  int goal = 0;
  if (gameMode == 1) {
    goal = modeScore1;
  }
  return goal;
}

int modeCreateEnemiesTime(WidgetRef ref) {
  final gameMode = ref.read(gameModeProvider);
  int goal = 0;
  if (gameMode == 1) {
    goal = 20;
  } else if (gameMode == 2) {
    goal = 30;
  }

  return goal;
}

double modeUpdateTime(WidgetRef ref) {
  double updateTime = 0.93;
  return updateTime;
}

double modeSpeedTime(WidgetRef ref) {
  double updateTime = 1.05;
  return updateTime;
}

double modeFeverCount(WidgetRef ref) {
  final gameMode = ref.read(gameModeProvider);
  double feverCount = 50;
  if (gameMode == 1) {
    feverCount = 20;
  } else if (gameMode == 2) {
    feverCount = 50;
  }
  return feverCount;
}
