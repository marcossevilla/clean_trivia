import '../models/remote/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() {
    // TODO: implement getRandomNumberTrivia
    throw UnimplementedError();
  }

  @override
  Future<NumberTriviaModel> getSpecificNumberTrivia(int number) {
    // TODO: implement getSpecificNumberTrivia
    throw UnimplementedError();
  }
}
