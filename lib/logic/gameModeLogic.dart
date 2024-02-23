import 'dart:math';
import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saibai_men_app/common/const.dart';
import 'package:saibai_men_app/provider.dart';
import 'package:saibai_men_app/ui/gameUi.dart';

void initializeGameModeProvider(WidgetRef ref, Size size, DinoGame game) {
  final gameMode = ref.read(gameModeProvider);
  double speedTime = 0;
  if (gameMode == 0) {
    speedTime = 7;
    game.updateTime(ref.read(enemyCreateTimeProvider.state).state = 4);
  } else if (gameMode == 1) {
    speedTime = 5;
    game.updateTime(ref.read(enemyCreateTimeProvider.state).state = 2);
  } else if (gameMode == 2) {
    speedTime = 3;
    game.updateTime(ref.read(enemyCreateTimeProvider.state).state = 1.2);
  }
  game.updateSpeed(
      ref.read(speedProvider.state).state =
          min(size.height, size.width) / speedTime,
      ref);
}

int modeGoal(WidgetRef ref) {
  final gameMode = ref.read(gameModeProvider);
  int goal = 0;
  if (gameMode == 0) {
    goal = modeScore0;
  } else if (gameMode == 1) {
    goal = modeScore1;
  }
  return goal;
}

int modeCreateEnemiesTime(WidgetRef ref) {
  final gameMode = ref.read(gameModeProvider);
  int goal = 0;
  if (gameMode == 0) {
    goal = 10;
  } else if (gameMode == 1) {
    goal = 20;
  } else if (gameMode == 2) {
    goal = 30;
  }

  return goal;
}

double modeUpdateTime(WidgetRef ref) {
  double updateTime = 0.93;
  final gameMode = ref.read(gameModeProvider);
  if (gameMode == 0) {
    updateTime = 0.9;
  }
  return updateTime;
}

double modeSpeedTime(WidgetRef ref) {
  double updateTime = 1.05;
  final gameMode = ref.read(gameModeProvider);
  if (gameMode == 0) {
    updateTime = 1.15;
  }
  return updateTime;
}

double modeEvolutionCount(WidgetRef ref) {
  double evolutionCount = 0;
  final gameMode = ref.read(gameModeProvider);
  if (gameMode == 0) {
    evolutionCount = (modeScore0 / 2) as double;
  } else if (gameMode == 1) {
    evolutionCount = (modeScore1 / 2) as double;
  } else if (gameMode == 2) {
    evolutionCount = (modeScore2 / 2) as double;
    print("evolutionCount: $evolutionCount");
  }
  return evolutionCount;
}
