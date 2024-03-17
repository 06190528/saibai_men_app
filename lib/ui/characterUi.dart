import 'package:flame/sprite.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart' as Flame;
import 'package:saibai_men_app/ui/gameEnemyUi.dart';

class Character extends SpriteAnimationComponent with HasGameRef {
  int enemyKind;
  double length;

  Character(this.enemyKind, this.length) {
    this.size = size;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final spriteSheetImage =
        await Flame.Flame.images.load('cats_memes_$enemyKind.png');
    final EnemySpriteDetails enemySpriteDetails =
        await getEnemySpriteDetails(enemyKind, spriteSheetImage);
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
    double squareSideLength = length;
    size = Vector2.all(squareSideLength);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  void removeEnemy() {
    removeFromParent();
  }
}
