import '../models/remote/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel> getRandomNumberTrivia();
  Future<NumberTriviaModel> getSpecificNumberTrivia(int number);
}
