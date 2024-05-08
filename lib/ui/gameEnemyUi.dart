import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flame/components.dart';
import 'package:saibai_men_app/logic/directions.dart';
import 'package:saibai_men_app/ui/playerUi.dart';

int _enemyIdCounter = 0;

class Enemy extends SpriteAnimationComponent with HasGameRef {
  double speed;
  Direction direction = Direction.none;
  DinoPlayer dinoPlayer;
  List<Enemy> enemies = [];
  Image spriteSheetImage;
  Function()? onTouchEnemy;
  Function(int id)? EnemyCount;
  final int id;
  final int thisEnemyKind;

  Enemy(
    this.speed,
    this.dinoPlayer,
    this.enemies,
    this.spriteSheetImage,
    this.thisEnemyKind,
    this.onTouchEnemy,
    this.EnemyCount,
  )   : id = _enemyIdCounter++,
        super(size: Vector2.all(0));

  void updateSpeed(double newSpeed) {
    speed = newSpeed;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final EnemySpriteDetails enemySpriteDetails =
        await getEnemySpriteDetails(thisEnemyKind, spriteSheetImage);
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
      if (onTouchEnemy != null) {
        onTouchEnemy!();
        removeEnemy();
      }
    }

    nextPosition.add(detectDirection(direction, deltaPosition));
    if (canGo(nextPosition, screenSize, size, 'enemy')) {
      position.setFrom(nextPosition); // 位置を更新
    } else {
      removeEnemy();
      if (EnemyCount != null) {
        EnemyCount!(id);
      }
    }
  }

  void removeEnemy() {
    removeFromParent();
    enemies.remove(this);
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
      columnCount = 50;
      rowCount = 4;
      stepTime = 0.03;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount + 0.0001;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 40;
      break;
    case 1:
      columnCount = 50;
      rowCount = 9;
      stepTime = 0.02;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 51;
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
      columnCount = 4;
      rowCount = 2;
      stepTime = 0.08;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 1;
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
    case 11:
      columnCount = 50;
      rowCount = 5;
      stepTime = 0.02;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 1;
      break;
    case 12:
      columnCount = 50;
      rowCount = 4;
      stepTime = 0.02;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 44;
      break;
    case 13:
      columnCount = 50;
      rowCount = 5;
      stepTime = 0.02;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 42;
      break;
    case 14:
      columnCount = 50;
      rowCount = 5;
      stepTime = 0.02;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 29;
      break;
    case 15:
      columnCount = 50;
      rowCount = 4;
      stepTime = 0.02;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 33;
      break;
    case 16:
      columnCount = 50;
      rowCount = 2;
      stepTime = 0.02;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 9;
      break;
    case 17:
      columnCount = 50;
      rowCount = 2;
      stepTime = 0.02;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 30;
      break;
    case 18:
      columnCount = 50;
      rowCount = 4;
      stepTime = 0.02;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 26;
      break;
    case 19:
      columnCount = 50;
      rowCount = 10;
      stepTime = 0.02;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 32;
      break;
    case 20:
      columnCount = 50;
      rowCount = 4;
      stepTime = 0.02;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 4;
      break;
    case 21:
      columnCount = 50;
      rowCount = 5;
      stepTime = 0.02;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 18;
      break;
    case 22:
      columnCount = 50;
      rowCount = 5;
      stepTime = 0.02;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 17;
      break;
    case 23:
      columnCount = 50;
      rowCount = 3;
      stepTime = 0.02;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 2;
      break;
    case 24:
      columnCount = 50;
      rowCount = 9;
      stepTime = 0.02;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount + 1;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 44;
      break;
    case 25:
      columnCount = 50;
      rowCount = 6;
      stepTime = 0.02;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 4;
      break;
    case 26:
      columnCount = 50;
      rowCount = 3;
      stepTime = 0.02;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 3;
      break;
    case 27:
      columnCount = 50;
      rowCount = 7;
      stepTime = 0.02;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 20;
      break;
    case 28:
      columnCount = 50;
      rowCount = 5;
      stepTime = 0.02;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 43;
      break;
    case 29:
      columnCount = 50;
      rowCount = 7;
      stepTime = 0.02;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 18;
      break;
    case 30:
      columnCount = 50;
      rowCount = 5;
      stepTime = 0.02;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 9;
      break;
    case 31:
      columnCount = 50;
      rowCount = 5;
      stepTime = 0.02;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 50;
      break;
    case 32:
      columnCount = 50;
      rowCount = 5;
      stepTime = 0.02;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 35;
      break;
    case 33:
      columnCount = 50;
      rowCount = 5;
      stepTime = 0.02;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 18;
      break;
    case 34:
      columnCount = 50;
      rowCount = 3;
      stepTime = 0.02;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 40;
      break;
    case 35:
      columnCount = 50;
      rowCount = 9;
      stepTime = 0.02;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 13;
      break;
    case 36:
      columnCount = 50;
      rowCount = 6;
      stepTime = 0.02;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 38;
      break;
    case 37:
      columnCount = 50;
      rowCount = 5;
      stepTime = 0.02;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 8;
      break;
    case 38:
      columnCount = 50;
      rowCount = 8;
      stepTime = 0.02;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 41;
      break;
    case 39:
      columnCount = 50;
      rowCount = 6;
      stepTime = 0.02;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 10;
      break;
    case 40:
      columnCount = 50;
      rowCount = 4;
      stepTime = 0.02;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 15;
      break;
    case 41:
      columnCount = 50;
      rowCount = 2;
      stepTime = 0.02;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 20;
      break;
    case 42:
      columnCount = 50;
      rowCount = 4;
      stepTime = 0.02;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 5;
      break;
    case 43:
      columnCount = 50;
      rowCount = 3;
      stepTime = 0.02;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 15;
      break;
    case 44:
      columnCount = 50;
      rowCount = 6;
      stepTime = 0.02;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 48;
      break;
    case 45:
      columnCount = 50;
      rowCount = 7;
      stepTime = 0.02;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 50;
      break;
    case 46:
      columnCount = 50;
      rowCount = 4;
      stepTime = 0.02;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 24;
      break;
    case 47:
      columnCount = 50;
      rowCount = 8;
      stepTime = 0.02;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 5;
      break;
    case 48:
      columnCount = 50;
      rowCount = 19;
      stepTime = 0.02;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 47;
      break;
    case 49:
      columnCount = 50;
      rowCount = 5;
      stepTime = 0.02;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 20;
      break;
    case 50:
      columnCount = 50;
      rowCount = 4;
      stepTime = 0.02;
      spriteHeight = spriteSheetImage.height.toDouble() / rowCount;
      spriteWidth = spriteSheetImage.width.toDouble() / columnCount;
      to = columnCount * rowCount - 18;
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
