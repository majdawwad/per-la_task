// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {
  final bool obscureText;

  const AuthInitial({required this.obscureText});
  @override
  List<Object> get props => [obscureText];
}

class AuthIsLoadingState extends AuthState {}

class AuthIsLoadedState extends AuthState {
  final String message;

  const AuthIsLoadedState({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class AuthIsErrorState extends AuthState {
  final String message;

  const AuthIsErrorState({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class AuthObsecureTextState extends AuthState {
  final bool obscureText;

  const AuthObsecureTextState({
    required this.obscureText,
  });

  @override
  List<Object> get props => [obscureText];
}
