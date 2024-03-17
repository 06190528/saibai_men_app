import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saibai_men_app/common/data/firebaseSave.dart';
import 'package:saibai_men_app/provider.dart';
import 'package:saibai_men_app/scene/homeScene.dart';
import 'package:saibai_men_app/widget/characterFiled.dart';
import 'package:saibai_men_app/widget/feverBar.dart';

class TitleScene extends ConsumerWidget {
  bool _initialized = false;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    CharacterField characterField = CharacterField();
    final loadingProgress = ref.watch(loadingProgressProvider);
    if (!_initialized) {
      ref.watch(loadingProgressProvider.state).state = 0;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await saveUserDataFromLocalToProvider(ref);
        await getAndSaveRankingDataFromIFirebaseToProvider(ref);
      });
      _initialized = true;
    }

    if (loadingProgress >= 100) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScene()),
        );
      });
    }

    return Scaffold(
      body: Stack(
        alignment: Alignment.center, // Stack内の子要素を中央に配置
        children: [
          Center(
            child: GameWidget(
              game: characterField,
            ),
          ),
          Positioned(
            bottom: size.height * 0.3,
            child: GaugeBar(
              height: size.height * 0.05,
              width: size.width * 0.8,
              currentGauge: loadingProgress.toDouble(),
              maxGauge: 100,
            ),
          ),
        ],
      ),
    );
  }
}
