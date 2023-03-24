import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({super.key});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  BannerAd? _bannerAd;

  Future<void> init() async {
    await MobileAds.instance.initialize();
  }

  Future<void> initalizeBannerAd() async {
    await BannerAd(
            size: AdSize.banner,
            adUnitId: "ca-app-pub-3197842556924641/8820368180",
            listener: BannerAdListener(onAdLoaded: (ad) {
              print("successfully loaded ad");
              setState(() {
                _bannerAd = ad as BannerAd?;
              });
            }, onAdFailedToLoad: ((ad, error) {
              print("could not load ad $error");
              setState(() {
                _bannerAd = null;
              });
            })),
            request: const AdRequest())
        .load();
  }

  @override
  void initState() {
    super.initState();
    init();
    initalizeBannerAd();
  }

  @override
  void dispose() {
    print("disposing");
    if (_bannerAd != null) {
      print("banner ad is null");
      _bannerAd!.dispose();
    }
    _bannerAd = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_bannerAd == null) {
      return Container();
    } else {
      return SizedBox(
        width: _bannerAd!.size.width.toDouble(),
        height: _bannerAd!.size.height.toDouble(),
        child: AdWidget(
          ad: _bannerAd!,
        ),
      );
    }
  }
}
