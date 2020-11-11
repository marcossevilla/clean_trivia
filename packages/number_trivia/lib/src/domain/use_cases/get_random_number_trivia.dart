import 'package:dartz/dartz.dart';

import 'package:errors/errors.dart';

import '../../../number_trivia.dart';
import '../repositories/number_trivia_repository.dart';
import 'use_case.dart';

class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {
  GetRandomNumberTrivia(this.repository);

  final NumberTriviaRepository repository;

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    return await repository.getRandomNumberTrivia();
  }
}
