import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saibai_men_app/common/language.dart';
import 'package:saibai_men_app/provider.dart';

class UserData {
  String name;
  LanguageList language;
  List<int> scoreList;

  UserData({
    required this.name,
    required this.scoreList,
    required this.language,
  });

  // FirestoreのドキュメントからUserDataオブジェクトを作成するファクトリメソッド
  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      name: map['name'] ?? '',
      language: map['language'] != null
          ? LanguageList.values.firstWhere(
              (e) =>
                  e.toString() == 'LanguageList.' + (map['language'] ?? 'USA'),
              orElse: () => LanguageList.Japan,
            )
          : LanguageList.Japan,
      scoreList: List<int>.from(map['scoreList'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'language': language.toString().split('.').last, // Enumを文字列に変換
      'scoreList': scoreList,
    };
  }
}

void setUserScoreMaxToProvider(WidgetRef ref) {
  final userData = ref.read(userDataProvider.notifier).state;
  ref.read(userMaxScoreProvider.state).state = userData.scoreList.isEmpty
      ? 0
      : userData.scoreList.reduce((a, b) => a > b ? a : b);
  print('userMaxScoreProvider: ${ref.read(userMaxScoreProvider)}');
  setUserModeToProvider(ref);
}

void setUserModeToProvider(WidgetRef ref) {
  final userMaxScore = ref.read(userMaxScoreProvider.state).state;
  if (userMaxScore < 100) {
    ref.read(userModeProvider.state).state = 0;
  } else if (userMaxScore < 400) {
    ref.read(userModeProvider.state).state = 1;
  } else if (userMaxScore >= 400) {
    ref.read(userModeProvider.state).state = 2;
  }
}

void setGameModeToProvider(WidgetRef ref, String text) {
  final userData = ref.read(userDataProvider);
  if (text == Language().translationEasy(userData.language)) {
    ref.read(gameModeProvider.state).state = 0;
  } else if (text == Language().translationNormal(userData.language)) {
    ref.read(gameModeProvider.state).state = 1;
  } else if (text == Language().translationHard(userData.language)) {
    ref.read(gameModeProvider.state).state = 2;
  }
}
