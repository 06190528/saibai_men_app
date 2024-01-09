import 'package:flame/components.dart';
import 'package:saibai_men_app/logic/directions.dart';

class DinoPlayer extends SpriteComponent with HasGameRef {
  DinoPlayer() : super(size: Vector2.all(0));
  double speed = 0;
  void updateSpeed(double newSpeed) {
    speed = newSpeed;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('idle.png');

    //size = Vector2(64.0, 64.0); // アニメーションのサイズ
    anchor = Anchor.center;
    double squareSideLength = gameRef.size.x / 8; // または任意のサイズを設定
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
