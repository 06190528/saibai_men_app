import 'dart:io';

class AdHelper {
  static bool _isTestMode = false;

  static String get bannerAdUnitId {
    if (_isTestMode) {
      return Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/6300978111'
          : 'ca-app-pub-3940256099942544/2934735716';
    }

    return Platform.isAndroid
        ? 'ca-app-pub-2847746899486154/1486063753'
        : 'ca-app-pub-2847746899486154/5344180613';
  }

  static String get interstitialAdUnitId {
    if (_isTestMode) {
      return Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/1033173712'
          : 'ca-app-pub-3940256099942544/4411468910';
    }

    return Platform.isAndroid
        ? 'ca-app-pub-2847746899486154/7778379057'
        : 'ca-app-pub-2847746899486154/2836031803';
  }

  static String get rewardedAdUnitId {
    if (_isTestMode) {
      // Return test ad unit IDs
      return Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/5224354917'
          : 'ca-app-pub-3940256099942544/1712485313';
    }

    return Platform.isAndroid
        ? 'ca-app-pub-2847746899486154/5152215716'
        : 'ca-app-pub-2847746899486154/9551618004';
  }

  static String get nativeAdUnitId {
    if (_isTestMode) {
      return Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/2247696110'
          : 'ca-app-pub-3940256099942544/3986624511';
    }

    return Platform.isAndroid
        ? 'ca-app-pub-2847746899486154/9551618004'
        : 'ca-app-pub-2847746899486154/2152671377';
  }

  static String get startUpAdUnitId {
    if (_isTestMode) {
      return Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/1033173712'
          : 'ca-app-pub-3940256099942544/4411468910';
    }

    return Platform.isAndroid
        ? 'ca-app-pub-2847746899486154/9551618004'
        : 'ca-app-pub-2847746899486154/1771072892';
  }

  static void enableTestMode() {
    _isTestMode = true;
  }
}
