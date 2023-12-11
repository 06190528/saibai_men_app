import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rush_time_app/common/ad_helper.dart';

class MyAdWidget extends StatelessWidget {
  final BannerAd myBanner;
  final double width; // 横幅のパラメータを追加

  MyAdWidget({required String adUnitId, required this.width})
      : myBanner = BannerAd(
          adUnitId: AdHelper.bannerAdUnitId,
          size: AdSize(width: width.toInt(), height: AdSize.banner.height),
          request: AdRequest(),
          listener: BannerAdListener(),
        ) {
    myBanner.load();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AdWidget(ad: myBanner),
      width: width,
      height: myBanner.size.height.toDouble(),
    );
  }
}
