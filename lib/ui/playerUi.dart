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
    final spriteSheet = SpriteSheet(
      image: spriteSheetImage,
      srcSize: Vector2(359.5, 607), // 各フレームのサイズ
    );

    animation = spriteSheet.createAnimation(
      row: 0, // 使用する行
      stepTime: 0.08, // 各フレームの表示時間（秒）
      from: 0, // 開始フレーム
      to: 7, // 終了フレーム
    );
    anchor = Anchor.center;
    double squareSideLength = gameRef.size.x / 6;
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
