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
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'langage': langage.toString().split('.').last,
      'scoreList': scoreList,
    };
  }
}
