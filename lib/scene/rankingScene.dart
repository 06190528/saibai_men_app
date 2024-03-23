import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saibai_men_app/common/data/firebaseSave.dart';
import 'package:saibai_men_app/common/language.dart';
import 'package:saibai_men_app/common/ranking.dart';
import 'package:saibai_men_app/provider.dart';
import 'package:saibai_men_app/widget/rankingCircleWidget.dart';
import 'package:saibai_men_app/widget/resultDialogWidget/doubleText.dart';

class RankingWidget extends ConsumerWidget {
  const RankingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Ranking> rankingList = ref.watch(rankingListProvider.notifier).state;
    if (rankingList.isEmpty) {
      Navigator.of(context).pop();
    }
    final userRanking = ref.watch(userRankingProvider);
    final isLoading = ref.watch(isLoadingProvider); // ローディング状態を監視
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Language().translationYourRanking(
                        ref.read(userDataProvider).language),
                    style: TextStyle(fontSize: 13),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    '$userRanking',
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              )
            ],
          ),
        ), // ランキング画面のタイトル
        centerTitle: true, // タイトルを中央に配置
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : buildRankingList(ref),
    );
  }

  Widget buildRankingList(WidgetRef ref) {
    final ScrollController scrollController = ScrollController();
    scrollController.addListener(() async {
      if (scrollController.position.pixels <=
          scrollController.position.minScrollExtent - 120) {
        ref.read(isLoadingProvider.notifier).state = true;
        await getAndSaveRankingDataFromIFirebaseToProvider(ref);
        await addUserNewMaxScoreToRankingListProviderAndGetUserRanking(ref);
        ref.read(isLoadingProvider.notifier).state = false;
      }
    });
    List<Ranking> rankingList = ref.watch(rankingListProvider.notifier).state;
    return Container(
      color: Colors.white, // 背景色を白色に設定
      child: ListView.builder(
        controller: scrollController,
        itemCount: 100,
        itemBuilder: (context, index) {
          IconData? medalIcon;
          Color? medalColor;
          double? size;
          if (index <= 2) {
            medalIcon = Icons.emoji_events;
            medalColor = rankingColor(index + 1);
            size = 30;
          } else if (index <= 9) {
            medalIcon = Icons.emoji_events;
            medalColor = rankingColor(index + 1);
            size = 20;
          } else if (index <= 19) {
            medalIcon = Icons.emoji_events_outlined;
            medalColor = rankingColor(index + 1);
            size = 20;
          }
          return Column(
            children: <Widget>[
              Material(
                child: ListTile(
                  leading: medalIcon != null
                      ? Icon(medalIcon, color: medalColor, size: size)
                      : null, // 条件に応じてメダルアイコンを表示
                  title: Text(
                    '${index + 1} : ${rankingList[index].name} : ${rankingList[index].maxScore}',
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
    );
  }
}

// Future<void> getUserRanking(WidgetRef ref) async {
//   final rankingList = ref.watch(rankingListProvider.notifier).state;
//   String userId = await UserDataService().getUserId(); // Futureをawaitで待ちます
//   int userRank = rankingList.length + 1;
//   for (int i = 0; i < rankingList.length; i++) {
//     if (rankingList[i].id == userId) {
//       userRank = i + 1;
//       break; // マッチしたらループを抜ける
//     }
//   }
//   ref.read(loadingProgressProvider.notifier).state += 10;
//   // 結果をuserRankingProviderに設定
//   ref.read(userRankingProvider.notifier).state = userRank;
// }
