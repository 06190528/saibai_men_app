import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:saibai_men_app/logic/directions.dart';
import 'package:saibai_men_app/ui/playerUi.dart';

int _enemyIdCounter = 0;

class Enemy extends SpriteAnimationComponent with HasGameRef {
  double speed;
  Direction direction = Direction.none;
  DinoPlayer dinoPlayer;
  Function(int id)? onGameOver;
  Function(int id)? EnemyCount;
  final int id;

  Enemy(this.speed, this.dinoPlayer, {this.onGameOver, this.EnemyCount})
      : id = _enemyIdCounter++,
        super(size: Vector2.all(0));

  void updateSpeed(double newSpeed) {
    speed = newSpeed;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();

    Image spriteSheetImage = await Flame.images
        .load('enemy_transparent_${enemyDirection(direction)}.png');

    final spriteSheet = SpriteSheet(
      image: spriteSheetImage,
      srcSize: enemySpriteSize(direction),
    );

    animation = spriteSheet.createAnimation(
      row: 0, // 使用する行
      stepTime: 0.1, // 各フレームの表示時間（秒）
      from: 0, // 開始フレーム
      to: 7, // 終了フレーム
    );
    anchor = Anchor.center;
    double squareSideLength = gameRef.size.x / 6;
    size = Vector2.all(squareSideLength);
  }

  @override
  void update(double dt) {
    super.update(dt);

    updatePosition(dt);
  }

  void updatePosition(double dt) {
    final double deltaPosition = speed * dt;
    Vector2 nextPosition = position.clone();
    Vector2 screenSize = gameRef.size;
    double radius = (size.length / 2 + dinoPlayer.size.length / 2) / 2;
    double distance = dinoPlayer.position.distanceTo(position);
    if (distance <= radius) {
      if (onGameOver != null) {
        onGameOver!(id);
      }
    }

    nextPosition.add(detectDirection(direction, deltaPosition));
    if (canGo(nextPosition, screenSize, size, 'enemy')) {
      position.setFrom(nextPosition); // 位置を更新
    } else {
      removeFromParent();
      EnemyCount!(id);
    }
  }

  void removeEnemy() {
    removeFromParent();
  }
}

String enemyDirection(Direction direction) {
  switch (direction) {
    case Direction.left:
      return 'left';
    case Direction.right:
      return 'right';
    case Direction.up:
      return 'up';
    case Direction.down:
      return 'down';
    default:
      return 'left';
  }
}

Vector2 enemySpriteSize(Direction direction) {
  switch (direction) {
    case Direction.left:
      return Vector2(556.5, 670);
    case Direction.right:
      return Vector2(557, 665);
    case Direction.up:
      return Vector2(557, 656);
    case Direction.down:
      return Vector2(556.5, 652);
    default:
      return Vector2(372, 432);
  }
}
