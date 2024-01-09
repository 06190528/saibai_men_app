import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saibai_men_app/common/ad_helper.dart';
import 'package:saibai_men_app/logic/gameWidgetLogic.dart';
import 'package:saibai_men_app/provider.dart';
import 'package:saibai_men_app/widget/adwidget/bannerAd.view.dart';
import 'package:saibai_men_app/widget/deathBlowWidget.dart';
import 'package:saibai_men_app/widget/enemyCountTextWIdget.dart';
import 'package:saibai_men_app/widget/gameWidgetArea.dart';
import 'package:saibai_men_app/widget/resultDialog.dart';

class GameScene extends ConsumerWidget {
  GameScene({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    GameWidgetLogic gameWidgetLogic = GameWidgetLogic(context, ref);
    return Scaffold(
      body: Stack(
        children: [
          GameWidgetArea(),
          if (ref.watch(showResultDialog)) ...[
            Container(
              child: const Result(),
            ),
          ],
          if (ref.watch(isGameActiveProvider)) ...[
            Positioned(
              top: size.height * 0.05,
              right: size.width * 0.05,
              child: Column(
                children: [
                  EnemyCountText(),
                  if (ref.watch(deathblowCountProvider) >= 1) ...[
                    DeathBlowWidget(
                        onActivateSpecialMove:
                            gameWidgetLogic.activateSpecialMove)
                  ]
                ],
              ),
            ),
          ],
          Positioned(
            bottom: 0,
            child: BannerAdWidget(
              adUnitId: AdHelper.bannerAdUnitId,
              width: size.width,
            ),
          ),
        ],
      ),
    );
  }
}
