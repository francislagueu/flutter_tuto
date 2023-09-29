import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tuto/core/errors/exceptions.dart';
import 'package:flutter_tuto/core/errors/failure.dart';
import 'package:flutter_tuto/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:flutter_tuto/src/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:flutter_tuto/src/authentication/domain/entities/user.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationRemoteDataSource extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  late AuthenticationRemoteDataSource remoteDataSource;
  late AuthenticationRepositoryImplementation repositoryImplementation;

  setUp(() {
    remoteDataSource = MockAuthenticationRemoteDataSource();
    repositoryImplementation =
        AuthenticationRepositoryImplementation(remoteDataSource);
  });

  const tException =
      ApiException(message: 'Unknown Error Occurred', statusCode: 500);

  group('createUser', () {
    const createdAt = 'whatever.createdAt';
    const name = 'whatever.name';
    const avatar = 'whatever.avatar';
    test(
        'should call the [RemoteDataSource.createUser] and complete successfully when the call to the remote source is successful',
        () async {
      when(() => remoteDataSource.createUser(
              createdAt: any(named: 'createdAt'),
              name: any(named: 'name'),
              avatar: any(named: 'avatar')))
          .thenAnswer((_) async => Future.value());

      final result = await repositoryImplementation.createUser(
          createdAt: createdAt, name: name, avatar: avatar);
      expect(result, equals(const Right(null)));
      verify(() => remoteDataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar)).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
    test(
        'should return a [ServerFailure] when the call to the remote source is unsuccessful',
        () async {
      when(() => remoteDataSource.createUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
          avatar: any(named: 'avatar'))).thenThrow(tException);
      final result = await repositoryImplementation.createUser(
          createdAt: createdAt, name: name, avatar: avatar);
      expect(
          result,
          equals(Left(ApiFailure(
              message: tException.message,
              statusCode: tException.statusCode))));
      verify(() => remoteDataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar)).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });
  group('getUsers', () {
    test(
        'should call the [RemoteDataSource.getUsers and return [Lis<User>] when call to remote source is successful',
        () async {
      when(() => remoteDataSource.getUsers()).thenAnswer(
        (_) async => [],
      );
      final result = await repositoryImplementation.getUsers();
      expect(result, isA<Right<dynamic, List<User>>>());
      verify(() => remoteDataSource.getUsers()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test('should return a [ApiFailure] when the call to the remote source is unsuccessful', () async {
      when(()=> remoteDataSource.getUsers()).thenThrow(tException);
      final result = await repositoryImplementation.getUsers();
      expect(result, equals(Left(ApiFailure.fromException(tException))));
      verify(() => remoteDataSource.getUsers()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });
}
