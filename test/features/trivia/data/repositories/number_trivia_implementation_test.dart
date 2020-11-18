import 'package:dartz/dartz.dart';
import 'package:errors/errors.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:network_info/network_info.dart';
import 'package:number_trivia/number_trivia.dart';

class MockRemoteDataSource extends Mock
    implements NumberTriviaRemoteDataSource {}

class MockLocalDataSource extends Mock implements NumberTriviaLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  NumberTriviaImplementation repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();

    repository = NumberTriviaImplementation(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getSpecificNumberTrivia', () {
    const tNumber = 1;

    final tNumberTriviaModel = NumberTriviaModel(
      text: 'test trivia',
      number: tNumber,
    );

    final NumberTrivia tNumberTrivia = tNumberTriviaModel;

    test(
      'should check if the device is online',
      () async {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

        await repository.getSpecificNumberTrivia(tNumber);

        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when remote data source call succeeds',
        () async {
          when(
            mockRemoteDataSource.getSpecificNumberTrivia(any),
          ).thenAnswer((_) async => tNumberTriviaModel);

          final result = await repository.getSpecificNumberTrivia(tNumber);

          verify(mockRemoteDataSource.getSpecificNumberTrivia(tNumber));

          expect(result, equals(Right(tNumberTrivia)));
        },
      );

      test(
        'should cache data when remote data source call succeeds',
        () async {
          when(
            mockRemoteDataSource.getSpecificNumberTrivia(any),
          ).thenAnswer((_) async => tNumberTriviaModel);

          await repository.getSpecificNumberTrivia(tNumber);

          verify(mockRemoteDataSource.getSpecificNumberTrivia(tNumber));
          verify(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
        },
      );

      test(
        'should return server failure when remote data source call fails',
        () async {
          when(
            mockRemoteDataSource.getSpecificNumberTrivia(any),
          ).thenThrow(ServerException());

          final result = await repository.getSpecificNumberTrivia(tNumber);

          verify(mockRemoteDataSource.getSpecificNumberTrivia(tNumber));
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return last cached data when there\'s data stored',
        () async {
          when(
            mockLocalDataSource.getLastNumberTrivia(),
          ).thenAnswer((_) async => tNumberTriviaModel);

          final result = await repository.getSpecificNumberTrivia(tNumber);

          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastNumberTrivia());
          expect(result, equals(Right(tNumberTrivia)));
        },
      );

      test(
        'should return cached failure when there\'s no data stored',
        () async {
          when(
            mockLocalDataSource.getLastNumberTrivia(),
          ).thenThrow(CacheException());

          final result = await repository.getSpecificNumberTrivia(tNumber);

          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastNumberTrivia());
          expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });
}
