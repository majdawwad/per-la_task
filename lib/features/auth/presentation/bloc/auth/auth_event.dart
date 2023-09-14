// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthSignUpEvent extends AuthEvent {
  final User userData;
  const AuthSignUpEvent({required this.userData});

  @override
  List<Object> get props => [userData];
}

class AuthSignInEvent extends AuthEvent {
  final User userData;
  const AuthSignInEvent({required this.userData});

  @override
  List<Object> get props => [userData];
}

class AuthToggleObscureTextEvent extends AuthEvent {
  final bool obscureText;

  const AuthToggleObscureTextEvent({
    required this.obscureText,
  });

  @override
  List<Object> get props => [obscureText];
}
