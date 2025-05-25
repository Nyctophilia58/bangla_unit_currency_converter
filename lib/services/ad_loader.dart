import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdLoader extends StatelessWidget{
  final BannerAd bannerAd;
  const AdLoader({super.key, required this.bannerAd});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: bannerAd.size.width.toDouble(),
      height: bannerAd.size.height.toDouble(),
      child: AdWidget(ad: bannerAd),
    );
  }
}