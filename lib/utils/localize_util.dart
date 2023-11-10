import 'package:localization/localization.dart';

class LocalUtil {
  static String get(String key, {String fallbackValue = ''}) {
    try {
      return key.i18n();
    } catch (e) {
      print(e);
    }
    return fallbackValue;
  }
}
