import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(
    this.repository,
  );

  Future<Either<Failure, Unit>> call(User user) async{
     return await repository.signUp(user);
  }
}