import 'package:dartz/dartz.dart';

import 'package:errors/errors.dart';

import '../entities/number_trivia.dart';
import '../entities/params.dart';
import '../repositories/number_trivia_repository.dart';
import '../use_cases/use_case.dart';

class GetSpecificNumberTrivia implements UseCase<NumberTrivia, Params> {
  GetSpecificNumberTrivia(this.repository);

  final NumberTriviaRepository repository;

  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) async {
    return await repository.getSpecificNumberTrivia(params.number);
  }
}
