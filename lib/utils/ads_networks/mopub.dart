import 'package:flutter/material.dart';
import 'package:mopub_flutter/mopub_interstitial.dart';
import 'package:prank_app/utils/tools.dart';
import 'package:mopub_flutter/mopub.dart';
import 'package:mopub_flutter/mopub_banner.dart';
import 'package:mopub_flutter/mopub_rewarded.dart';

class MopubHelper {
  //TODO: ⚠ Change the testMode to false
  static final bool testMode = false;

  static String bannerAdUnit = "0cd269d3e7cc43f99078c9d19a628ff1";
  static String interAdUnit = "eacc313413af45d2a80c9fac2bc261c2";
  static String rewardAdUnit = "dae0325ba5ec4df288c8832f0253a943";

  MoPubRewardedVideoAd rewardAd;
  MoPubInterstitialAd interstitialAd;

  Widget bannerAd;

  static Future<void> init() async {
    await MoPub.init(bannerAdUnit, testMode: testMode);
  }

  Widget getBannerAd() {
    return MoPubBannerAd(
      adUnitId: bannerAdUnit,
      bannerSize: BannerSize.STANDARD,
      keepAlive: false,
      listener: (result, dynamic) {
        Tools.logger.i('result: $result \ndynamic: $dynamic');
      },
    );
  }

  Future<void> loadInterstitialAd() async {
    interstitialAd = MoPubInterstitialAd(
      interAdUnit,
      (result, args) {
        Tools.logger.i('Mopub Interstitial $result');
      },
      reloadOnClosed: true,
    );
    await interstitialAd.load();
  }

  Future<void> showInter() async {
    if (await interstitialAd.isReady()) {
      await interstitialAd.show();
    } else {
      Tools.logger.i("Mopub Inter not ready yet!");
    }
  }

  Future<void> loadRewardedAd() async {
    rewardAd = MoPubRewardedVideoAd(
      rewardAdUnit,
      (result, args) {
        /*setState(() {
            rewardedResult = '${result.toString()}____$args';
          });*/
        Tools.logger.i('MoPubRewardedVideoAd: $result');
        if (result == RewardedVideoAdResult.GRANT_REWARD) {
          Tools.logger.i('Grant reward: $args');
        }
      },
      reloadOnClosed: true,
    );
    await rewardAd.load();
  }

  Future<void> showRewardedAd() async {
    if (await rewardAd.isReady()) {
      rewardAd.show();
    } else {
      Tools.logger.i("Mopub Reward not ready yet!");
    }
  }
}
