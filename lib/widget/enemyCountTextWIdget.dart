import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saibai_men_app/common/language.dart';
import 'package:saibai_men_app/common/ranking.dart';
import 'package:saibai_men_app/logic/gameWidgetLogic.dart';
import 'package:saibai_men_app/provider.dart';
import 'package:saibai_men_app/widget/evolutionBar.dart';

class EnemyCountText extends ConsumerWidget {
  const EnemyCountText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final gameLogic = GameWidgetLogic(context, ref);
    final enemyCounter = ref.watch(enemyCounterProvider);
    final rankingList = ref.watch(rankingListProvider);
    final language = ref.watch(userDataProvider.notifier).state.language;
    final evolutionFlag = ref.watch(evolutionFlagProvider);
    double maxEnemyCount = 100;
    // enemyCounterが1以上かつevolutionFlagがfalseの場合、非同期でevolutionを実行
    if (enemyCounter >= maxEnemyCount && evolutionFlag == false) {
      Future.microtask(() {
        gameLogic.evolution(); // evolution メソッドを呼び出す
        ref.read(evolutionFlagProvider.state).state = true; // evolutionFlagを更新
      });
    }
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(128, 222, 222, 222), // 背景色を透明度50%で設定
            borderRadius: BorderRadius.circular(20), // 角丸設定
            border: Border.all(
              color: Colors.black, // 枠線の色
              width: 1, // 枠線の太さ
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // 子ウィジェットに合わせてサイズを調整
            children: [
              Text(
                '${enemyCounter}',
                style: TextStyle(
                  fontFamily: 'CustomFont', // カスタムフォントを使用
                  fontSize: size.width * 0.05, // フォントサイズ
                  fontWeight: FontWeight.bold, // フォントの太さ
                  fontStyle: FontStyle.italic, // フォントスタイルをイタリックに
                  color: Colors.black, // テキストの色
                  letterSpacing: 1.0, // 文字の間隔
                  wordSpacing: 1.0, // 単語の間隔
                  shadows: [
                    Shadow(
                      blurRadius: 1.0,
                      color: Colors.black,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
              ),
              // Text(
              //   '${Language().translationYourRanking(language)} : ${getCurrentRank(rankingList, enemyCounter)}',
              //   style: TextStyle(
              //     fontFamily: 'CustomFont', // カスタムフォントを使用
              //     fontSize: size.width * 0.03, // フォントサイズ
              //     fontWeight: FontWeight.bold, // フォントの太さ
              //     fontStyle: FontStyle.italic, // フォントスタイルをイタリックに
              //     color: Colors.black, // テキストの色
              //     letterSpacing: 1.0, // 文字の間隔
              //     wordSpacing: 1.0, // 単語の間隔
              //   ),
              // ),
              Row(
                children: [
                  EvolutionBar(
                    width: size.width * 0.3, // ゲージの全体の幅
                    height: size.width * 0.03, // ゲージの高さ
                    currentEnemyCount: enemyCounter.toDouble(), // 現在のHP
                    maxEnemyCount: maxEnemyCount, // 最大HP
                  ),
                  Image.asset(
                    'assets/images/saiazinn.png', // アセットのパス
                    width: size.width * 0.1, // 画像の幅
                    height: size.width * 0.1, // 画像の高さ
                    fit: BoxFit.cover, // 画像のフィットモード（任意で指定）
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

int getCurrentRank(List<Ranking> rankingList, int enemyCounter) {
  int currentRank = -1; // 初期値を-1に設定しておく

  // rankingListをループしてenemyCounterを比較
  for (int i = 0; i < rankingList.length; i++) {
    if (enemyCounter >= rankingList[i].score) {
      currentRank = i + 1; // 順位は1から始まるため、インデックス+1が順位
      break; // 順位を見つけたらループを終了
    }
  }

  return currentRank;
}
