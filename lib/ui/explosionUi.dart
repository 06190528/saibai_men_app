import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:saibai_men_app/ui/gameUi.dart';

class GameOverSprite extends SpriteAnimationComponent
    with HasGameRef<DinoGame> {
  // コンストラクタ
  GameOverSprite(Vector2 position) : super(position: position);

  // onLoadメソッドをオーバーライドして、非同期にスプライトをロード
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
}
