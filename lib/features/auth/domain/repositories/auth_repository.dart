import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures/failures.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, Unit>> signUp(User user);
  Future<Either<Failure, User>> signIn(User user);
}
