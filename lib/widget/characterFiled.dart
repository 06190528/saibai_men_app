import 'dart:ui';
import 'dart:math' as math;
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'package:saibai_men_app/ui/characterFIledBackground.dart';
import 'package:saibai_men_app/ui/characterUi.dart';
import 'package:saibai_men_app/ui/gatyaUi.dart';

class CharacterField extends FlameGame {
  CharacterField() {}

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

  void addCharacter(int catKind, double length, Vector2 position) {
    final character = Character(catKind, length);
    character.position = position;
    add(character);
  }

  void addGatya(double length, Vector2 position, bool start) {
    print('addGatya');
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

  // void addSparkleEffect(Vector2 position, double radius) {
  //   final particles = List.generate(12, (i) {
  //     // 30度ごとに角度を計算
  //     final double angle = (math.pi / 6) * i;
  //     // 色を設定（黄色または透明）
  //     final color = i % 2 == 0 ? Colors.yellow : Colors.transparent;
  //     // CircleParticleのインスタンスを生成
  //     return CircleParticle(
  //       paint: Paint()..color = color,
  //       radius: radius / 10,
  //     );
  //     // )..position =
  //     //     Vector2(radius * math.cos(angle), radius * math.sin(angle)); // 位置を設定
  //   });

  //   // ComposedParticleを使ってパーティクルをグループ化
  //   final composedParticle = ComposedParticle(
  //     children: particles,
  //   );

  //   // ParticleSystemComponentにラップしてゲームに追加
  //   add(ParticleSystemComponent(
  //     particle: composedParticle,
  //   )..position = position); // エフェクトの中心位置を設定
  // }
}
