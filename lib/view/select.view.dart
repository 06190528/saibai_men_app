import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rush_time_app/logic/select.code.dart';
import 'package:rush_time_app/common/ad_helper.dart';
import 'package:rush_time_app/provider/langage_provider.dart';
import 'package:rush_time_app/view/widget/banner.view.dart';
import 'package:rush_time_app/view/widget/button.view.dart';
import 'package:rush_time_app/provider/time_provider.dart';
import 'package:rush_time_app/view/count-down.view.dart';
import 'package:provider/provider.dart';
import 'package:rush_time_app/view/widget/setting_menu.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  TimeProvider timeProvider = TimeProvider(DateTime.now());
  List<int> items = List.generate(30, (index) => index);
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    //_scrollController = ScrollController(initialScrollOffset: 65.0);
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0) {
          addMoreItems(items);
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          MyAdWidget(
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
                        MyButton(
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
                                builder: (context) => CountDownPage(),
                              ),
                            );
                          },
                        ),
                        if (second < items.length)
                          MyButton(
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
                                  builder: (context) => CountDownPage(),
                                ),
                              );
                            },
                          ),
                      ],
                    );
                  },
                ),
                // 左上に固定された設定アイコン
                Positioned(
                  right: MediaQuery.of(context).size.width / 2000,
                  child: SizedBox(
                    // SizedBoxを使用してサイズを指定
                    width: MediaQuery.of(context).size.width / 10,
                    height: MediaQuery.of(context).size.width / 10,
                    child: IconButton(
                      icon: Icon(
                        Icons.settings,
                        color: Colors.white,
                        size: MediaQuery.of(context).size.width /
                            12, // ここではIconButtonのサイズを直接指定しない
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(languageProvider.settingText(),
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              22.5)),
                              content: ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxHeight:
                                        MediaQuery.of(context).size.height / 3),
                                child: SettingMenu(),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          MyAdWidget(
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
