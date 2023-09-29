import 'package:flutter_tuto/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:flutter_tuto/src/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:flutter_tuto/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:flutter_tuto/src/authentication/domain/usecases/create_user.dart';
import 'package:flutter_tuto/src/authentication/domain/usecases/get_users.dart';
import 'package:flutter_tuto/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  sl
  // App Logic
    ..registerFactory(
        () => AuthenticationCubit(createUser: sl(), getUsers: sl()))
    // Use Cases
    ..registerLazySingleton(() => CreateUser(sl()))
    ..registerLazySingleton(() => GetUsers(sl()))
    // Repositories
    ..registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationRepositoryImplementation(sl()))
    //Data Sources
    ..registerLazySingleton<AuthenticationRemoteDataSource>(
        () => AuthenticationRemoteDataSourceImplementation(sl()))
    // External Dependencies
    ..registerLazySingleton(http.Client.new);
}
