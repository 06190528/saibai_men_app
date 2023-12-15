import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rush_time_app/logic/%20alarm.dart';
import 'package:rush_time_app/main.dart';
import 'package:rush_time_app/provider/langage_provider.dart';

Future<void> showAlarmFinishedDialog(BuildContext context) async {
  final languageProvider =
      Provider.of<LanguageProvider>(context, listen: false);
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // ユーザーがダイアログ外をタップしても閉じない
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(languageProvider.timeOutText(),
            style: TextStyle(fontSize: MediaQuery.of(context).size.width / 30)),
        actions: <Widget>[
          TextButton(
            child: Text(languageProvider.stopAram(),
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 30)),
            onPressed: () {
              stopAlarm();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Main(),
                ),
              );
              Navigator.of(context).pop(); // ダイアログを閉じる
            },
          ),
        ],
      );
    },
  );
}
