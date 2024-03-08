import 'package:flame/game.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saibai_men_app/logic/directions.dart';
import 'package:saibai_men_app/provider.dart';
import 'package:saibai_men_app/ui/attackEnemyUi.dart';
import 'package:saibai_men_app/ui/deathblowUi.dart';
import 'package:saibai_men_app/ui/enemyUi.dart';
import 'package:saibai_men_app/ui/kiUi.dart';
import 'playerUi.dart';
import 'worldUi.dart';

class DinoGameNotifier extends StateNotifier<DinoGame> {
  DinoGameNotifier() : super(DinoGame(speed: null));

  void reset() {
    state = DinoGame(speed: null);
  }
}

class DinoGame extends FlameGame {
  Function(int id)? onGameOver;
  Function(int id)? EnemyCount;
  Function()? activateSpecialMove;
  double? speed;
  List<Enemy> enemies = [];
  List<Deathblow> deathblows = [];
  List<AttackEnemy> attackEnemies = [];
  double _timer = 0;
  bool isGameActive = false;
  final DinoPlayer dinoPlayer = DinoPlayer();
  final DinoWorld _dinoWorld = DinoWorld();
  late KiEffect kiEffect;
  int enemyKinds = 3;

  double time = 1.2;

  DinoGame(
      {required this.speed,
      this.onGameOver,
      this.EnemyCount,
      this.activateSpecialMove});

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await add(_dinoWorld);
    await add(dinoPlayer);
    kiEffect = KiEffect(dinoPlayer);
    dinoPlayer.position = _dinoWorld.size * 0.5; // 初期位置を設定
  }

  void evolution() {
    add(kiEffect);
  }

  void deEvolution() {
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
    Enemy enemy = Enemy(speed!, dinoPlayer, enemyKinds,
        onGameOver: onGameOver, EnemyCount: EnemyCount);
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

  void removeEnemys() {
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
    ref
        .read(bgmAudioProvider)
        .setSpeed(ref.read(bgmSpeedProvider.state).state *= 1.03);
    if (newSpeed == 0) {
      ref
          .read(bgmAudioProvider)
          .setSpeed(ref.read(bgmSpeedProvider.state).state *= 1);
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
    print('updateTime: $time');
  }

  void addDeathblow() {
    Deathblow deathblow =
        Deathblow(speed!, dinoPlayer, activateSpecialMove: activateSpecialMove);
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
    if (enemyKinds < 11) enemyKinds++;
  }
}
