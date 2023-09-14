import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions/exceptions.dart';
import '../../../../core/errors/failures/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/remote_data_source.dart';
import '../models/user_model.dart';

class AuthRepositoryImplement implements AuthRepository {
  final RemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImplement({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Unit>> signUp(User user) async {
    final UserModel userDataModel = UserModel(
      fullname: user.fullname,
      phone: user.phone,
      password: user.password,
    );
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.signUp(userDataModel);
        return const Right(unit);
      } on ExistDataException {
        return Left(ExistDataFailure());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, User>> signIn(User user) async {
    final UserModel userDataModel = UserModel(
      fullname: user.fullname,
      phone: user.phone,
      password: user.password,
    );
    if (await networkInfo.isConnected) {
      try {
        final UserModel userData = await remoteDataSource.signIn(userDataModel);
        return Right(userData);
      } on CredentionalsException {
        return Left(CredentionalsFailure());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
