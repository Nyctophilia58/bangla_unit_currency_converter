class Button {
  // English Labels
  static const String delEn = "DEL";
  static const String clearEn = "CLR";
  static const String okEn = "OK";
  static const String zeroZeroEn = "00";
  static const String dotEn = ".";

  static const String oneEn = "1";
  static const String twoEn = "2";
  static const String threeEn = "3";
  static const String fourEn = "4";
  static const String fiveEn = "5";
  static const String sixEn = "6";
  static const String sevenEn = "7";
  static const String eightEn = "8";
  static const String nineEn = "9";
  static const String zeroEn = "0";

  // Bangla Labels
  static const String delBn = "DEL";
  static const String clearBn = "CLR";
  static const String okBn = "OK";
  static const String zeroZeroBn = "০০";
  static const String dotBn = ".";

  static const String oneBn = "১";
  static const String twoBn = "২";
  static const String threeBn = "৩";
  static const String fourBn = "৪";
  static const String fiveBn = "৫";
  static const String sixBn = "৬";
  static const String sevenBn = "৭";
  static const String eightBn = "৮";
  static const String nineBn = "৯";
  static const String zeroBn = "০";

  // Unified language-aware getters
  static String del(String lang) => lang == 'bn' ? delBn : delEn;
  static String clear(String lang) => lang == 'bn' ? clearBn : clearEn;
  static String ok(String lang) => lang == 'bn' ? okBn : okEn;
  static String dot(String lang) => lang == 'bn' ? dotBn : dotEn;
  static String zeroZero(String lang) => lang == 'bn' ? zeroZeroBn : zeroZeroEn;

  // button count
  static const int buttonCount = 15;

  static const Map<String, String> enToBnDigits = {
    '0': '০', '1': '১', '2': '২', '3': '৩', '4': '৪',
    '5': '৫', '6': '৬', '7': '৭', '8': '৮', '9': '৯', '.': '.'
  };

  static const Map<String, String> bnToEnDigits = {
    '০': '0', '১': '1', '২': '2', '৩': '3', '৪': '4',
    '৫': '5', '৬': '6', '৭': '7', '৮': '8', '৯': '9', '.': '.'
  };

  String convertDigits(String text, bool toBangla) {
    final map = toBangla ? enToBnDigits : bnToEnDigits;
    return text.split('').map((ch) => map[ch] ?? ch).join();
  }

  // English Button Layout
  static const List<String> buttonValuesEnglish = [
    sevenEn, eightEn, nineEn, clearEn,
    fourEn, fiveEn, sixEn, delEn,
    oneEn, twoEn, threeEn, dotEn,
    zeroZeroEn, zeroEn, okEn,
  ];

  // Bangla Button Layout
  static const List<String> buttonValuesBangla = [
    sevenBn, eightBn, nineBn, clearBn,
    fourBn, fiveBn, sixBn, delBn,
    oneBn, twoBn, threeBn, dotBn,
    zeroZeroBn, zeroBn, okBn,
  ];

  static List<String> getButtonValues(String languageCode) {
    return languageCode == 'bn'
        ? buttonValuesBangla
        : buttonValuesEnglish;
  }
}
