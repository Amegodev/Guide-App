import 'package:flutter/material.dart';
import 'package:flutter_ironsource_x/ironsource.dart';
import 'package:flutter_ironsource_x/models.dart';
import 'package:mopub_flutter/mopub_interstitial.dart';
import 'package:guide_app/utils/tools.dart';
import 'package:mopub_flutter/mopub_rewarded.dart';

class IronSourceHelper with WidgetsBindingObserver {
  static String IRONSOURCE_APP_KEY = "fd1bce71";

  static bool isRewardVideoAvailable = false,
      isOfferwallAvailable = false,
      showBanner = false,
      isInterLoaded = false;


  IronSourceBannerAd bannerAd;
   Widget nativeAd;

  MoPubRewardedVideoAd videoAd;

  MoPubInterstitialAd interstitialAd;

  static Future<void> init() async {
    
    // var userId = await IronSource.getAdvertiserId();
    // await IronSource.validateIntegration();

    // Tools.logger.wtf(userId);

    // await IronSource.setUserId(userId);

    await IronSource.initialize(
        appKey: IRONSOURCE_APP_KEY,
        listener: IrSourceAdListener(
            interstitialReady: isInterLoaded,
            rewardeVideoAvailable: isRewardVideoAvailable,
            offerwallAvailable: isOfferwallAvailable),
        gdprConsent: true,
        ccpaConsent: false);
    isRewardVideoAvailable = await IronSource.isRewardedVideoAvailable();
    isOfferwallAvailable = await IronSource.isOfferwallAvailable();
  }

  void loadRewardedAd() {
  }

  Future<void> loadInterstitialAd() async {
    await IronSource.loadInterstitial();
  }

  Future<void> showInter(BuildContext context) async {
    if (await IronSource.isInterstitialReady()) {
      await IronSource.showInterstitial();
    } else {
      Tools.logger.i("IronSource Inter not loaded yet");
    }
  }

  Widget getBannerAd() {
    // if (bannerAd == null) {
      bannerAd = IronSourceBannerAd(
        listener: new BannerAdListener(this),
      );
    //   return bannerAd;
    // }

    return bannerAd;

    /* return Container(
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
    ); */
  }

  Future<void> hideBannerAd() async {
    bannerAd = null;
  }

  Future<void> loadReward() async {}

  Future<void> showRewardAd() async {
    if (await IronSource.isRewardedVideoAvailable()) {
      await IronSource.showRewardedVideo();
    } else {
      Tools.logger.i("RewardedVideo not available");
    }
  }

  Future<void> loadOfferwall() async {}

  Future<void> showOfferwall() async {
    if (await IronSource.isOfferwallAvailable()) {
      IronSource.showOfferwall();
    } else {
      print("Offerwall not available");
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    Tools.logger.wtf("AppLifecycleState: $state");
    switch (state) {
      case AppLifecycleState.resumed:
        IronSource.activityResumed();
        break;
      case AppLifecycleState.paused:
        IronSource.activityPaused();
        break;
      default:
        break;
    }
  }
}

class IrSourceAdListener extends IronSourceListener {
  final bool interstitialReady, rewardeVideoAvailable, offerwallAvailable;

  IrSourceAdListener(
      {this.interstitialReady,
      this.rewardeVideoAvailable,
      this.offerwallAvailable});

  @override
  void onInterstitialAdClicked() {
    Tools.logger.i("onInterstitialAdClicked");
  }

  @override
  void onGetOfferwallCreditsFailed(IronSourceError error) {
    // implement onGetOfferwallCreditsFailed
    Tools.logger.i("onGetOfferwallCreditsFailed: ${error.errorMessage}");
  }

  @override
  void onInterstitialAdClosed() {
    // implement onInterstitialAdClosed
    IronSource.loadInterstitial();
  }

  @override
  void onInterstitialAdLoadFailed(IronSourceError error) {
    // implement onInterstitialAdLoadFailed
    Tools.logger.i("onInterstitialAdLoadFailed: ${error.errorMessage}");
  }

  @override
  void onInterstitialAdOpened() {
    // implement onInterstitialAdOpened
  }

  @override
  void onInterstitialAdReady() {
    // implement onInterstitialAdReady
    Tools.logger.i("onInterstitialAdReady");
  }

  @override
  void onInterstitialAdShowFailed(IronSourceError error) {
    // implement onInterstitialAdShowFailed
  }

  @override
  void onInterstitialAdShowSucceeded() {
    // implement onInterstitialAdShowSucceeded
  }

  @override
  void onOfferwallAdCredited(OfferwallCredit reward) {
    // implement onOfferwallAdCredited
  }

  @override
  void onOfferwallAvailable(bool available) {
    // implement onOfferwallAvailable
    Tools.logger.i("onOfferwallAvailable");
  }

  @override
  void onOfferwallClosed() {
    // implement onOfferwallClosed
    Tools.logger.i("onOfferwallClosed");
  }

  @override
  void onOfferwallOpened() {
    // implement onOfferwallOpened
    Tools.logger.i("onOfferwallOpened");
  }

  @override
  void onOfferwallShowFailed(IronSourceError error) {
    // implement onOfferwallShowFailed
    Tools.logger.i("onOfferwallShowFailed: ${error.errorMessage}");
  }

  @override
  void onRewardedVideoAdClicked(Placement placement) {
    // implement onRewardedVideoAdClicked
    Tools.logger.i("onRewardedVideoAdClicked: placement($placement)");
  }

  @override
  void onRewardedVideoAdClosed() {
    // implement onRewardedVideoAdClosed
    Tools.logger.i("onRewardedVideoAdClosed");
  }

  @override
  void onRewardedVideoAdEnded() {
    // implement onRewardedVideoAdEnded
    Tools.logger.i("onRewardedVideoAdEnded");
  }

  @override
  void onRewardedVideoAdOpened() {
    // implement onRewardedVideoAdOpened
  }

  @override
  void onRewardedVideoAdRewarded(Placement placement) {
    // implement onRewardedVideoAdRewarded
    Tools.logger.i("onRewardedVideoAdRewarded: placement($placement)");
  }

  @override
  void onRewardedVideoAdShowFailed(IronSourceError error) {
    // implement onRewardedVideoAdShowFailed
    Tools.logger.i("onRewardedVideoAdShowFailed: ${error.errorMessage}");
  }

  @override
  void onRewardedVideoAdStarted() {
    // implement onRewardedVideoAdStarted
  }

  @override
  void onRewardedVideoAvailabilityChanged(bool available) {
    // implement onRewardedVideoAvailabilityChanged
  }
}

class BannerAdListener extends IronSourceBannerListener {
  final IronSourceHelper ironsourceads;

  BannerAdListener(this.ironsourceads);

  @override
  void onBannerAdClicked() {
    Tools.logger.wtf("onBannerAdClicked");
  }

  @override
  void onBannerAdLeftApplication() {
    Tools.logger.wtf("onBannerAdLeftApplication");
  }

  @override
  void onBannerAdLoadFailed(Map<String, dynamic> error) {
    Tools.logger.wtf("onBannerAdLoadFailed");
    ironsourceads.bannerAd = ironsourceads.getBannerAd();
  }

  @override
  void onBannerAdLoaded() {
    Tools.logger.wtf("onBannerAdLoaded");
  }

  @override
  void onBannerAdScreenDismissed() {
    Tools.logger.wtf("onBannerAdScreenDismisse");
  }

  @override
  void onBannerAdScreenPresented() {
    Tools.logger.wtf("onBannerAdScreenPresented");
  }
}
