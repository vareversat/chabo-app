import 'dart:developer' as developer;

import 'package:chabo/helpers/ad_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdBannerWidget extends StatefulWidget {
  const AdBannerWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AdBannerWidgetState();
  }
}

class _AdBannerWidgetState extends State<AdBannerWidget> {
  late BannerAd _bannerAd;
  Ad? _ad;

  void _createBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId(),
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(
            () {
              _ad = ad;
            },
          );
        },
        onAdFailedToLoad: (ad, error) {
          developer.log('Enable to load the ad : ${error.message}',
              name: 'banner-widget');
          _ad?.dispose();
        },
      ),
    );
    _bannerAd.load();
  }

  @override
  void didChangeDependencies() {
    _createBannerAd();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _ad?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const ValueKey('adContent'),
      width: _bannerAd.size.width.toDouble(),
      height: _bannerAd.size.height.toDouble(),
      alignment: Alignment.center,
      child: _ad != null ? AdWidget(ad: _bannerAd) : Container(),
    );
  }
}