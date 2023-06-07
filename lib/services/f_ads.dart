import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitalAdCubit extends Cubit<InterstitialAd?> {
  Future<void> init() async {
    await MobileAds.instance.initialize();
  }

  InterstitalAdCubit() : super(null) {
    init();
  }

  Future<void> loadInterstitialAd() async {
    InterstitialAd.load(
        adUnitId: 'ca-app-pub-3197842556924641/3568041502',
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: ((ad) {
          emit(ad);
          ad.fullScreenContentCallback =
              FullScreenContentCallback(onAdDismissedFullScreenContent: ((ad) {
            ad.dispose();
            emit(null);
          }));
        }), onAdFailedToLoad: ((adErr) {
          print("failed to load interstitial ad $adErr");
          emit(null);
        })));
  }
}

class GoogleAdDisplay{
  BannerAd? _bannerAd;

  Future<void> init() async {
    await MobileAds.instance.initialize();
  }

  GoogleAdDisplay(){
    init();
  }

  Future<void> initializeBannerAd() async {
    _bannerAd = BannerAd(
            size: AdSize.banner,
            adUnitId: 'ca-app-pub-3940256099942544/6300978111',    // "ca-app-pub-3197842556924641/8820368180",
            listener: BannerAdListener(onAdLoaded: (ad) {
              // _bannerAd = ad as BannerAd?;

            }, onAdFailedToLoad: ((ad, error) {
              _bannerAd = null;
              // emit(null);
            })),
            request: const AdRequest())
        ..load();
  }

  BannerAd? get fetchBannerAd {
    return _bannerAd;
  }

  void disposeAd() {
    if (_bannerAd != null) {
      _bannerAd!.dispose();
    }
    _bannerAd = null;
  }

}
