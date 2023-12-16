import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rush_time_app/logic/%20alarm.dart';
import 'package:rush_time_app/main.dart';
import 'package:rush_time_app/provider/langage_provider.dart';

class CancelTextButtonView extends StatelessWidget {
  const CancelTextButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);
    return TextButton(
      //キャンセルボタン
      child: Text(languageProvider.cancelText(),
          style: TextStyle(fontSize: width / 15)),
      onPressed: () {
        stopAlarm();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Main(),
          ),
        );
      },
    );
  }
}
