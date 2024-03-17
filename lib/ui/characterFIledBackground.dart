import 'package:flame/components.dart';

class CharacterFiledBackGround extends SpriteComponent with HasGameRef {
  double speed = 0; // 秒速100単位で移動
  late SpriteComponent background1;
  late SpriteComponent background2;

  void updateSpeed(double newSpeed) {
    speed = newSpeed;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('titleScene.jpg');
    size = sprite!.originalSize;
    size = gameRef.size;
  }

  @override
  void update(double dt) {
    super.update(dt);
  }
}
