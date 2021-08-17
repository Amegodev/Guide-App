import 'package:flutter/material.dart';
import 'package:mopub_flutter/mopub_interstitial.dart';
import 'package:guide_app/utils/tools.dart';
import 'package:mopub_flutter/mopub.dart';
import 'package:mopub_flutter/mopub_banner.dart';
import 'package:mopub_flutter/mopub_rewarded.dart';

class MopubHelper {
  //TODO: ⚠ Change the testMode to false
  static final bool testMode = false;

  static String bannerAdUnit = "c346fe32743441f38bad45d32e75a381";
  static String interAdUnit = "20b25863f55a488bb24b47c1289ac7a7";
  static String rewardAdUnit = "5f344e8a7d674aa6b23871a31709be24";

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
        Tools.logger.i('Mopub Interstitial $result\nargs: $args');
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
