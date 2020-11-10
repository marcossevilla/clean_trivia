import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:number_trivia/number_trivia.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'Test Text');

  test(
    'should be a subclass of NumberTrivia entity',
    () => expect(tNumberTriviaModel, isA<NumberTrivia>()),
  );

  group('fromJson', () {
    test(
      'should return a valid model when the JSON number is an int',
      () {
        final Map<String, dynamic> map = json.decode(
          fixture('trivia.json'),
        );

        final result = NumberTriviaModel.fromJson(map);

        expect(result, tNumberTriviaModel);
      },
    );

    test(
      'should return a valid model when JSON number is a double',
      () {
        final Map<String, dynamic> map = json.decode(
          fixture('trivia_double.json'),
        );

        final result = NumberTriviaModel.fromJson(map);

        expect(result, tNumberTriviaModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () {
        final result = tNumberTriviaModel.toJson();

        final expectedMap = {'text': 'Test Text', 'number': 1};

        expect(result, expectedMap);
      },
    );
  });
}
