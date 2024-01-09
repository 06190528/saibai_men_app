import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:saibai_men_app/common/langage.dart';
import 'package:saibai_men_app/common/userData.dart';
import 'package:shared_preferences/shared_preferences.dart';

String generateUniqueUserID() {
  var random = Random();
  int randomNumber = random.nextInt(1000);
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('yyyyMMddHHmmss').format(now);
  String uniqueUserID = "${randomNumber}${formattedDate}";
  return uniqueUserID;
}

Future<bool> isFirstRun() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool firstRun = prefs.getBool('first_run') ?? true;
  if (firstRun) {
    prefs.setBool('first_run', false);
  }
  return firstRun;
}

Future<void> saveUserData() async {
  if (await isFirstRun()) {
    print('初回起動だよ');
    String userId = generateUniqueUserID();

    var userData = UserData(
      name: '匿名',
      langage: LangageList.Japan,
      scoreList: [10, 20, 30],
    ).toMap();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set(userData);
  }
  print('saveUserData呼ばれたよ');
}
