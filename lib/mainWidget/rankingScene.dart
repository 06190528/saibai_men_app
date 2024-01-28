import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saibai_men_app/common/data/firebaseSave.dart';
import 'package:saibai_men_app/common/language.dart';
import 'package:saibai_men_app/common/ranking.dart';
import 'package:saibai_men_app/provider.dart';
import 'package:saibai_men_app/widget/resultDialogWidget/doubleText.dart';

class RankingWidget extends ConsumerWidget {
  const RankingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Ranking> rankingList = ref.watch(rankingListProvider.notifier).state;
    final userId = UserDataService().getUserId();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 222, 222, 222),
        title: Center(
          // Centerウィジェットで囲む
          child: Column(
            mainAxisSize: MainAxisSize.min, // 必要最小限のスペースを使用
            children: [
              DoubleText(
                text: Language()
                    .translationRanking(ref.read(userDataProvider).language),
                fontSize: 20,
                insideColor: Color.fromARGB(255, 255, 192, 1),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Row内の要素を中央に配置
                children: [
                  Text(
                    Language().translationYourRank(
                        ref.read(userDataProvider).language),
                    style: TextStyle(fontSize: 13),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text('${getUserRank(rankingList, userId)}',
                      style: TextStyle(fontSize: 13)),
                ],
              )
            ],
          ),
        ), // ランキング画面のタイトル
        centerTitle: true, // タイトルを中央に配置
      ),
      body: Container(
        color: Colors.white, // 背景色を白色に設定
        child: ListView.builder(
          itemCount: 100, // リストの長さをrankingListの長さに設定
          itemBuilder: (context, index) {
            IconData? medalIcon; // メダルアイコンを格納する変数
            Color? medalColor; // メダルの色を格納する変数

            // ランキングに応じてメダルアイコンと色を設定
            if (index == 0) {
              // 一位
              medalIcon = Icons.emoji_events; // メダルアイコン
              medalColor = Colors.yellow; // 金色
            } else if (index == 1) {
              // 二位
              medalIcon = Icons.emoji_events;
              medalColor = Colors.grey; // 銀色
            } else if (index == 2) {
              // 三位
              medalIcon = Icons.emoji_events;
              medalColor = Colors.brown; // 銅色
            } else if (index <= 9) {
              medalIcon = Icons.emoji_events;
              medalColor = Colors.black; // 黒色
            }

            return Column(
              children: <Widget>[
                Material(
                  child: ListTile(
                    leading: medalIcon != null
                        ? Icon(medalIcon, color: medalColor)
                        : null, // 条件に応じてメダルアイコンを表示
                    title: Text(
                      '${index + 1} : ${rankingList[index].name} : ${rankingList[index].score}',
                      style: TextStyle(color: Colors.black), // ランキングデータ
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                  height: 0.1,
                  thickness: 0.5,
                ), // アイテム間に線を入れる
              ],
            );
          },
        ),
      ),
    );
  }
}

int getUserRank(List<Ranking> rankingList, Future<String> id) {
  for (int i = 0; i < rankingList.length; i++) {
    if (rankingList[i].id == id) {
      return i + 1;
    }
  }
  return rankingList.length + 1;
}
