part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class GetCurrentThemeEvent extends ThemeEvent {}

class ThemeChangedEvent extends ThemeEvent {
  final bool switchVal;
  final AppTheme theme;
  const ThemeChangedEvent({
   required this.switchVal,
    required this.theme,
  });

  @override
  List<Object> get props => [theme, switchVal];
}
