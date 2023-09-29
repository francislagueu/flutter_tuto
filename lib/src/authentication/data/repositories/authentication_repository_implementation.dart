import 'package:dartz/dartz.dart';
import 'package:flutter_tuto/core/errors/exceptions.dart';
import 'package:flutter_tuto/core/errors/failure.dart';
import 'package:flutter_tuto/core/utils/typedef.dart';
import 'package:flutter_tuto/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:flutter_tuto/src/authentication/domain/entities/user.dart';
import 'package:flutter_tuto/src/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImplementation
    implements AuthenticationRepository {

  const AuthenticationRepositoryImplementation(this._remoteDataSource);

  final AuthenticationRemoteDataSource _remoteDataSource;

  @override
  ResultVoid createUser(
      {required String createdAt,
      required String name,
      required String avatar}) async{

    try{
      await _remoteDataSource.createUser(createdAt: createdAt, name: name, avatar: avatar);
      return const Right(null);
    } on ApiException catch(e){
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    try {
      final result  = await _remoteDataSource.getUsers();
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
