import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:saibai_men_app/provider.dart';
import 'package:saibai_men_app/ui/characterFiledBackground.dart';
import 'package:saibai_men_app/ui/characterUi.dart';
import 'package:saibai_men_app/ui/gatyaUi.dart';

class CharacterField extends FlameGame {
  CharacterField();

  @override
  Future<void> onLoad() async {
    super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  void addBackground(String backgroundPath) {
    final characterFIledBackground = CharacterFiledBackGround(
      backgroundPath: backgroundPath,
    );
    add(characterFIledBackground);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // ここに描画処理を記述
  }

  void addCharacter(
      int catKind, double length, Vector2 position, ui.Image spriteSheetImage) {
    final character = Character(catKind, length, spriteSheetImage);
    character.position = position;
    add(character);
  }

  void addGatya(double length, Vector2 position, bool start) {
    removeGatya();
    final gatya = GatyaUi(length, start);
    gatya.position = position;
    add(gatya);
  }

  void removeGatya() {
    final List<GatyaUi> toBeRemoved = [];

    // すべてのコンポーネントを反復処理し、GatyaUiインスタンスをリストに追加します。
    for (final component in children) {
      if (component is GatyaUi) {
        toBeRemoved.add(component);
      }
    }

    // 各GatyaUiインスタンスをコンポーネントセットから削除します。
    for (final gatya in toBeRemoved) {
      gatya.removeFromParent();
    }
  }
}
