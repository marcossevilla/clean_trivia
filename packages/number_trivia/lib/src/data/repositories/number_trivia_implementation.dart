import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';

import 'package:errors/errors.dart';
import 'package:network_info/network_info.dart';

import '../../domain/domain.dart';
import '../datasources/number_trivia_local_datasource.dart';
import '../datasources/number_trivia_remote_datasource.dart';

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
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() {
    // TODO: implement getRandomNumberTrivia
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, NumberTrivia>> getSpecificNumberTrivia(int number) {
    // TODO: implement getSpecificNumberTrivia
    throw UnimplementedError();
  }
}
