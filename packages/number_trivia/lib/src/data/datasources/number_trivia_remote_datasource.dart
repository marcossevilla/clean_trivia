import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../models/remote/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel> getRandomNumberTrivia();
  Future<NumberTriviaModel> getSpecificNumberTrivia(int number);
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  NumberTriviaRemoteDataSourceImpl({@required this.client});

  final http.Client client;

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() {
    // TODO: implement getRandomNumberTrivia
    return null;
  }

  @override
  Future<NumberTriviaModel> getSpecificNumberTrivia(int number) {
    // TODO: implement getSpecificNumberTrivia
    return null;
  }
}
