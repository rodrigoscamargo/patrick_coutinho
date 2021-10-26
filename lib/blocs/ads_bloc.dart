import 'package:flutter/foundation.dart';

class AdsBloc extends ChangeNotifier {
  int _clickCounter = 0;
  int get clickCounter => _clickCounter;

  bool _bannerAd = false;
  bool get bannerAd => _bannerAd;

  bool _interstitialAd = false;
  bool get interstitialAd => _interstitialAd;

  Future checkAdsEnable() async {}
}
