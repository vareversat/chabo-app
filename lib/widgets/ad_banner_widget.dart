import 'dart:developer' as developer;

import 'package:chabo_app/custom_properties.dart';
import 'package:chabo_app/helpers/ad_helper.dart';
import 'package:chabo_app/helpers/device_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdBannerWidget extends StatefulWidget {
  const AdBannerWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AdBannerWidgetState();
  }
}

class _AdBannerWidgetState extends State<AdBannerWidget> {
  late NativeAd _bannerAd;
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
            level: 50,
            name: 'banner-widget.on.adLoaded',
          );
          _ad?.dispose();
        },
      ),
    );
    _bannerAd.load();
  }

  @override
  void initState() {
    _createBannerAd();
    super.initState();
  }

  @override
  void dispose() {
    _ad?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return _ad != null
        ? Card(
            child: Container(
              key: const ValueKey('adContent'),
              constraints: BoxConstraints(
                maxHeight: 55,
                maxWidth: DeviceHelper.isPortrait(context)
                    ? screenWidth
                    //ignore: avoid-nested-conditional-expressions
                    : !DeviceHelper.isMobile(context)
                        ? screenWidth / 1.55
                        : screenWidth / 2.13,
              ),
              alignment: Alignment.center,
              child: AnimatedSize(
                curve: Curves.ease,
                duration: const Duration(seconds: 1),
                child: AnimatedSwitcher(
                  duration: const Duration(seconds: 1),
                  reverseDuration: const Duration(
                    milliseconds: CustomProperties.animationDurationMs,
                  ),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  child: AdWidget(ad: _bannerAd),
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
