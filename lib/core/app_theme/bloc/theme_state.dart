part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

final class ThemeInitial extends ThemeState {
   final bool switchVal;
  final ThemeData themeData;
  const ThemeInitial({
    required this.switchVal,
    required this.themeData,
  });

  @override
  List<Object> get props => [themeData, switchVal];
}

class LoadedThemeState extends ThemeState {
  final bool switchVal;
  final ThemeData themeData;
  const LoadedThemeState({
    required this.switchVal,
    required this.themeData,
  });

  @override
  List<Object> get props => [themeData, switchVal];
}
