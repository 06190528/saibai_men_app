import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:saibai_men_app/common/ad_helper.dart';
import 'package:saibai_men_app/logic/gameWidgetLogic.dart';
import 'package:saibai_men_app/provider.dart';

class RewardAdLoader {
  static RewardedAd? _rewardedAd;
  final WidgetRef ref;

  RewardAdLoader({required this.ref});

  void loadAndShowRewardAd(BuildContext context) {
    // 既存の広告を破棄
    _rewardedAd?.dispose();

    // ロード中のインジケータを表示
    ref.read(isLoadingProvider.state).state = true;

    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          _rewardedAd = ad;

          // 広告を表示
          ad.show(onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
            // ユーザーに報酬を与える処理
            GameWidgetLogic(context, ref).continueGame();
            ref.read(isLoadingProvider.state).state = false;
          });

          // 広告の表示後のコールバックを設定
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (RewardedAd ad) {
              ad.dispose();
            },
            onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
              ad.dispose();
            },
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          // ロードに失敗したので、インジケータを非表示にする
          ref.read(isLoadingProvider.state).state = false;
          print('RewardedAd failed to load: $error');
        },
      ),
    );
  }
}
