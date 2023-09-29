import 'package:flutter_tuto/core/usecase/usecase.dart';
import 'package:flutter_tuto/core/utils/typedef.dart';
import 'package:flutter_tuto/src/authentication/domain/entities/user.dart';
import 'package:flutter_tuto/src/authentication/domain/repositories/authentication_repository.dart';

class GetUsers extends UsecaseWithoutParams<List<User>>{
  final AuthenticationRepository _repository;

  const GetUsers(this._repository);

  @override
  ResultFuture<List<User>> call() => _repository.getUsers();
}