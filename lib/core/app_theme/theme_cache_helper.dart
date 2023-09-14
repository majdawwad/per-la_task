import 'package:shared_preferences/shared_preferences.dart';

class ThemeCacheHelper {
  Future<void> cacheThemeIndex(int itemIndex) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setInt("THEME_INDEX", itemIndex);
  }

  Future<int> getCachedThemeIndex() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final int? cachedItemIndex = sharedPreferences.getInt("THEME_INDEX");

    if (cachedItemIndex != null) {
      return cachedItemIndex;
    } else {
      return 0;
    }
  }
}
