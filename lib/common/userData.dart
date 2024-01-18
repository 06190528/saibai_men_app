import 'package:saibai_men_app/common/langage.dart';

class UserData {
  String name;
  LangageList langage;
  List<int> scoreList;

  UserData({
    required this.name,
    required this.scoreList,
    required this.langage,
  });

  // FirestoreのドキュメントからUserDataオブジェクトを作成するファクトリメソッド
  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      name: map['name'] ?? '',
      langage: LangageList.values.firstWhere(
        (e) => e.toString() == 'LangageList.' + (map['langage'] ?? 'Japan'),
        orElse: () => LangageList.Japan,
      ),
      scoreList: List<int>.from(map['scoreList'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'langage': langage.toString().split('.').last, // Enumを文字列に変換
      'scoreList': scoreList,
    };
  }
}
