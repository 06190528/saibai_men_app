import 'dart:io';

class AdHelper {
  static bool _isTestMode = true;

  static String get bannerAdUnitId {
    if (_isTestMode) {
      return Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/6300978111'
          : 'ca-app-pub-3940256099942544/2934735716';
    }

    return Platform.isAndroid
        ? 'ca-app-pub-2847746899486154/6353017056'
        : 'ca-app-pub-2847746899486154/8704129716';
  }

  static String get interstitialAdUnitId {
    if (_isTestMode) {
      return Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/1033173712'
          : 'ca-app-pub-3940256099942544/4411468910';
    }

    return Platform.isAndroid
        ? 'ca-app-pub-2847746899486154/5875882902'
        : 'ca-app-pub-2847746899486154/7311171933';
  }

  static String get rewardedAdUnitId {
    if (_isTestMode) {
      // Return test ad unit IDs
      return Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/5224354917'
          : 'ca-app-pub-3940256099942544/1712485313';
    }

    return Platform.isAndroid
        ? '<YOUR_ANDROID_REWARDED_AD_UNIT_ID>'
        : 'ca-app-pub-2847746899486154/9551618004';
  }

  static void enableTestMode() {
    _isTestMode = true;
  }
}
