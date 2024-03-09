import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:saibai_men_app/common/language.dart';
import 'package:saibai_men_app/common/ranking.dart';
import 'package:saibai_men_app/common/userData.dart';
import 'package:saibai_men_app/mainWidget/rankingScene.dart';
import 'package:saibai_men_app/provider.dart';
import 'package:saibai_men_app/widget/settingDialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 匿名ユーザーとしてログイン
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
      // 独自のユーザーIDを生成する
      userId = generateUniqueUserID();
      await prefs.setString('user_id', userId);
    }
    return userId;
  }

  Future<void> saveUserDataToLocal(Map<String, dynamic> userData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // MapをJSON文字列に変換
    String userDataString = json.encode(userData);
    // JSON文字列をSharedPreferencesに保存
    await prefs.setString('user_data', userDataString);
  }
}

//この時点でデーター保存されてない
Future<void> saveUserDataFromLocalToProvider(WidgetRef ref) async {
  //確定でuserDataがローカルにある。
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userDataString = prefs.getString('user_data');
  if (userDataString != null) {
    // JSON文字列をMapに変換
    Map<String, dynamic> userDataMap = json.decode(userDataString);
    // MapをUserDataに変換
    UserData userData = UserData.fromMap(userDataMap);
    // userDataProviderにデータを設定
    ref.read(userDataProvider.notifier).state = userData;
  }
  setUserScoreMaxToProvider(ref);
  getAndSaveRankingDataFromIFirebaseToProvider(ref);
}

//初回起動時に匿名ユーザーとしてログイン
Future<void> initializeUserData() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userDataString = prefs.getString('user_data');
  if (userDataString == null) {
    // 初回起動時は匿名ユーザーとしてログイン
    User? user = await AuthService().signInAnonymously();
    if (user != null) {
      // 匿名ユーザーのデータを作成
      UserData userData = UserData(
        name: '',
        scoreList: [],
        language: LanguageList.Japan,
      );
      // ローカルに保存
      await UserDataService().saveUserDataToLocal(userData.toMap());
      // Firestoreに保存
      await setUserDataToIFirebase(userData);
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

//ここ
Future<void> getAndSaveRankingDataFromIFirebaseToProvider(WidgetRef ref) async {
  ref.read(isLoadingProvider.notifier).state = true; // ローディング開始

  QuerySnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('users').get();

  List<Ranking> rankingList = snapshot.docs.map((doc) {
    Map<String, dynamic> data = doc.data();
    List<dynamic> scoreList = data['scoreList'] ?? [];
    int maxScore = scoreList.isNotEmpty
        ? scoreList.reduce((curr, next) => curr > next ? curr : next)
        : 0;
    return Ranking(
      id: doc.id,
      name: data['name'],
      maxScore: maxScore,
    );
  }).toList();
  rankingList.sort((a, b) => b.maxScore.compareTo(a.maxScore));
  ref.read(rankingListProvider.notifier).state = rankingList;
  getUserRanking(rankingList, ref);
  ref.read(isLoadingProvider.notifier).state = false; // ローディング終了
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
