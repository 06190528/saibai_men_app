import 'package:saibai_men_app/common/language.dart';

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
