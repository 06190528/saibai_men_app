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
    // ここで画像のサイズを調整します。
    // double scaleFactor = 2.0;
    // size = Vector2(gameRef.size.x / 4 * scaleFactor, gameRef.size.y / 4);

    Image spriteSheetImage = await Flame.images
        .load('enemy_transparent_${enemyDirection(direction)}.png');
    final int spriteCount = enemySpriteCount(direction);
    final double spriteHeight = spriteSheetImage.height.toDouble() / 2 + 10;
    final double spriteWidth = spriteSheetImage.width.toDouble() / spriteCount;

    final spriteSheet = SpriteSheet(
      image: spriteSheetImage,
      srcSize: Vector2(spriteWidth, spriteHeight),
    );

    animation = spriteSheet.createAnimation(
      row: 0,
      stepTime: 0.1,
      from: 0,
      to: spriteCount * 2 - 1,
      loop: true,
    );

    anchor = Anchor.center;
    double squareSideLength = gameRef.size.y / 15;
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

int enemySpriteCount(Direction direction) {
  switch (direction) {
    // case Direction.left:
    //   return 2;
    // case Direction.right:
    //   return 2;
    // case Direction.up:
    //   return 3;
    // case Direction.down:
    //   return 3;
    default:
      return 4;
  }
}
