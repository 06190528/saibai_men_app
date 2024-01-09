import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:saibai_men_app/logic/directions.dart';
import 'package:saibai_men_app/ui/gameUi.dart';

class AttackEnemy extends SpriteAnimationComponent with HasGameRef<DinoGame> {
  double speed;
  // コンストラクタ
  AttackEnemy(Vector2 position, this.speed) : super(position: position);
  @override
  Future<void> onLoad() async {
    super.onLoad();
    anchor = Anchor.center;
    size = gameRef.size / 5;
    Image spriteSheetImage = await Flame.images.load('explosion_sprite.png');

    // スプライトシートからスプライトアニメーションを作成
    final spriteSheet = SpriteSheet(
      image: spriteSheetImage,
      srcSize: Vector2(280.6, 294), // 各フレームのサイズ
    );

    animation = spriteSheet.createAnimation(
      row: 0, // 使用する行
      stepTime: 0.08, // 各フレームの表示時間（秒）
      from: 0, // 開始フレーム
      to: 16, // 終了フレーム
      loop: false,
    );
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

    nextPosition.add(detectDirection(Direction.down, deltaPosition));
    if (canGo(nextPosition, screenSize, size, 'enemy')) {
      //enemyと同じ動きでいい
      position.setFrom(nextPosition); // 位置を更新
    } else {
      removeFromParent();
    }
  }
}
