import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saibai_men_app/common/data/userData.dart';
import 'package:saibai_men_app/scene/gameScene.dart';
import 'package:saibai_men_app/provider.dart';
import 'package:saibai_men_app/widget/padlockWidget.dart';
import 'package:saibai_men_app/widget/resultDialogWidget/buttonWidget.dart';

class BannerAndPadlockWidget extends ConsumerWidget {
  final String text;

  final int padlockScore;

  const BannerAndPadlockWidget(
      {Key? key, required this.text, required this.padlockScore})
      : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final maxScore = ref.watch(userMaxScoreProvider);
    final buttonActiveFlag = (padlockScore <= maxScore || padlockScore == 0);
    return Container(
      padding: EdgeInsets.all(10),
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          BannerButton(
            text: text,
            onPressed: () {
              if (buttonActiveFlag) {
                Navigator.pushAndRemoveUntil(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        GameScene(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                  ),
                  (Route<dynamic> route) => route.settings.name == 'HomeScene',
                );

                setGameModeToProvider(ref, text);
              }
            },
            width: size.width * 0.5,
            icon: Icons.play_arrow,
          ),
          if (!buttonActiveFlag)
            Positioned(
              top: -size.height * 0.05,
              left: 0,
              child: PadlockWidget(
                text: padlockScore.toString(),
                size: size * 0.7,
              ),
            ),
        ],
      ),
    );
  }
}
