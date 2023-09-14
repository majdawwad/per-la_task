import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app_theme.dart';
import '../theme_cache_helper.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial(themeData: appThemeData.values.first, switchVal: false)) {
    on<ThemeEvent>((event, emit) async {
      if (event is GetCurrentThemeEvent) {
        final themeIndex = await ThemeCacheHelper().getCachedThemeIndex();
        final theme = AppTheme.values
            .firstWhere((appTheme) => appTheme.index == themeIndex);
            
        emit(LoadedThemeState(themeData: appThemeData[theme]!, switchVal: false));
      } else if (event is ThemeChangedEvent) {
        final int themeIndex = event.theme.index;
        await ThemeCacheHelper().cacheThemeIndex(themeIndex);
        final bool val = event.switchVal ? false : true;
        emit(LoadedThemeState(themeData: appThemeData[event.theme]!, switchVal: val));
      }
    });
  }
}
