import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/type_def.dart';
import '../../../../../core/errors/failures/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../../../core/strings/messages.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usecases/sign_in.dart';
import '../../../domain/usecases/sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUseCase signUpUseCase;
  final SignInUseCase signInUseCase;

  AuthBloc({required this.signUpUseCase, required this.signInUseCase})
      : super(const AuthInitial(obscureText: true)) {
    on<AuthEvent>((event, emit) async {
      String mapFailureToMessageInfo(Failure failure) {
        switch (failure.runtimeType) {
          case ServerFailure:
            return serverFailureMessage;
          case OfflineFailure:
            return offlineFailureMessage;
          case ExistDataFailure:
            return existDataFailureMessage;
          case CredentionalsFailure:
            return credentionalsFailureMessage;

          default:
            return "An Unexpected Wrong, Please try again later!.";
        }
      }

      AuthState mapFailureOrSignUpUserToState(
          FailureOrSignUpAuth either, String message) {
        return either.fold(
          (failure) {
            return AuthIsErrorState(
              message: mapFailureToMessageInfo(failure),
            );
          },
          (_) {
            return AuthIsLoadedState(message: message);
          },
        );
      }

      AuthState mapFailureOrSignInUserToState(
          FailureOrSignInAuth either, String message) {
        return either.fold(
          (failure) {
            return AuthIsErrorState(
              message: mapFailureToMessageInfo(failure),
            );
          },
          (_) {
            return AuthIsLoadedState(message: message);
          },
        );
      }

      if (event is AuthSignUpEvent) {
        emit(AuthIsLoadingState());

        final signUpOrFailureUser = await signUpUseCase(event.userData);

        emit(
          mapFailureOrSignUpUserToState(
            signUpOrFailureUser,
            signUpSuccess,
          ),
        );
      } else if (event is AuthSignInEvent) {
        emit(AuthIsLoadingState());

        final signInOrFailureUser = await signInUseCase(event.userData);

        emit(
          mapFailureOrSignInUserToState(
            signInOrFailureUser,
            signUpSuccess,
          ),
        );
      } else if (event is AuthToggleObscureTextEvent) {
        final currentObscureText = event.obscureText ? false : true;
        emit(AuthObsecureTextState(obscureText: currentObscureText));
      }
    });
  }
}
