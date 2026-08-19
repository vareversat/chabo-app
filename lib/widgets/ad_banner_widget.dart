import 'dart:developer' as developer;

import 'package:chabo_app/custom_properties.dart';
import 'package:chabo_app/helpers/ad_helper.dart';
import 'package:chabo_app/helpers/device_helper.dart';
import 'package:material_ui/material_ui.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdBannerWidget extends StatefulWidget {
  const AdBannerWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AdBannerWidgetState();
  }
}

class _AdBannerWidgetState extends State<AdBannerWidget> {
  BannerAd? _ad;
  bool _isAdLoaded = false;

  void _loadAd(AdSize size) async {
    _ad = _buildAdBanner(size);
    await _ad?.load();
    setState(() {
      _isAdLoaded = true;
    });
  }

  BannerAd _buildAdBanner(AdSize size) {
    return BannerAd(
      adUnitId: AdHelper.nativeAdUnitId(),
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          developer.log(
            'Unable to load the ad: ${error.message}',
            level: 50,
            name: 'banner-widget.onAdFailedToLoad',
          );
          _ad?.dispose();
          setState(() {
            _isAdLoaded = false;
          });
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadAd(AdSize.banner); // Default size, will be updated in FutureBuilder
  }

  @override
  void dispose() {
    _ad?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AnchoredAdaptiveBannerAdSize?>(
      future: AdSize.getLargeAnchoredAdaptiveBannerAdSize(
        MediaQuery.sizeOf(context).width.truncate(),
      ),
      builder:
          (
            BuildContext context,
            AsyncSnapshot<AnchoredAdaptiveBannerAdSize?> snapshot,
          ) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.connectionState == ConnectionState.none ||
                snapshot.data == null) {
              return const Text('Error loading ad size');
            }

            final size = snapshot.data!;
            if (!_isAdLoaded) {
              _loadAd(size);
              return const Center(child: CircularProgressIndicator());
            }

            final screenWidth = MediaQuery.of(context).size.width;

            return _ad != null
                ? Card(
                    key: widget.key,
                    child: Container(
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
                          child: Text('data'),
                          //child: AdWidget(ad: _ad!),
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink();
          },
    );
  }
}
