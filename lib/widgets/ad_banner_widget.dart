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
  late NativeAd _bannerAd;
  late BannerAd _bannerAd2;
  Ad? _ad;

  void _createBannerAd() {
    _bannerAd = NativeAd(
      adUnitId: AdHelper.nativeAdUnitId(),
      factoryId: 'listTile',
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          setState(
            () {
              _ad = ad;
            },
          );
        },
        onAdFailedToLoad: (ad, error) {
          developer.log(
            'Enable to load the ad : ${error.message}',
            name: 'banner-widget',
          );
          _ad?.dispose();
        },
      ),
    );
    _bannerAd.load();
  }

  void _createBannerAd2() {
    _bannerAd2 = BannerAd(
      adUnitId: AdHelper.inlineBannerAdUnitId(),
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
          developer.log(
            'Enable to load the ad : ${error.message}',
            name: 'banner-widget',
          );
          _ad?.dispose();
        },
      ),
    );
    _bannerAd2.load();
  }

  @override
  void initState() {
    _createBannerAd2();
    super.initState();
  }

  @override
  void dispose() {
    _ad?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity:
          CurvedAnimation(parent: animation, curve: Curves.easeIn),
          child: SlideTransition(
            position: Tween(
              begin: const Offset(-1.0, 0.0),
              end: const Offset(0.0, 0.0),
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: _ad != null
          ? Card(
        child: Container(
          key: const ValueKey('adContent'),
          height: 55,
          alignment: Alignment.center,
          child: AnimatedSize(
            curve: Curves.ease,
            duration: const Duration(seconds: 1),
            child: AnimatedSwitcher(
              duration: const Duration(seconds: 1),
              reverseDuration: const Duration(milliseconds: 500),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: AdWidget(ad: _bannerAd2),
            ),
          ),
        ),
      )
          : const SizedBox.shrink(),
    );
  }
}
