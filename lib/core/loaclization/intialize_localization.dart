import 'package:flutter_localization/flutter_localization.dart';

class IntializeLocalization {
  static Future<void> initial() async {
    return await FlutterLocalization.instance.init(
      mapLocales: [
        const MapLocale(
          'en',
          {},
        ),
        const MapLocale(
          'ar',
          {},
        ),
      ],
      initLanguageCode: 'en',
    );
  }
}
