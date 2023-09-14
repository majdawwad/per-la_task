import 'package:shared_preferences/shared_preferences.dart';

class LanguageCacheHelper {
  Future<void> cacheLanguageCode(String languageCode) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("LOCALE", languageCode);
  }

  Future<String> getCachedLanguageCode() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String cachedLanguageCode = sharedPreferences.getString("LOCALE") ?? "en";
    return cachedLanguageCode;
  }
}
