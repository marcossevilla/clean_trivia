import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import 'package:errors/errors.dart';

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
    return _getNumberTriviaFromURL('http://numbersapi.com/random');
  }

  @override
  Future<NumberTriviaModel> getSpecificNumberTrivia(int number) {
    return _getNumberTriviaFromURL('http://numbersapi.com/$number');
  }

  Future<NumberTriviaModel> _getNumberTriviaFromURL(String url) async {
    final response = await client.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final trivia = NumberTriviaModel.fromJson(json.decode(response.body));
      return trivia;
    } else {
      throw ServerException();
    }
  }
}
