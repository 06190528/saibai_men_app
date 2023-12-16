import 'package:flutter/material.dart';
import 'package:rush_time_app/logic/time.dart';

class TimeButton extends StatelessWidget {
  final int index;
  final VoidCallback onPressed;
  final DateTime time; // timeのデータ型をStringとして指定

  const TimeButton({super.key, 
    required this.index,
    required this.onPressed,
    required this.time, // colorを初期化
  });

  @override
  Widget build(BuildContext context) {
    double? buttonWidth = MediaQuery.of(context).size.width / 3;
    // 時間と分を2桁の形式でフォーマット
    String formattedTime = DateTimeToString(time); // 正しく定義された行

    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(185, 254, 165, 0),
        ),
        child: SizedBox(
            height: MediaQuery.of(context).size.width / 6,
            width: buttonWidth,
            child: Center(
              child: Text(
                formattedTime,
                style: TextStyle(
                  color: Colors
                      .white, // Theme.of(context).textThemeを使用することを検討してください
                  fontSize: buttonWidth / 12, // 例としての最大サイズ
                ),
              ),
            )),
      ),
    );
  }
}
