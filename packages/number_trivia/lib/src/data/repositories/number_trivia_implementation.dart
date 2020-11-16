import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';

import 'package:errors/errors.dart';
import 'package:network_info/network_info.dart';

import '../../domain/domain.dart';
import '../datasources/number_trivia_local_datasource.dart';
import '../datasources/number_trivia_remote_datasource.dart';

typedef _SpecificOrRandomTrivia = Future<NumberTrivia> Function();

class NumberTriviaImplementation implements NumberTriviaRepository {
  NumberTriviaImplementation({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return await _getTrivia(remoteDataSource.getRandomNumberTrivia);
  }

  @override
  Future<Either<Failure, NumberTrivia>> getSpecificNumberTrivia(
    int number,
  ) async {
    return await _getTrivia(
      () => remoteDataSource.getSpecificNumberTrivia(number),
    );
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(
    _SpecificOrRandomTrivia getSpecificOrRandom,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final trivia = await getSpecificOrRandom();
        await localDataSource.cacheNumberTrivia(trivia);
        return Right(trivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final trivia = await localDataSource.getLastNumberTrivia();
        return Right(trivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
