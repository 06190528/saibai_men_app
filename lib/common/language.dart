import 'package:firebase_auth/firebase_auth.dart';
import 'package:saibai_men_app/provider.dart';

enum LanguageList {
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
Map<LanguageList, String> langageNames = {
  LanguageList.USA: "United States",
  LanguageList.Japan: "日本",
  LanguageList.China: "中国",
  LanguageList.Germany: "Deutschland",
  LanguageList.France: "France",
  LanguageList.UK: "United Kingdom",
  LanguageList.Brazil: "Brasil",
  LanguageList.Korea: "대한민국",
  LanguageList.India: "भारत",
  LanguageList.Russia: "Россия",
};

class Language {
  String translationSave(LanguageList language) {
    switch (language) {
      case LanguageList.USA:
        return 'Save';
      case LanguageList.Japan:
        return '保存';
      case LanguageList.China:
        return '保存'; // 中国語（簡体字）
      case LanguageList.Germany:
        return 'Speichern'; // ドイツ語
      case LanguageList.France:
        return 'Sauvegarder'; // フランス語
      case LanguageList.UK:
        return 'Save'; // 英語（イギリス）
      case LanguageList.Brazil:
        return 'Salvar'; // ポルトガル語（ブラジル）
      case LanguageList.Korea:
        return '저장'; // 韓国語
      case LanguageList.India:
        return 'सहेजें'; // ヒンディー語
      case LanguageList.Russia:
        return 'Сохранить'; // ロシア語
      default:
        return 'Save';
    }
  }

  String translationCancel(LanguageList language) {
    switch (language) {
      case LanguageList.USA:
        return 'Cancel';
      case LanguageList.Japan:
        return 'キャンセル';
      case LanguageList.China:
        return '取消'; // 中国語（簡体字）
      case LanguageList.Germany:
        return 'Abbrechen'; // ドイツ語
      case LanguageList.France:
        return 'Annuler'; // フランス語
      case LanguageList.UK:
        return 'Cancel'; // 英語（イギリス）
      case LanguageList.Brazil:
        return 'Cancelar'; // ポルトガル語（ブラジル）
      case LanguageList.Korea:
        return '취소'; // 韓国語
      case LanguageList.India:
        return 'रद्द करें'; // ヒンディー語
      case LanguageList.Russia:
        return 'Отмена'; // ロシア語
      default:
        return 'Cancel';
    }
  }

  String translationPause(LanguageList language) {
    switch (language) {
      case LanguageList.USA:
        return 'Pause';
      case LanguageList.Japan:
        return '一時停止';
      case LanguageList.China:
        return '暂停'; // 中国語（簡体字）
      case LanguageList.Germany:
        return 'Pause'; // ドイツ語
      case LanguageList.France:
        return 'Pause'; // フランス語
      case LanguageList.UK:
        return 'Pause'; // 英語（イギリス）
      case LanguageList.Brazil:
        return 'Pausa'; // ポルトガル語（ブラジル）
      case LanguageList.Korea:
        return '일시 정지'; // 韓国語
      case LanguageList.India:
        return 'रोक'; // ヒンディー語
      case LanguageList.Russia:
        return 'Пауза'; // ロシア語
      default:
        return 'Pause';
    }
  }

  String translationContinue(LanguageList language) {
    switch (language) {
      case LanguageList.USA:
        return 'Continue';
      case LanguageList.Japan:
        return '続行';
      case LanguageList.China:
        return '继续'; // 中国語（簡体字）
      case LanguageList.Germany:
        return 'Fortsetzen'; // ドイツ語
      case LanguageList.France:
        return 'Continuer'; // フランス語
      case LanguageList.UK:
        return 'Continue'; // 英語（イギリス）
      case LanguageList.Brazil:
        return 'Continuar'; // ポルトガル語（ブラジル）
      case LanguageList.Korea:
        return '계속'; // 韓国語
      case LanguageList.India:
        return 'जारी रखें'; // ヒンディー語
      case LanguageList.Russia:
        return 'Продолжить'; // ロシア語
      default:
        return 'Continue';
    }
  }

  String translationRestart(LanguageList language) {
    switch (language) {
      case LanguageList.USA:
        return 'Restart';
      case LanguageList.Japan:
        return '再起動';
      case LanguageList.China:
        return '重新开始'; // 中国語（簡体字）
      case LanguageList.Germany:
        return 'Neustart'; // ドイツ語
      case LanguageList.France:
        return 'Redémarrer'; // フランス語
      case LanguageList.UK:
        return 'Restart'; // 英語（イギリス）
      case LanguageList.Brazil:
        return 'Reiniciar'; // ポルトガル語（ブラジル）
      case LanguageList.Korea:
        return '재시작'; // 韓国語
      case LanguageList.India:
        return 'पुनः आरंभ करें'; // ヒンディー語
      case LanguageList.Russia:
        return 'Перезапустить'; // ロシア語
      default:
        return 'Restart';
    }
  }

  String translationBack(LanguageList language) {
    switch (language) {
      case LanguageList.USA:
        return 'Back';
      case LanguageList.Japan:
        return '戻る';
      case LanguageList.China:
        return '返回'; // 中国語（簡体字）
      case LanguageList.Germany:
        return 'Zurück'; // ドイツ語
      case LanguageList.France:
        return 'Retour'; // フランス語
      case LanguageList.UK:
        return 'Back'; // 英語（イギリス）
      case LanguageList.Brazil:
        return 'Voltar'; // ポルトガル語（ブラジル）
      case LanguageList.Korea:
        return '뒤로'; // 韓国語
      case LanguageList.India:
        return 'वापस'; // ヒンディー語
      case LanguageList.Russia:
        return 'Назад'; // ロシア語
      default:
        return 'Back';
    }
  }

  String translationStart(LanguageList language) {
    switch (language) {
      case LanguageList.USA:
        return 'Start';
      case LanguageList.Japan:
        return '開始';
      case LanguageList.China:
        return '开始'; // 中国語（簡体字）
      case LanguageList.Germany:
        return 'Start'; // ドイツ語
      case LanguageList.France:
        return 'Début'; // フランス語
      case LanguageList.UK:
        return 'Start'; // 英語（イギリス）
      case LanguageList.Brazil:
        return 'Começar'; // ポルトガル語（ブラジル）
      case LanguageList.Korea:
        return '시작'; // 韓国語
      case LanguageList.India:
        return 'शुरू'; // ヒンディー語
      case LanguageList.Russia:
        return 'Начать'; // ロシア語
      default:
        return 'Start';
    }
  }

  String translationResult(LanguageList language) {
    switch (language) {
      case LanguageList.USA:
        return 'Result';
      case LanguageList.Japan:
        return '結果';
      case LanguageList.China:
        return '结果'; // 中国語（簡体字）
      case LanguageList.Germany:
        return 'Ergebnis'; // ドイツ語
      case LanguageList.France:
        return 'Résultat'; // フランス語
      case LanguageList.UK:
        return 'Result'; // 英語（イギリス）
      case LanguageList.Brazil:
        return 'Resultado'; // ポルトガル語（ブラジル）
      case LanguageList.Korea:
        return '결과'; // 韓国語
      case LanguageList.India:
        return 'परिणाम'; // ヒンディー語
      case LanguageList.Russia:
        return 'Результат'; // ロシア語
      default:
        return 'Result';
    }
  }

  String translationScore(LanguageList language) {
    switch (language) {
      case LanguageList.USA:
        return 'Score';
      case LanguageList.Japan:
        return 'スコア';
      case LanguageList.China:
        return '得分'; // 中国語（簡体字）
      case LanguageList.Germany:
        return 'Punktzahl'; // ドイツ語
      case LanguageList.France:
        return 'Score'; // フランス語
      case LanguageList.UK:
        return 'Score'; // 英語（イギリス）
      case LanguageList.Brazil:
        return 'Pontuação'; // ポルトガル語（ブラジル）
      case LanguageList.Korea:
        return '점수'; // 韓国語
      case LanguageList.India:
        return 'स्कोर'; // ヒンディー語
      case LanguageList.Russia:
        return 'Счет'; // ロシア語
      default:
        return 'Score';
    }
  }

  String translationBestScore(LanguageList language) {
    switch (language) {
      case LanguageList.USA:
        return 'Best Score';
      case LanguageList.Japan:
        return 'ベストスコア';
      case LanguageList.China:
        return '最佳得分'; // 中国語（簡体字）
      case LanguageList.Germany:
        return 'Beste Punktzahl'; // ドイツ語
      case LanguageList.France:
        return 'Meilleur score'; // フランス語
      case LanguageList.UK:
        return 'Best Score'; // 英語（イギリス）
      case LanguageList.Brazil:
        return 'Melhor pontuação'; // ポルトガル語（ブラジル）
      case LanguageList.Korea:
        return '최고 점수'; // 韓国語
      case LanguageList.India:
        return 'सर्वश्रेष्ठ स्कोर'; // ヒンディー語
      case LanguageList.Russia:
        return 'Лучший счет'; // ロシア語
      default:
        return 'Best Score';
    }
  }

  String translationUserSetting(LanguageList language) {
    switch (language) {
      case LanguageList.USA:
        return 'User Setting';
      case LanguageList.Japan:
        return 'ユーザー設定';
      case LanguageList.China:
        return '用户设定'; // 中国語（簡体字）
      case LanguageList.Germany:
        return 'Benutzereinstellung'; // ドイツ語
      case LanguageList.France:
        return 'Paramètre utilisateur'; // フランス語
      case LanguageList.UK:
        return 'User Setting'; // 英語（イギリス）
      case LanguageList.Brazil:
        return 'Configuração do usuário'; // ポルトガル語（ブラジル）
      case LanguageList.Korea:
        return '사용자 설정'; // 韓国語
      case LanguageList.India:
        return 'उपयोगकर्ता सेटिंग'; // ヒンディー語
      case LanguageList.Russia:
        return 'Настройка пользователя'; // ロシア語
      default:
        return 'User Setting';
    }
  }
}
