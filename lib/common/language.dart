enum LanguageList {
  USA, // United States
  Japan, // 日本
}

// このenumを使用してDropdownMenuItemリストを作成するときは、以下のマッピングを使用できます
Map<LanguageList, String> langageNames = {
  LanguageList.USA: "United States",
  LanguageList.Japan: "日本",
};

class Language {
  String translationSave(LanguageList language) {
    switch (language) {
      case LanguageList.USA:
        return 'Save';
      case LanguageList.Japan:
        return '保存';
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
      default:
        return 'Hard';
    }
  }

  String translationEasy(LanguageList language) {
    switch (language) {
      case LanguageList.USA:
        return 'Easy';
      case LanguageList.Japan:
        return 'イージー';
      default:
        return 'Easy';
    }
  }

  String translationSelectMode(LanguageList language) {
    switch (language) {
      case LanguageList.USA:
        return 'Select Mode';
      case LanguageList.Japan:
        return 'モード選択';
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
      default:
        return 'Run Away!!';
    }
  }

  String translationName(LanguageList language) {
    switch (language) {
      case LanguageList.USA:
        return 'Name';
      case LanguageList.Japan:
        return '名前';
      default:
        return 'Name';
    }
  }

  String translationGameClear(LanguageList language) {
    switch (language) {
      case LanguageList.USA:
        return 'Game Clear';
      case LanguageList.Japan:
        return 'ゲームクリア';
      default:
        return 'Game Clear';
    }
  }

  String translationGameOver(LanguageList language) {
    switch (language) {
      case LanguageList.USA:
        return 'Game Over';
      case LanguageList.Japan:
        return 'ゲームオーバー';
      default:
        return 'Game Over';
    }
  }

  String translationGoalScore(LanguageList language) {
    switch (language) {
      case LanguageList.USA:
        return 'Goal Score';
      case LanguageList.Japan:
        return 'ゴールスコア';
      default:
        return 'Goal Score';
    }
  }
}
