import "dart:io";

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-4367940215349922/3479795568';
    }
    else {
      throw UnsupportedError('Unsupposted Platform');
    }
  }
}