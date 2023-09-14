import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase(
    this.repository,
  );

  Future<Either<Failure, User>> call(User user) async{
     return await repository.signIn(user);
  }
}
