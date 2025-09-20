import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:saibai_men_app/logic/directions.dart';
import 'package:saibai_men_app/ui/gameEnemyUi.dart';

class DinoPlayer extends SpriteAnimationComponent with HasGameRef {
  int characterKind;
  DinoPlayer(this.characterKind) : super(size: Vector2.all(0));
  double speed = 0;
  void updateSpeed(double newSpeed) {
    speed = newSpeed;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();

    Image spriteSheetImage =
        await Flame.images.load('characters/cats_memes_$characterKind.png');
    EnemySpriteDetails spriteDetails =
        await getEnemySpriteDetails(characterKind, spriteSheetImage);
    double spriteHeight = spriteDetails.spriteHeight;
    double spriteWidth = spriteDetails.spriteWidth;
    final spriteSheet = SpriteSheet(
      image: spriteSheetImage,
      srcSize: Vector2(spriteWidth, spriteHeight),
    );

    animation = spriteSheet.createAnimation(
      row: 0,
      stepTime: spriteDetails.stepTime,
      from: 0,
      to: spriteDetails.to,
      loop: true,
    );
    anchor = Anchor.center;
    double squareSideLength = gameRef.size.y / 13;
    size = Vector2.all(squareSideLength);
  }

  Direction direction = Direction.up;

  @override
  void update(double dt) {
    super.update(dt);
    updatePosition(dt);
  }

  void updatePosition(double dt) {
    double deltaPosition = speed * dt;
    Vector2 nextPosition = position.clone();
    nextPosition.add(detectDirection(direction, deltaPosition));
    Vector2 screenSize = gameRef.size;

    if (canGo(nextPosition, screenSize, size, 'player')) {
      position.setFrom(nextPosition); // 位置を更新
    }
  }

  void removePlayer() {
    gameRef.remove(this);
  }
}
