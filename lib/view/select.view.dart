import 'package:flutter/material.dart';
import 'package:rush_time_app/logic/select.code.dart';
import 'package:rush_time_app/common/ad_helper.dart';
import 'package:rush_time_app/view/widget/banner.view.dart';
import 'package:rush_time_app/view/widget/Butoon/timeButton.view.dart';
import 'package:rush_time_app/provider/time_provider.dart';
import 'package:rush_time_app/view/count-down.view.dart';
import 'package:provider/provider.dart';
import 'package:rush_time_app/view/widget/settingView.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  TimeProvider timeProvider = TimeProvider(DateTime.now());
  List<int> items = List.generate(40, (index) => index);
  final ScrollController _scrollController = ScrollController();

  double lastScrollPosition = 0; // 追加：最後のスクロール位置を追跡する変数

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final currentScrollPosition = _scrollController.position.pixels;
      final scrollThreshold = (MediaQuery.of(context).size.width / 6) * 10;

      if ((currentScrollPosition - lastScrollPosition).abs() >
          scrollThreshold) {
        lastScrollPosition = currentScrollPosition;
        // スクロール位置が指定した閾値を超えた場合の処理
        addMoreItems(items);
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          BannerAdWidget(
            adUnitId: AdHelper.bannerAdUnitId,
            width: MediaQuery.of(context).size.width, // バナー広告用の広告ユニットIDを指定
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                // スクロール可能なコンテンツ
                ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.zero, // パディングをゼロに設定
                  itemCount: (items.length / 2).ceil(),
                  itemBuilder: (context, index) {
                    int first = index * 2;
                    int second = first + 1;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TimeButton(
                          index: first,
                          time: timeProvider.getAddedTime(first),
                          onPressed: () {
                            final setTime =
                                Provider.of<SetTime>(context, listen: false);
                            setTime.setTime(timeProvider.getAddedTime(first));
                            //print(setTime.getTime());
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CountDownPage(),
                              ),
                            );
                          },
                        ),
                        if (second < items.length)
                          TimeButton(
                            index: second,
                            time: timeProvider.getAddedTime(second),
                            onPressed: () {
                              final setTime =
                                  Provider.of<SetTime>(context, listen: false);
                              setTime
                                  .setTime(timeProvider.getAddedTime(second));
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CountDownPage(),
                                ),
                              );
                            },
                          ),
                      ],
                    );
                  },
                ),
                // 左上に固定された設定アイコン
                const SettingMenuView(),
              ],
            ),
          ),
          BannerAdWidget(
            adUnitId: AdHelper.bannerAdUnitId,
            width: MediaQuery.of(context).size.width, // バナー広告用の広告ユニットIDを指定
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
