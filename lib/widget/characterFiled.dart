import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:saibai_men_app/ui/characterFIledBackground.dart';
import 'package:saibai_men_app/ui/characterUi.dart';

class CharacterField extends FlameGame {
  CharacterField() {}

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final character = Character(8, size.y / 2);
    final characterFIledBackground = CharacterFiledBackGround();
    character.x = size.x / 2 - character.width / 2; // X軸を画面の中心に設定
    character.y = size.y / 2 - character.height / 2; // Y軸を画面の中心に設定
    add(characterFIledBackground);
    add(character);
  }

  @override
  void update(double dt) {
    super.update(dt);
    // ここに更新処理を記述
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // ここに描画処理を記述
  }
}
