import 'package:guide_app/utils/tools.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:unity_ads_plugin/ad/unity_banner_ad.dart';
import 'package:unity_ads_plugin/unity_ads.dart';

class UnityAdsHelper {
  //UnityAds
  static final String gameId = "4236883";
  static final String bannerPlacementId = "Banner_Android";
  static final String interPlacementId = "Interstitial_Android";
  static final String testDevice = "a13ceeef-698a-4927-9df0-2356396e95fa";

  Widget unityBannerAd;

  static bool testMode = true;

  static bool isInDebugMode() {
    return false;
    /*if (kDebugMode) {
      return true;
    } else {
      return false;
    }*/
  }

  static bool isVersionUpToLOLLIPOP() {
    bool isVersionUp = true;
    if (Tools.androidInfo.version.sdkInt <= 23) isVersionUp = false;
    return isVersionUp;
  }

  static Future<void> init() async {
    if (!isInDebugMode()) {
      if (isVersionUpToLOLLIPOP()) {
        UnityAds.init(
          gameId: gameId,
          testMode: testMode,
          listener: (state, dynamic) {
            Tools.logger.wtf('state: $state\ndynamic: $dynamic');
          },
        );
      }
    } else {
      Tools.logger.i(
          '====================> UnityAds was not initialized on the debug Mode');
    }
  }

  Future<void> showInter() async {
    if (!isInDebugMode()) {
      if (isVersionUpToLOLLIPOP()) {
        await showUnityVideoAd();
      }
    }
  }

  Future<void> showUnityVideoAd() async {
    await UnityAds.showVideoAd(
      placementId: interPlacementId,
      listener: (state, args) {
        if (state == UnityAdState.started) {
          Tools.logger.i('===(UnityAds)===> User started watching the video!');
        }
        if (state == UnityAdState.error) {
          Tools.logger
              .i('===(UnityAds)===> UnityAdState.error\nerror : $state');
        }
      },
    );
  }

  Widget getBannerAd({VoidCallback rebuild}) {
    if (isVersionUpToLOLLIPOP()) {
      unityBannerAd = UnityBannerAd(
        placementId: bannerPlacementId,
        listener: (state, args) {
          Tools.logger.i("Unity Banner : $state => $args");
          if (state == BannerAdState.error) {
            // isUnityBannerAdLoaded = false;
            Tools.logger.wtf("Failed");
            if (rebuild != null) {
              rebuild();
            }
          }
          if (state == BannerAdState.loaded) {
            // isUnityBannerAdLoaded = true;
            Tools.logger.wtf("Loaded");
            if (rebuild != null) {
              rebuild();
            }
          }
        },
      );
      return unityBannerAd;
    }
    return SizedBox();
  }
}
