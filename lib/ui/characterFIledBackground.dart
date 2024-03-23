import 'package:flame/components.dart';

class CharacterFiledBackGround extends SpriteComponent with HasGameRef {
  String backgroundPath;

  CharacterFiledBackGround({required this.backgroundPath});
  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('background.png');
    size = sprite!.originalSize;
    size = gameRef.size;
  }

  @override
  void update(double dt) {
    super.update(dt);
  }
}
