import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:saibai_men_app/logic/directions.dart';

class DinoPlayer extends SpriteAnimationComponent with HasGameRef {
  DinoPlayer() : super(size: Vector2.all(0));
  double speed = 0;
  void updateSpeed(double newSpeed) {
    speed = newSpeed;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();

    Image spriteSheetImage = await Flame.images.load('yamucha_sprit.png');
    final int spriteCount = 4;
    final double spriteHeight = spriteSheetImage.height.toDouble() / 2 - 10;
    final double spriteWidth = spriteSheetImage.width.toDouble() / spriteCount;

    final spriteSheet = SpriteSheet(
      image: spriteSheetImage,
      srcSize: Vector2(spriteWidth - 10, spriteHeight),
    );

    // アニメーションの設定。
    animation = spriteSheet.createAnimation(
      row: 0,
      stepTime: 0.1,
      from: 0, // 最初のスプライト
      to: spriteCount * 2 - 1, // 最後のスプライト
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
}
