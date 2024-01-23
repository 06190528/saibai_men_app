import 'package:firebase_auth/firebase_auth.dart';
import 'package:saibai_men_app/provider.dart';

enum LangageList {
  USA, // United States
  Japan, // 日本
  China, // 中国
  Germany, // Deutschland
  France, // France
  UK, // United Kingdom
  Brazil, // Brasil
  Korea, // 대한민국
  India, // भारत
  Russia, // Россия
}

// このenumを使用してDropdownMenuItemリストを作成するときは、以下のマッピングを使用できます
Map<LangageList, String> langageNames = {
  LangageList.USA: "United States",
  LangageList.Japan: "日本",
  LangageList.China: "中国",
  LangageList.Germany: "Deutschland",
  LangageList.France: "France",
  LangageList.UK: "United Kingdom",
  LangageList.Brazil: "Brasil",
  LangageList.Korea: "대한민국",
  LangageList.India: "भारत",
  LangageList.Russia: "Россия",
};

class Langage {
  String translationSave(LangageList langage) {
    switch (langage) {
      case LangageList.USA:
        return 'Save';
      case LangageList.Japan:
        return '保存';
      case LangageList.China:
        return '保存'; // 中国語（簡体字）
      case LangageList.Germany:
        return 'Speichern'; // ドイツ語
      case LangageList.France:
        return 'Sauvegarder'; // フランス語
      case LangageList.UK:
        return 'Save'; // 英語（イギリス）
      case LangageList.Brazil:
        return 'Salvar'; // ポルトガル語（ブラジル）
      case LangageList.Korea:
        return '저장'; // 韓国語
      case LangageList.India:
        return 'सहेजें'; // ヒンディー語
      case LangageList.Russia:
        return 'Сохранить'; // ロシア語
      default:
        return 'Save';
    }
  }
}
