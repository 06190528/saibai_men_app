import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saibai_men_app/scene/gatyaScene.dart';
import 'package:saibai_men_app/widget/characterFiled.dart';

class ShowGetCharacter extends ConsumerWidget {
  final int characterIndex;

  ShowGetCharacter({Key? key, required this.characterIndex}) : super(key: key);
  final CharacterField characterField = CharacterField();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    characterField.addCharacter(characterIndex, size.height / 2.5,
        Vector2(size.width / 2, size.height / 2));
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
          ref.read(onTapedProvider.state).state = false;
        },
        child: Material(
          type: MaterialType.transparency,
          child: Stack(children: [
            GameWidget(
              game: characterField,
            ),
          ]),
        ),
      ),
    );
  }
}

// class SparklePainter extends CustomPainter {
//   final Vector2 center;
//   final double radius;

//   SparklePainter({required this.center, required this.radius});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2;
//     for (int i = 0; i < 12; i++) {
//       // 30度ごとに色を変えます
//       paint.color = i % 2 == 0 ? Colors.yellow : Colors.transparent;
//       final double angle = (math.pi / 6) * i; // 30度ごと
//       final offset = Offset(
//         center.x + radius * math.cos(angle),
//         center.y + radius * math.sin(angle),
//       );
//       canvas.drawCircle(offset, radius / 10, paint); // 小さな円を描く
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
