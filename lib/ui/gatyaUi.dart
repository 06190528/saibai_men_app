import 'package:flame/sprite.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart' as Flame;

class GatyaUi extends SpriteAnimationComponent with HasGameRef {
  double length;
  bool start;
  GatyaUi(this.length, this.start);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final spriteSheetImage = await Flame.Flame.images.load('gatya.png');
    final double spriteHeight = (spriteSheetImage.height.toDouble() + 10) / 2;
    final double spriteWidth = (spriteSheetImage.width.toDouble() - 3) / 5;
    final spriteSheet = SpriteSheet(
      image: spriteSheetImage,
      srcSize: Vector2(spriteWidth, spriteHeight),
    );
    animation = spriteSheet.createAnimation(
      row: 0,
      stepTime: 0.1,
      from: 0,
      to: 1,
      loop: false,
    );
    if (start) {
      animation = spriteSheet.createAnimation(
        row: 0,
        stepTime: 0.1,
        from: 0,
        to: 2 * 5 - 1,
        loop: false,
      );
    }
    anchor = Anchor.center;
    double squareSideLength = length;
    size = Vector2(
        squareSideLength * spriteWidth / spriteHeight, squareSideLength);
  }

  void startGatya() {
    start = true;
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  void removeGatya() {
    removeFromParent();
  }
}
