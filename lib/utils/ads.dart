import 'package:flutter/material.dart';
import 'package:guide_app/utils/ads_networks/ironsource.dart';
import 'package:guide_app/utils/ads_networks/mopub.dart';
import 'package:guide_app/utils/ads_networks/unity.dart';

class Ads {
  static String adNetwork = "mopub";

  MopubHelper mopub = MopubHelper();
  IronSourceHelper ironSourceHelper = IronSourceHelper();

  Future<bool> get interAvailable async {
    if (adNetwork == "ironSource") {
      return IronSourceHelper.isInterLoaded;
    } else {
      return await mopub.interstitialAd.isReady();
    }
  }

  Future<bool> get rewardVideoAvailable async {
    if (adNetwork == "ironSource") {
      return IronSourceHelper.isRewardVideoAvailable;
    } else {
      return await mopub.rewardAd.isReady();
    }
  }

  Future<bool> get offerWallAvailable async {
    if (adNetwork == "ironSource") {
      return IronSourceHelper.isOfferwallAvailable;
    } else {
      return false;
    }
  }

  Widget bannerAd = Container(
        width: 320.0,
        height: 50.0,
        decoration: BoxDecoration(
          color: Colors.grey,
          border: Border.all(
            color: Colors.black87,
          ),
        ),
        child: Center(
          child: Text(
            "Banner Ad",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
      ),
      nativeAd = Container(
        width: 320.0,
        height: 100.0,
        decoration: BoxDecoration(
          color: Colors.grey,
          border: Border.all(
            color: Colors.black87,
          ),
        ),
        child: Center(
          child: Text(
            "Banner Ad",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
      );

  // Ads() {}

  static init() async {
    if (adNetwork == "ironSource") {
      await IronSourceHelper.init();
    } else if(adNetwork == "mopub")  {
      await MopubHelper.init();
      await UnityAdsHelper.init();
    }
  }

  Future<void> loadInter() async {
    if (adNetwork == "ironSource") {
      await ironSourceHelper.loadInterstitialAd();
    } else if(adNetwork == "mopub") {
      await mopub.loadInterstitialAd();
    }
  }

  Future<void> showInter(BuildContext context) async {
    if (adNetwork == "ironSource") {
      await ironSourceHelper.showInter(context);
    } else if(adNetwork == "mopub") {
      await mopub.showInter();
    }
  }

  Widget getBannerAd() {
    if (bannerAd != null) {
      if (adNetwork == "ironSource") {
        bannerAd = ironSourceHelper.getBannerAd();
      } else if(adNetwork == "mopub"){
        bannerAd = mopub.getBannerAd();
      }
    }
    return bannerAd;
  }

  Future<void> hideBannerAd() async {
    ironSourceHelper.hideBannerAd();
  }

  Widget getNativeAd() {
    return nativeAd;
  }

  Future<void> loadReward() async {
    if (adNetwork == "ironSource") {
      await ironSourceHelper.loadReward();
    } else if(adNetwork == "mopub") {
      await mopub.loadRewardedAd();
    }
  }

  Future<void> showRewardAd() async {
    if (adNetwork == "ironSource") {
      await ironSourceHelper.showRewardAd();
    } else if(adNetwork == "mopub") {
      await mopub.showRewardedAd();
    }
  }

  void loadOfferWall() async {
    if (adNetwork == "ironSource") {
      await ironSourceHelper.loadOfferwall();
    } else {}
  }

  void showOfferWall() async {
    if (adNetwork == "ironSource") {
      await ironSourceHelper.showOfferwall();
    } else {}
  }
}
