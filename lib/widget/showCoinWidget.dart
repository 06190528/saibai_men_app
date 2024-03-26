import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saibai_men_app/common/const.dart';
import 'package:saibai_men_app/logic/gameWidgetLogic.dart';
import 'package:saibai_men_app/provider.dart';

class ShowCoinWidget extends ConsumerWidget {
  final double width;
  final double height;
  final bool canTap;

  ShowCoinWidget({
    Key? key,
    required this.width,
    required this.height,
    this.canTap = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coinCount = ref.watch(getCoinCountProvider);
    final circleButtonSize = height * 0.5;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: InkWell(
              onTap: () {
                if (canTap) {
                  GameWidgetLogic(context, ref).watchRewardAd(
                      width * 0.2,
                      () => GameWidgetLogic(context, ref)
                          .getCoin(gaytaOnceCoin * 2));
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/coin.png',
                      width: width * 0.3,
                      height: height * 0.8,
                    ),
                    SizedBox(width: width * 0.05),
                    Text(
                      '×',
                      style: TextStyle(
                          fontSize: width * 0.2, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '$coinCount',
                      style: TextStyle(
                          fontSize: width * 0.2, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (canTap) ...[
            Positioned(
              left: -(circleButtonSize / 2),
              bottom: 0,
              child: Container(
                width: circleButtonSize,
                height: circleButtonSize,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: InkWell(
                  onTap: () async {
                    GameWidgetLogic(context, ref).watchRewardAd(
                        width * 0.2,
                        () => GameWidgetLogic(context, ref)
                            .getCoin(gaytaOnceCoin * 2));
                  },
                  borderRadius: BorderRadius.circular(circleButtonSize),
                  child: Icon(
                    Icons.add_rounded,
                    size: circleButtonSize,
                    color: Color.fromARGB(255, 105, 31, 26),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
