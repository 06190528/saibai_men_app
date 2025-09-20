import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saibai_men_app/common/language.dart';
import 'package:saibai_men_app/provider.dart';
import 'package:saibai_men_app/widget/resultDialogWidget/doubleText.dart';

class RankingCircle extends ConsumerWidget {
  final double size;

  RankingCircle({Key? key, this.size = 50.0}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userRanking = ref.watch(userRankingProvider);
    final language = ref.watch(userDataProvider.notifier).state.language;
    final Color color = rankingColor(userRanking);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: DoubleText(
          text:
              '${userRanking.toString()}${Language().translationPlace(language)}',
          fontSize: size * 0.3,
          insideColor: Colors.white,
        ),
      ),
    );
  }
}

Color rankingColor(int rank) {
  if (rank == 1) {
    return Colors.amber;
  } else if (rank == 2) {
    return Colors.grey;
  } else if (rank == 3) {
    return Colors.brown;
  } else if (rank <= 20) {
    return Color.fromARGB(255, 169, 195, 255); // 修正された行
  }
  return Colors.white; // 他の場合は白を返す
}
