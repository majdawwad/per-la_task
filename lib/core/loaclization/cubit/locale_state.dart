// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'locale_cubit.dart';

@immutable
abstract class LocaleState {}

final class LocaleInitial extends LocaleState {}

class ChangeLocaleLanguageState extends LocaleState {
  final Locale locale;
  ChangeLocaleLanguageState({
    required this.locale,
  });
}
