import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdHelper {
  bool _isInitialized = false;

  BannerAd? _banner;

  void loadBanner(Function(BannerAd) onBannerAdLoaded) async {
    await _initialize();

    if (_banner != null) {
      await _banner!.load();
      onBannerAdLoaded(_banner!);
      return;
    }

    _banner = BannerAd(
        size: AdSize.banner,
        adUnitId: _getBannerAdUnitId(),
        listener: BannerAdListener(
            onAdLoaded: (ad) {
              onBannerAdLoaded(ad as BannerAd);
            }
        ),
        request: AdRequest()
    );

    await _banner!.load();
  }

  EdgeInsets getFabPadding(BuildContext context) {
    double bannerHeight = 50.0;
    return EdgeInsets.only(bottom: bannerHeight);
  }

  void dispose() {
    _banner?.dispose();
  }

  Future<void> _initialize() async {
    if (!_isInitialized) {
      await MobileAds.instance.initialize();
      _isInitialized = true;
    }
  }

  String _getBannerAdUnitId() {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111'; // android 테스트 광고 id
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716'; // iOS 테스트 광고 id
    }
    throw StateError('Unsupported platform');
  }
}