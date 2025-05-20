import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsScreen extends StatefulWidget {
  const AdsScreen({super.key});

  @override
  State<AdsScreen> createState() {
    return _AdsScreenState();
  }
}

class _AdsScreenState extends State<AdsScreen> {
  late BannerAd _bannerAd;
  bool isBannerAdReady = false;

  late InterstitialAd _interstitialAd;
  bool isInterstitialAdReady = false;

  @override
  void initState() {
    super.initState();
    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: "ca-app-pub-2140111362057920/3771633124",
      listener: BannerAdListener(
        onAdLoaded: (context) {
          setState(() {
            isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (context, error) {
          isBannerAdReady = true;
          context.dispose();
        },
      ),
      request: AdRequest(),
    );
    _bannerAd.load();
    InterstitialAd.load(
      adUnitId: "ca-app-pub-2140111362057920/1165651081",
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (context) {
          setState(() {
            _interstitialAd = context;
            isInterstitialAdReady = true;
          });
        },
        onAdFailedToLoad: (error) {
          isInterstitialAdReady = false;
        },
      ),
    );
  }

  void _showInterstitialAd() {
    if (isInterstitialAdReady) {
      _interstitialAd.show();
      _interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (context) {
          context.dispose();
          setState(() {
            isInterstitialAdReady = false;
          });

          InterstitialAd.load(
            adUnitId: "ca-app-pub-2140111362057920/1165651081",
            request: AdRequest(),
            adLoadCallback: InterstitialAdLoadCallback(
              onAdLoaded: (context) {
                setState(() {
                  _interstitialAd = context;
                  isInterstitialAdReady = true;
                });
              },
              onAdFailedToLoad: (error) {
                isInterstitialAdReady = false;
              },
            ),
          );
        },
        onAdFailedToShowFullScreenContent: (context, error) {
          context.dispose();
          setState(() {
            isInterstitialAdReady = false;
          });
        },
      );
    }
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    if (isBannerAdReady) {
      _interstitialAd.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Google Adsmod")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _showInterstitialAd();
              },
              child: Text("Show Interstitial"),
            ),
          ],
        ),
      ),
      bottomNavigationBar:
          isBannerAdReady
              ? SizedBox(
                height: _bannerAd.size.height.toDouble(),
                width: _bannerAd.size.width.toDouble(),
                child: AdWidget(ad: _bannerAd),
              )
              : null,
    );
  }
}
