import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:saibai_men_app/common/language.dart';
import 'package:saibai_men_app/common/ranking.dart';
import 'package:saibai_men_app/common/data/userData.dart';
import 'package:saibai_men_app/provider.dart';
import 'package:saibai_men_app/widget/adwidget/interstitialAdWidget.dart';
import 'package:saibai_men_app/widget/dialog/settingDialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInAnonymously() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }
}

class UserDataService {
  String generateUniqueUserID() {
    var random = Random();
    int randomNumber = random.nextInt(1000); // 例: 0から999まで
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyyMMddHHmmss').format(now);
    String uniqueUserID = "${formattedDate}${randomNumber}";
    return uniqueUserID;
  }

  Future<String> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('user_id');

    if (userId == null) {
      userId = generateUniqueUserID();
      await prefs.setString('user_id', userId);
    }
    return userId;
  }

  Future<void> saveUserDataToLocal(Map<String, dynamic> userData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userDataString = json.encode(userData);
    await prefs.setString('user_data', userDataString);
  }
}

Future<void> saveUserDataFromLocalToProvider(WidgetRef ref) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userDataString = prefs.getString('user_data');
  if (userDataString != null) {
    Map<String, dynamic> userDataMap = json.decode(userDataString);
    UserData userData = UserData.fromMap(userDataMap);
    ref.read(userDataProvider.notifier).updateUserData(userData, ref);
    ref.read(getCoinCountProvider.state).state = userData.coin;
  }
  ref.read(loadingProgressProvider.state).state += 30;
}

Future<void> initializeUserData() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userDataString = prefs.getString('user_data');
  if (userDataString == null) {
    User? user = await AuthService().signInAnonymously();
    if (user != null) {
      AdInterstitial().createAd();
      UserData userData = UserData(
        name: '',
        scoreList: [],
        language: LanguageList.Japan,
        coin: 0,
      );
      UserDataService().saveUserDataToLocal(userData.toMap());
      setUserDataToIFirebase(userData);
    }
  }
}

Future<void> setUserDataToIFirebase(UserData? userData) async {
  String userId = await UserDataService().getUserId();
  if (userData != null) {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set(userData.toMap());
  }
}

Future<void> getAndSaveRankingDataFromIFirebaseToProvider(WidgetRef ref) async {
  DocumentSnapshot<Map<String, dynamic>> ranking =
      await FirebaseFirestore.instance.collection('ranking').doc('1').get();
  ref.read(loadingProgressProvider.state).state += 30;
  final rankingLength = ranking.data()!['ranking'].length;
  for (int i = 0; i < rankingLength; i++) {
    await Future.delayed(Duration.zero);
    var name = ranking.data()!['ranking'][i]['name'];
    var maxScore = ranking.data()!['ranking'][i]['maxScore'];
    var id = ranking.data()!['ranking'][i]['id'];
    ref
        .read(rankingListProvider.notifier)
        .state
        .add(Ranking(name: name, maxScore: maxScore, id: id));
  }
  ref.read(loadingProgressProvider.state).state += 30;
  await addUserNewMaxScoreToRankingListProviderAndGetUserRanking(ref);
}

Future<void> showUserSettingsDialog(WidgetRef ref, BuildContext context) async {
  UserData userData = ref.read(userDataProvider);
  if (userData.name == '' && userData.scoreList.isNotEmpty) {
    await showDialog(
      context: context,
      builder: (context) {
        return const UserSettingsDialog();
      },
    );
  }
}

Future<void> addUserNewMaxScoreToRankingListProviderAndGetUserRanking(
  WidgetRef ref,
) async {
  final newMaxScore = ref.read(userMaxScoreProvider);
  List<Ranking> rankingList = ref.read(rankingListProvider.notifier).state;
  final userId = await UserDataService().getUserId();
  var userRank =
      (rankingList.indexWhere((element) => element.id == userId) + 1);
  if (userRank == 0) {
    userRank = rankingList.length + 1;
  } else if (rankingList[userRank].maxScore < newMaxScore) {
    rankingList[userRank].maxScore = newMaxScore;
    rankingList.sort((a, b) => b.maxScore.compareTo(a.maxScore));
    ref.read(rankingListProvider.notifier).state = rankingList;
  }
  ref.read(userRankingProvider.notifier).state = userRank;
  ref.read(loadingProgressProvider.state).state += 10;
}
