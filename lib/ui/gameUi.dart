import 'dart:math';

import 'package:flame/game.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saibai_men_app/common/const.dart';
import 'package:saibai_men_app/logic/directions.dart';
import 'package:saibai_men_app/provider.dart';
import 'package:saibai_men_app/ui/attackEnemyUi.dart';
import 'package:saibai_men_app/ui/deathblowUi.dart';
import 'package:saibai_men_app/ui/gameEnemyUi.dart';
import 'package:saibai_men_app/ui/kiUi.dart';
import 'playerUi.dart';
import 'worldUi.dart';

class DinoGameNotifier extends StateNotifier<DinoGame> {
  DinoGameNotifier() : super(DinoGame(0));

  void reset() {
    state = DinoGame(0);
  }
}

class DinoGame extends FlameGame {
  Function()? touchEnemy;
  Function(int id)? EnemyCount;
  Function()? getItem;
  double? speed;
  List<Enemy> enemies = [];
  List<Deathblow> deathblows = [];
  List<AttackEnemy> attackEnemies = [];
  double _timer = 0;
  bool isGameActive = false;
  int nowUserCharacter;
  late DinoPlayer dinoPlayer;
  final DinoWorld _dinoWorld = DinoWorld();
  late KiEffect kiEffect;
  int enemyKinds = 3; //初期の敵の種類

  double time = 1.2;
  bool enemyKindsAdditionalIncrement = false;
  DinoGame(this.nowUserCharacter,
      {this.speed, this.touchEnemy, this.EnemyCount, this.getItem});

  @override
  Future<void> onLoad() async {
    super.onLoad();
    if (!enemyKindsAdditionalIncrement && enemyKinds >= nowUserCharacter) {
      enemyKindsIncrement();
      enemyKindsAdditionalIncrement = true;
    }
    await add(_dinoWorld);
    dinoPlayer = DinoPlayer(nowUserCharacter);
    await add(dinoPlayer);
    kiEffect = KiEffect(dinoPlayer);
    dinoPlayer.position = _dinoWorld.size * 0.5; // 初期位置を設定
  }

  void fever() {
    add(kiEffect);
  }

  void defever() {
    kiEffect.removeKiEffect();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!isGameActive) {
      return;
    }
    _timer += dt;
    if (_timer >= time) {
      _timer = 0;
      addEnemy();
    }
  }

  void onArrowKeyChanged(Direction direction) {
    dinoPlayer.direction = direction;
  }

  Future<void> addEnemy() async {
    Enemy enemy = Enemy(speed!, dinoPlayer, enemyKinds, nowUserCharacter,
        onTouchEnemy: touchEnemy, EnemyCount: EnemyCount);
    enemy.position = initialPosition(_dinoWorld.size, 'enemy');
    enemy.direction = enemyInitialDirection(enemy.position, _dinoWorld.size);
    add(enemy);
    enemies.add(enemy);
  }

  void startGame() {
    isGameActive = true;
  }

  void stopGame() {
    isGameActive = false;
  }

  void removeEnemies() {
    for (var enemy in enemies) {
      enemy.removeEnemy();
    }
    enemies.clear();
  }

  void attackEnemy() async {
    for (var enemy in enemies) {
      enemy.removeEnemy();
      AttackEnemy attackEnemy = AttackEnemy(enemy.position, _dinoWorld.speed);
      add(attackEnemy);
      attackEnemies.add(attackEnemy);
    }
    enemies.clear();
    attackEnemies.clear();
  }

  void updateSpeed(double newSpeed, WidgetRef ref) {
    // 気をつけろ
    ref.read(bgmSpeedProvider.state).state *= 1.03;
    if (newSpeed == 0) {
      ref.read(bgmSpeedProvider.state).state = 1;
    }
    ;
    dinoPlayer.updateSpeed(newSpeed * 1.3);
    _dinoWorld.updateSpeed(newSpeed * 0.5);
    for (var enemy in enemies) {
      enemy.updateSpeed(newSpeed);
    }
    for (var deathblow in deathblows) {
      deathblow.updateSpeed(newSpeed * 0.5);
    }
  }

  void updateTime(double newTime) {
    time = newTime;
  }

  void addDeathblow() {
    Deathblow deathblow =
        Deathblow(speed!, dinoPlayer, activateSpecialMove: getItem);
    deathblow.position = initialPosition(_dinoWorld.size, 'deathblow');
    deathblow.direction = Direction.down;
    deathblow.updateSpeed(_dinoWorld.speed);
    add(deathblow);
    deathblows.add(deathblow);
  }

  void removeDeathblow() {
    for (var deathblow in deathblows) {
      deathblow.removeDeathblow();
    }
    deathblows.clear();
  }

  void enemyKindsIncrement() {
    if (enemyKinds < lastCharacterIndex) enemyKinds++;
    if (!enemyKindsAdditionalIncrement && enemyKinds == nowUserCharacter) {
      enemyKindsIncrement();
      enemyKindsAdditionalIncrement = true;
    }
    // print('enemyKindsIncrement:$enemyKinds');
  }
}
