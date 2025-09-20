import 'package:flame/components.dart';

class DinoWorld extends SpriteComponent with HasGameRef {
  double speed = 0; // 秒速100単位で移動
  late SpriteComponent background1;
  late SpriteComponent background2;

  void updateSpeed(double newSpeed) {
    speed = newSpeed;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('background.png');
    size = sprite!.originalSize;
    size = gameRef.size;

    // 背景1の設定
    background1 = SpriteComponent()
      ..sprite = await gameRef.loadSprite('background.png')
      ..size = gameRef.size
      ..position = Vector2(0, 0) // 背景1の直後
      ..scale = Vector2(1, 1); // 初期縮小率（変更可能）

    // 背景2の設定（背景1の直後に配置）
    background2 = SpriteComponent()
      ..sprite = await gameRef.loadSprite('background.png')
      ..size = gameRef.size
      ..position = Vector2(0, -gameRef.size.y)
      ..scale = Vector2(1, 1); // 背景1の直後

    add(background1);
    add(background2);
  }

  @override
  void update(double dt) {
    super.update(dt);

    background1.position.add(Vector2(0, speed * dt));
    background2.position.add(Vector2(0, speed * dt));

    if (background1.position.y >= gameRef.size.y) {
      background1.position.y = -background2.size.y + 5;
    }
    if (background2.position.y >= gameRef.size.y) {
      background2.position.y = -background1.size.y + 5;
    }
  }
}
