import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../entities.dart';
import '../repositories.dart';

class GetSpecificNumberTrivia {
  GetSpecificNumberTrivia(this.repository);

  final NumberTriviaRepository repository;

  Future<Either<Failure, NumberTrivia>> execute({@required int number}) async {
    return await repository.getSpecificNumberTrivia(number);
  }
}
