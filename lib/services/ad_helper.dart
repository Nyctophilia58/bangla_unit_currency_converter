import "dart:io";

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'Your_test_unit_id_here';
    }
    else {
      throw UnsupportedError('Unsupposted Platform');
    }
  }
}