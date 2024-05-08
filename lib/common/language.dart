enum LanguageList {
  USA, // United States
  Japan, // 日本
  Chinese, // 中国
}

// このenumを使用してDropdownMenuItemリストを作成するときは、以下のマッピングを使用できます
Map<LanguageList, String> langageNames = {
  LanguageList.USA: "United States",
  LanguageList.Japan: "日本",
  LanguageList.Chinese: "中国",
};

class Language {
  String translationSave(LanguageList language) {
    switch (language) {
      case LanguageList.USA:
        return 'Save';
      case LanguageList.Japan:
        return '保存';
      case LanguageList.Chinese:
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
      case LanguageList.Chinese:
        return '取消';
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
      case LanguageList.Chinese:
        return '暂停';
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
      case LanguageList.Chinese:
        return '继续';
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
      case LanguageList.Chinese:
        return '重新开始';
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
      case LanguageList.Chinese:
        return '返回';
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
      case LanguageList.Chinese:
        return '开始';
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
      case LanguageList.Chinese:
        return '结果';
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
      case LanguageList.Chinese:
        return '分数';
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
      case LanguageList.Chinese:
        return '最高分';
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
      case LanguageList.Chinese:
        return '用户设置';
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
      case LanguageList.Chinese:
        return '正常';
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
      case LanguageList.Chinese:
        return '困难';
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
      case LanguageList.Chinese:
        return '容易';
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
      case LanguageList.Chinese:
        return '选择模式';
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
      case LanguageList.Chinese:
        return '您的排名';
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
      case LanguageList.Chinese:
        return '现在的分数';
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
      case LanguageList.Chinese:
        return '排名';
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
      case LanguageList.Chinese:
        return '是';
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
      case LanguageList.Chinese:
        return '没有';
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
      case LanguageList.Chinese:
        return '您想观看广告吗？';
      default:
        return 'Would you like to watch an ad?';
    }
  }

  String translationWatchAdToContinue(LanguageList language) {
    switch (language) {
      case LanguageList.USA:
        return 'Would you like to watch an ad to continue?';
      case LanguageList.Japan:
        return '広告を視聴して報酬を受け取りますか？';
      case LanguageList.Chinese:
        return '您想观看广告以继续吗？';
      default:
        return 'Would you like to watch an ad to receive a reward?';
    }
  }

  String translationRunAway(LanguageList language) {
    switch (language) {
      case LanguageList.USA:
        return 'Run Away!!';
      case LanguageList.Japan:
        return '逃げろ！！';
      case LanguageList.Chinese:
        return '逃跑！！';
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
      case LanguageList.Chinese:
        return '名字';
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
      case LanguageList.Chinese:
        return '游戏结束';
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
      case LanguageList.Chinese:
        return '游戏结束';
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
      case LanguageList.Chinese:
        return '目标分数';
      default:
        return 'Goal Score';
    }
  }

  String translationPlace(LanguageList language) {
    switch (language) {
      case LanguageList.USA:
        return 'Place';
      case LanguageList.Japan:
        return '位';
      case LanguageList.Chinese:
        return '地方';
      default:
        return 'Place';
    }
  }

  String translationTouch(LanguageList language) {
    switch (language) {
      case LanguageList.USA:
        return 'Touch';
      case LanguageList.Japan:
        return 'タッチ';
      case LanguageList.Chinese:
        return '触摸';
      default:
        return 'Touch';
    }
  }

  String translationNotEnoughCoins(LanguageList language) {
    switch (language) {
      case LanguageList.USA:
        return 'Not enough coins';
      case LanguageList.Japan:
        return 'コインが足りません';
      case LanguageList.Chinese:
        return '硬币不够';
      default:
        return 'Not enough coins';
    }
  }

  String translationSortieCharacter(LanguageList language) {
    switch (language) {
      case LanguageList.USA:
        return 'Sortie Character';
      case LanguageList.Japan:
        return '出撃キャラクター';
      case LanguageList.Chinese:
        return '出击角色';
      default:
        return 'Sortie Character';
    }
  }

  String translationGatya(LanguageList language) {
    switch (language) {
      case LanguageList.USA:
        return 'Gacha';
      case LanguageList.Japan:
        return 'ガチャ';
      case LanguageList.Chinese:
        return '扭蛋';
      default:
        return 'Gacha';
    }
  }

  String translationGatyaByCoins(LanguageList language) {
    switch (language) {
      case LanguageList.USA:
        return 'Gacha by 10 coins';
      case LanguageList.Japan:
        return '10コインでガチャ';
      case LanguageList.Chinese:
        return '10个硬币的扭蛋';
      default:
        return 'Gacha by 10 coins';
    }
  }

  String translationWatchAdToGetCoins(LanguageList language) {
    switch (language) {
      case LanguageList.USA:
        return 'Watch an ad to get 20 coins';
      case LanguageList.Japan:
        return '広告を視聴して20コインをゲット';
      case LanguageList.Chinese:
        return '观看广告以获得20个硬币';
      default:
        return 'Watch an ad to get 20 coins';
    }
  }
}
