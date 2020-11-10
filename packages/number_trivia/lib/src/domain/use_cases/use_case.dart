import 'package:dartz/dartz.dart';

import '../entities/errors/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
