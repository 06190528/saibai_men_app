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
        return 'ポーズ';
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
        return 'コンティニュー';
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
        return 'リスタート';
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
        return 'スタート';
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

  String translationNormal(LanguageList language) {
    switch (language) {
      case LanguageList.USA:
        return 'Normal';
      case LanguageList.Japan:
        return 'ノーマル';
      case LanguageList.China:
        return '正常'; // 中国語（簡体字）
      case LanguageList.Germany:
        return 'Normal'; // ドイツ語
      case LanguageList.France:
        return 'Normal'; // フランス語
      case LanguageList.UK:
        return 'Normal'; // 英語（イギリス）
      case LanguageList.Brazil:
        return 'Normal'; // ポルトガル語（ブラジル）
      case LanguageList.Korea:
        return '일반'; // 韓国語
      case LanguageList.India:
        return 'सामान्य'; // ヒンディー語
      case LanguageList.Russia:
        return 'Нормальный'; // ロシア語
      default:
        return 'Normal';
    }
  }

  String translationHard(LanguageList language) {
    switch (language) {
      case LanguageList.USA:
        return 'Hard';
      case LanguageList.Japan:
        return 'ハード';
      case LanguageList.China:
        return '硬'; // 中国語（簡体字）
      case LanguageList.Germany:
        return 'Hart'; // ドイツ語
      case LanguageList.France:
        return 'Dur'; // フランス語
      case LanguageList.UK:
        return 'Hard'; // 英語（イギリス）
      case LanguageList.Brazil:
        return 'Difícil'; // ポルトガル語（ブラジル）
      case LanguageList.Korea:
        return '단단한'; // 韓国語
      case LanguageList.India:
        return 'कठिन'; // ヒンディー語
      case LanguageList.Russia:
        return 'Жесткий'; // ロシア語
      default:
        return 'Hard';
    }
  }

  String translationSelectMode(LanguageList language) {
    switch (language) {
      case LanguageList.USA:
        return 'Select Mode';
      case LanguageList.Japan:
        return 'モード選択';
      case LanguageList.China:
        return '选择模式'; // 中国語（簡体字）
      case LanguageList.Germany:
        return 'Modus auswählen'; // ドイツ語
      case LanguageList.France:
        return 'Sélectionner le mode'; // フランス語
      case LanguageList.UK:
        return 'Select Mode'; // 英語（イギリス）
      case LanguageList.Brazil:
        return 'Selecione o modo'; // ポルトガル語（ブラジル）
      case LanguageList.Korea:
        return '모드 선택'; // 韓国語
      case LanguageList.India:
        return 'मोड चुनें'; // ヒンディー語
      case LanguageList.Russia:
        return 'Выберите режим'; // ロシア語
      default:
        return 'Select Mode';
    }
  }

  String translationYourRanking(LanguageList language) {
    switch (language) {
      case LanguageList.USA:
        return 'Your Ranking';
      case LanguageList.Japan:
        return 'あなたのランキング';
      case LanguageList.China:
        return '您的排名'; // 中国語（簡体字）
      case LanguageList.Germany:
        return 'Ihr Ranking'; // ドイツ語
      case LanguageList.France:
        return 'Votre classement'; // フランス語
      case LanguageList.UK:
        return 'Your Ranking'; // 英語（イギリス）
      case LanguageList.Brazil:
        return 'Sua classificação'; // ポルトガル語（ブラジル）
      case LanguageList.Korea:
        return '당신의 순위'; // 韓国語
      case LanguageList.India:
        return 'आपकी रैंकिंग'; // ヒンディー語
      case LanguageList.Russia:
        return 'Ваш рейтинг'; // ロシア語
      default:
        return 'Your Ranking';
    }
  }

  String translationNowScore(LanguageList language) {
    switch (language) {
      case LanguageList.USA:
        return 'Now Score';
      case LanguageList.Japan:
        return '現在のスコア';
      case LanguageList.China:
        return '现在得分'; // 中国語（簡体字）
      case LanguageList.Germany:
        return 'Jetzt Punktzahl'; // ドイツ語
      case LanguageList.France:
        return 'Score actuel'; // フランス語
      case LanguageList.UK:
        return 'Now Score'; // 英語（イギリス）
      case LanguageList.Brazil:
        return 'Pontuação atual'; // ポルトガル語（ブラジル）
      case LanguageList.Korea:
        return '현재 점수'; // 韓国語
      case LanguageList.India:
        return 'अब स्कोर'; // ヒンディー語
      case LanguageList.Russia:
        return 'Текущий счет'; // ロシア語
      default:
        return 'Now Score';
    }
  }

  String translationRanking(LanguageList language) {
    switch (language) {
      case LanguageList.USA:
        return 'Ranking';
      case LanguageList.Japan:
        return 'ランキング';
      case LanguageList.China:
        return '排名'; // 中国語（簡体字）
      case LanguageList.Germany:
        return 'Rangliste'; // ドイツ語
      case LanguageList.France:
        return 'Classement'; // フランス語
      case LanguageList.UK:
        return 'Ranking'; // 英語（イギリス）
      case LanguageList.Brazil:
        return 'Classificação'; // ポルトガル語（ブラジル）
      case LanguageList.Korea:
        return '순위'; // 韓国語
      case LanguageList.India:
        return 'रैंकिंग'; // ヒンディー語
      case LanguageList.Russia:
        return 'Рейтинг'; // ロシア語
      default:
        return 'Ranking';
    }
  }

  String translationYes(LanguageList language) {
    switch (language) {
      case LanguageList.USA:
        return 'Yes';
      case LanguageList.Japan:
        return 'はい';
      case LanguageList.China:
        return '是'; // 中国語（簡体字）
      case LanguageList.Germany:
        return 'Ja'; // ドイツ語
      case LanguageList.France:
        return 'Oui'; // フランス語
      case LanguageList.UK:
        return 'Yes'; // 英語（イギリス）
      case LanguageList.Brazil:
        return 'Sim'; // ポルトガル語（ブラジル）
      case LanguageList.Korea:
        return '예'; // 韓国語
      case LanguageList.India:
        return 'हाँ'; // ヒンディー語
      case LanguageList.Russia:
        return 'Да'; // ロシア語
      default:
        return 'Yes';
    }
  }

  String translationNo(LanguageList language) {
    switch (language) {
      case LanguageList.USA:
        return 'No';
      case LanguageList.Japan:
        return 'いいえ';
      case LanguageList.China:
        return '没有'; // 中国語（簡体字）
      case LanguageList.Germany:
        return 'Nein'; // ドイツ語
      case LanguageList.France:
        return 'Non'; // フランス語
      case LanguageList.UK:
        return 'No'; // 英語（イギリス）
      case LanguageList.Brazil:
        return 'Não'; // ポルトガル語（ブラジル）
      case LanguageList.Korea:
        return '아니'; // 韓国語
      case LanguageList.India:
        return 'नहीं'; // ヒンディー語
      case LanguageList.Russia:
        return 'Нет'; // ロシア語
      default:
        return 'No';
    }
  }

  String translationWatchAd(LanguageList language) {
    switch (language) {
      case LanguageList.USA:
        return 'Would you like to watch an ad?';
      case LanguageList.Japan:
        return '広告を視聴しますか？';
      case LanguageList.China:
        return '你想要观看广告吗？'; // 中国語（簡体字）
      case LanguageList.Germany:
        return 'Möchten Sie eine Anzeige sehen?'; // ドイツ語
      case LanguageList.France:
        return 'Voulez-vous regarder une publicité?'; // フランス語
      case LanguageList.UK:
        return 'Would you like to watch an ad?'; // 英語（イギリス）
      case LanguageList.Brazil:
        return 'Você gostaria de assistir a um anúncio?'; // ポルトガル語（ブラジル）
      case LanguageList.Korea:
        return '광고를 시청하시겠습니까?'; // 韓国語
      case LanguageList.India:
        return 'क्या आप विज्ञापन देखना चाहेंगे?'; // ヒンディー語
      case LanguageList.Russia:
        return 'Хотите посмотреть рекламу?'; // ロシア語
      default:
        return 'Would you like to watch an ad?';
    }
  }

  String translationWatchAdToContinue(LanguageList language) {
    switch (language) {
      case LanguageList.USA:
        return 'Would you like to watch an ad to continue?';
      case LanguageList.Japan:
        return '広告を視聴してコンティニューしますか？';
      case LanguageList.China:
        return '你想要观看广告以继续吗？'; // 中国語（簡体字）
      case LanguageList.Germany:
        return 'Möchten Sie eine Anzeige sehen, um fortzufahren?'; // ドイツ語
      case LanguageList.France:
        return 'Voulez-vous regarder une publicité pour continuer?'; // フランス語
      case LanguageList.UK:
        return 'Would you like to watch an ad to continue?'; // 英語（イギリス）
      case LanguageList.Brazil:
        return 'Você gostaria de assistir a um anúncio para continuar?'; // ポルトガル語（ブラジル）
      case LanguageList.Korea:
        return '광고를 시청하고 계속하시겠습니까?'; // 韓国語
      case LanguageList.India:
        return 'क्या आप जारी रखने के लिए विज्ञापन देखना चाहेंगे?'; // ヒンディー語
      case LanguageList.Russia:
        return 'Хотите посмотреть рекламу, чтобы продолжить?'; // ロシア語
      default:
        return 'Would you like to watch an ad to continue?';
    }
  }

  String translationRunAway(LanguageList language) {
    switch (language) {
      case LanguageList.USA:
        return 'Run Away!!';
      case LanguageList.Japan:
        return '逃げろ！！';
      case LanguageList.China:
        return '逃跑！！'; // 中国語（簡体字）
      case LanguageList.Germany:
        return 'Lauf weg!!'; // ドイツ語
      case LanguageList.France:
        return 'Fuis!!'; // フランス語
      case LanguageList.UK:
        return 'Run Away!!'; // 英語（イギリス）
      case LanguageList.Brazil:
        return 'Fugir!!'; // ポルトガル語（ブラジル）
      case LanguageList.Korea:
        return '도망가!!'; // 韓国語
      case LanguageList.India:
        return 'भागो!!'; // ヒンディー語
      case LanguageList.Russia:
        return 'Беги!!'; // ロシア語
      default:
        return 'Run Away!!';
    }
  }
}
