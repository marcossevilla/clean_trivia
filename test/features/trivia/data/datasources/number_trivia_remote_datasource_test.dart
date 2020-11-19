import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'package:errors/errors.dart';
import 'package:number_trivia/number_trivia.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  MockHttpClient client;
  NumberTriviaRemoteDataSourceImpl dataSource;

  final fixtureStr = fixture('trivia.json');
  final tNumberTriviaModel = NumberTriviaModel.fromJson(
    json.decode(fixtureStr),
  );

  setUp(() {
    client = MockHttpClient();
    dataSource = NumberTriviaRemoteDataSourceImpl(client: client);
  });

  void setUpHttpClientSuccess() {
    when(
      client.get(any, headers: anyNamed('headers')),
    ).thenAnswer((_) async => http.Response(fixtureStr, 200));
  }

  void setUpHttpClientFailure() {
    when(
      client.get(any, headers: anyNamed('headers')),
    ).thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getSpecificNumberTrivia', () {
    const tNumber = 1;

    test(
      '''should perform a GET request on a URL with number
       being the endpoint and with application/json header''',
      () async {
        // arrange
        setUpHttpClientSuccess();
        // act
        await dataSource.getSpecificNumberTrivia(tNumber);
        // assert
        verify(
          client.get(
            'http://numbersapi.com/$tNumber',
            headers: {'Content-Type': 'application/json'},
          ),
        );
      },
    );

    test(
      'should return NumberTrivia when the response code is 200 (success)',
      () async {
        // arrange
        setUpHttpClientSuccess();
        // act
        final result = await dataSource.getSpecificNumberTrivia(tNumber);
        // assert
        expect(result, equals(tNumberTriviaModel));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpHttpClientFailure();
        // act
        final call = dataSource.getSpecificNumberTrivia(tNumber);
        // assert
        expect(call, throwsA(isInstanceOf<ServerException>()));
      },
    );
  });

  group('getRandomNumberTrivia', () {
    test(
      '''should perform a GET request on a URL with number
       being the endpoint and with application/json header''',
      () async {
        // arrange
        setUpHttpClientSuccess();
        // act
        await dataSource.getRandomNumberTrivia();
        // assert
        verify(
          client.get(
            'http://numbersapi.com/random',
            headers: {'Content-Type': 'application/json'},
          ),
        );
      },
    );

    test(
      'should return NumberTrivia when the response code is 200 (success)',
      () async {
        // arrange
        setUpHttpClientSuccess();
        // act
        final result = await dataSource.getRandomNumberTrivia();
        // assert
        expect(result, equals(tNumberTriviaModel));
      },
    );
    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpHttpClientFailure();
        // act
        final call = dataSource.getRandomNumberTrivia;
        // assert
        expect(call, throwsA(isInstanceOf<ServerException>()));
      },
    );
  });
}
