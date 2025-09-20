import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:saibai_men_app/ui/gameUi.dart';
import 'package:saibai_men_app/ui/playerUi.dart';

class KiEffect extends SpriteAnimationComponent with HasGameRef<DinoGame> {
  final DinoPlayer dinoPlayer;

  KiEffect(
    this.dinoPlayer,
  );

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // ここで画像のサイズを調整します。
    double scaleFactor = 2.0; // 横幅を2倍に引き伸ばすための係数
    size = Vector2(gameRef.size.x / 4 * scaleFactor, gameRef.size.y / 4);

    Image spriteSheetImage = await Flame.images.load('ki_sprite.png');
    // 画像のスプライト情報を設定します。
    final int spriteCount = 9; // スプライトの縦の数
    final double spriteHeight =
        spriteSheetImage.height.toDouble() / spriteCount;
    final double spriteWidth = spriteSheetImage.width.toDouble();

    final spriteSheet = SpriteSheet(
      image: spriteSheetImage,
      srcSize: Vector2(spriteWidth, spriteHeight),
    );

    // アニメーションの設定。
    animation = spriteSheet.createAnimation(
      row: 0,
      stepTime: 0.08,
      from: 0, // 最初のスプライト
      to: spriteCount - 1, // 最後のスプライト
      loop: true,
    );

    // dinoPlayerとKiEffectのアンカーを合わせます。
    anchor = Anchor.bottomCenter;
    dinoPlayer.anchor = Anchor.center;
  }

  @override
  void update(double dt) {
    super.update(dt);
    updatePosition(dt);
  }

  void updatePosition(double dt) {
    position = dinoPlayer.position + Vector2(0, dinoPlayer.height);
  }

  void removeKiEffect() {
    removeFromParent();
  }
}
