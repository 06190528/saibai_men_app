import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:saibai_men_app/logic/directions.dart';
import 'package:saibai_men_app/ui/playerUi.dart';

class Deathblow extends SpriteAnimationComponent with HasGameRef {
  double speed;
  Direction direction = Direction.none;
  DinoPlayer dinoPlayer;
  Function()? activateSpecialMove;

  Deathblow(this.speed, this.dinoPlayer, {this.activateSpecialMove})
      : super(size: Vector2.all(0));

  void updateSpeed(double newSpeed) {
    speed = newSpeed;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();

    Image spriteSheetImage = await Flame.images.load('energy bullet.png');

    // スプライトシートからスプライトアニメーションを作成
    final spriteSheet = SpriteSheet(
      image: spriteSheetImage,
      srcSize: Vector2(274.3, 270),
    );

    animation = spriteSheet.createAnimation(
      row: 0, // 使用する行
      stepTime: 0.1, // 各フレームの表示時間（秒）
      from: 0, // 開始フレーム
      to: 15, // 終了フレーム
    );
    anchor = Anchor.center;
    // 画像を正方形にする
    double squareSideLength = gameRef.size.x / 8; // または任意のサイズを設定
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
    //　当たり判定
    double radius = (size.length / 2 + dinoPlayer.size.length / 2) / 1.7;
    double distance = dinoPlayer.position.distanceTo(position);
    if (distance <= radius) {
      if (activateSpecialMove != null) {
        activateSpecialMove!();
        removeFromParent();
      }
    }

    nextPosition.add(detectDirection(direction, deltaPosition));
    if (canGo(nextPosition, screenSize, size, 'enemy')) {
      //enemyと同じ動きでいい
      position.setFrom(nextPosition); // 位置を更新
    } else {
      removeFromParent();
    }
  }
}
