import 'package:flutter_tuto/core/utils/typedef.dart';
import 'package:flutter_tuto/src/authentication/domain/entities/user.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  ResultVoid createUser({
  required String createdAt,
  required String name,
  required String avatar
});

  ResultFuture<List<User>> getUsers();
}