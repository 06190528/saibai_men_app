import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saibai_men_app/provider.dart';

// RankingWidgetの定義
class RankingWidget extends ConsumerWidget {
  const RankingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // rankingDataProviderからランキングデータを取得
    List<String> rankingList = ref.watch(rankingDataProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Ranking'),
      ),
      body: Container(
        color: Colors.white, // 背景色を白色に設定
        child: ListView.builder(
          itemCount: rankingList.length, // リストの長さ
          itemBuilder: (context, index) {
            return Material(
              child: ListTile(
                title: Text(rankingList[index],
                    style: TextStyle(color: Colors.black)), // ランキングデータ
              ),
            );
          },
        ),
      ),
    );
  }
}
