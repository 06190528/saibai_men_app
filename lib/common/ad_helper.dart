import 'dart:io';

class AdHelper {
  // Debug or test mode flags
  static bool _isTestMode =
      false; // This could beR set based on some condition or environment variable

  static String get bannerAdUnitId {
    if (_isTestMode) {
      // Return test ad unit IDs
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
      // Return test ad unit IDs
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
        : '<YOUR_IOS_REWARDED_AD_UNIT_ID>';
  }

  // You can add a method to set the test mode
  static void enableTestMode() {
    _isTestMode = true;
  }
}

// You could then call AdHelper.enableTestMode() somewhere in your app initialization code
// to enable test ads during development or testing.
