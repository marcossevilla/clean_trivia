import 'package:dartz/dartz.dart';

import 'package:errors/errors.dart';

class InputConverter {
  Either<Failure, int> convertStringToInt(String str) {
    try {
      final integer = int.parse(str);
      if (integer < 0) throw const FormatException();

      return Right(integer);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
