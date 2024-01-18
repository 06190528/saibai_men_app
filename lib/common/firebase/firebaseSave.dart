import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:saibai_men_app/common/langage.dart';
import 'package:saibai_men_app/common/userData.dart';
import 'package:saibai_men_app/provider.dart';
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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String generateUniqueUserID() {
    var random = Random();
    int randomNumber = random.nextInt(1000); // 例: 0から999まで
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyyMMddHHmmss').format(now);
    String uniqueUserID = "${randomNumber}${formattedDate}";
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

  Future<void> saveUserData(
      String userId, Map<String, dynamic> userData) async {
    await _firestore.collection('users').doc(userId).set(userData);
  }

  Future<UserData> fetchUserData(String userId) async {
    DocumentSnapshot doc =
        await _firestore.collection('users').doc(userId).get();

    if (doc.exists) {
      // ドキュメントが存在する場合、そのデータを使ってUserDataインスタンスを作成
      return UserData.fromMap(doc.data() as Map<String, dynamic>);
    } else {
      // デフォルト値を持つUserDataインスタンスを返す
      return UserData(
        name: '',
        langage: LangageList.Japan,
        scoreList: [],
      );
    }
  }
}

Future<void> initialize(WidgetRef ref) async {
  UserDataService userDataService = UserDataService();
  String userId = await userDataService.getUserId();

  // Firestoreからユーザーデータを取得
  UserData userData = await userDataService.fetchUserData(userId);

  // Riverpodプロバイダーを更新
  ref.read(userDataProvider.notifier).state = userData;
  print(ref.read(userDataProvider.state).state.scoreList);
}

Future<void> setUserData(UserData userData) async {
  String userId = await UserDataService().getUserId();
  await UserDataService().saveUserData(
    userId,
    userData.toMap(),
  );
}

List<int> sortScoreList(UserData userData) {
  List<int> scoreList = userData.scoreList;
  scoreList.sort((a, b) => b.compareTo(a));
  return scoreList;
}
