// import 'package:flame/game.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:saibai_men_app/common/data/firebaseSave.dart';
// import 'package:saibai_men_app/provider.dart';
// import 'package:saibai_men_app/scene/homeScene.dart';
// import 'package:saibai_men_app/widget/characterFiled.dart';
// import 'package:saibai_men_app/widget/feverBar.dart';

// class TitleScene extends ConsumerWidget {
//   bool _initialized = false;
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final size = MediaQuery.of(context).size;
//     CharacterField characterField = CharacterField();
//     characterField.addBackground('title.jpg');
//     characterField.addCharacter(
//         8, size.height / 2, Vector2(size.width / 2, size.height / 2));
//     final loadingProgress = ref.watch(loadingProgressProvider);
//     if (!_initialized) {
//       ref.watch(loadingProgressProvider.state).state = 0;
//       WidgetsBinding.instance.addPostFrameCallback((_) async {
//         print('TitleScene: _initialized');
//       });
//       _initialized = true;
//     }

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => HomeScene()),
//       );
//     });

//     return Scaffold(
//       body: Stack(
//         alignment: Alignment.center,
//         children: [
//           Center(
//             child: GameWidget(
//               game: characterField,
//             ),
//           ),
//           Positioned(
//             bottom: size.height * 0.3,
//             child: GaugeBar(
//               height: size.height * 0.02,
//               width: size.width * 0.8,
//               currentGauge: loadingProgress.toDouble(),
//               maxGauge: 100,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
