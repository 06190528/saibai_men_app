import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'dart:math' as math;
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
  int enemyKinds;

  Enemy(
    this.speed,
    this.dinoPlayer,
    this.enemyKinds, {
    this.onGameOver,
    this.EnemyCount,
  })  : id = _enemyIdCounter++,
        super(size: Vector2.all(0));

  void updateSpeed(double newSpeed) {
    speed = newSpeed;
  }

  @override
  Future<void> onLoad() async {
    var random = math.Random();
    super.onLoad();
    int num = random.nextInt(enemyKinds);
    Image spriteSheetImage = await Flame.images.load('cats_memes_$num.png');
    final EnemySpriteDetails enemySpriteDetails =
        await getEnemySpriteDetails(num, spriteSheetImage);
    final double spriteHeight = enemySpriteDetails.spriteHeight;
    final double spriteWidth = enemySpriteDetails.spriteWidth;

    final spriteSheet = SpriteSheet(
      image: spriteSheetImage,
      srcSize: Vector2(spriteWidth, spriteHeight),
    );

    animation = spriteSheet.createAnimation(
      row: 0,
      stepTime: enemySpriteDetails.stepTime,
      from: 0,
      to: enemySpriteDetails.to,
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
        removeEnemy();
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

Future<EnemySpriteDetails> getEnemySpriteDetails(
    int num, Image spriteSheetImage) async {
  final EnemySpriteDetails enemySpriteDetails =
      EnemySpriteDetails(0, 0, 0, 0, 0, 0);
  double spriteHeight = 0;
  double spriteWidth = 0;
  double stepTime = 0;
  int to = 0;
  int columnCount = 0;
  int rowCount = 0;

  switch (num) {
    case 0:
      columnCount = 4;
      rowCount = 2;
      stepTime = 0.08;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 1;
      break;
    case 1:
      columnCount = 50;
      rowCount = 9;
      stepTime = 0.02;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 43;
      break;
    case 2:
      columnCount = 50;
      rowCount = 6;
      stepTime = 0.01;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 12;
      break;
    case 3:
      columnCount = 50;
      rowCount = 8;
      stepTime = 0.03;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 17;
      break;
    case 4:
      columnCount = 3;
      rowCount = 3;
      stepTime = 0.08;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 1;
      break;
    case 5:
      columnCount = 50;
      rowCount = 5;
      stepTime = 0.03;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 50;
      break;
    case 6:
      columnCount = 50;
      rowCount = 9;
      stepTime = 0.03;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 34;
      break;
    case 7:
      columnCount = 50;
      rowCount = 4;
      stepTime = 0.03;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 46;
      break;
    case 8:
      columnCount = 50;
      rowCount = 4;
      stepTime = 0.03;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 40;
      break;
    case 9:
      columnCount = 50;
      rowCount = 9;
      stepTime = 0.02;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 23;
      break;
    case 10:
      columnCount = 50;
      rowCount = 6;
      stepTime = 0.02;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 15;
      break;
  }
  enemySpriteDetails.spriteHeight = spriteHeight;
  enemySpriteDetails.spriteWidth = spriteWidth;
  enemySpriteDetails.stepTime = stepTime;
  enemySpriteDetails.to = to;
  return enemySpriteDetails;
}

class EnemySpriteDetails {
  double stepTime;
  int to;
  int columnCount;
  int rowCount;
  double spriteHeight;
  double spriteWidth;
  EnemySpriteDetails(this.stepTime, this.to, this.columnCount, this.rowCount,
      this.spriteHeight, this.spriteWidth);
}
