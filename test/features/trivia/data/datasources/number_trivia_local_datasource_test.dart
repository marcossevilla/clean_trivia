import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:errors/errors.dart';
import 'package:number_trivia/number_trivia.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockPreferences extends Mock implements Box {}

void main() {
  NumberTriviaLocalDataSourceImpl dataSource;
  MockPreferences preferences;

  setUp(() {
    preferences = MockPreferences();
    dataSource = NumberTriviaLocalDataSourceImpl(prefs: preferences);
  });

  group('getLastNumberTrivia', () {
    final triviaFixture = fixture('trivia_cached.json');

    final tNumberTriviaModel = NumberTriviaModel.fromJson(
      json.decode(triviaFixture),
    );

    test(
      'should return NumberTrivia from preferences when there is',
      () async {
        // setup -> create the object to test
        when(preferences.get(any)).thenReturn(triviaFixture);
        // side effects -> collect the result to test
        final result = await dataSource.getLastNumberTrivia();
        // expectations -> compare result to expected value
        verify(preferences.get(kCachedNumberTrivia));
        expect(result, equals(tNumberTriviaModel));
      },
    );

    test(
      'should throw CacheException when there\'s no cached trivia',
      () {
        // setup -> create the object to test
        when(preferences.get(any)).thenReturn(null);
        // side effects -> collect the result to test
        final call = dataSource.getLastNumberTrivia;
        // expectations -> compare result to expected value
        expect(call, throwsA(isInstanceOf<CacheException>()));
      },
    );
  });

  group('cacheNumberTrivia', () {
    final tNumberTriviaModel = NumberTriviaModel(
      text: 'test trivia',
      number: 1,
    );

    test(
      'should cached the data via preferences',
      () {
        // side effects -> collect the result to test
        dataSource.cacheNumberTrivia(tNumberTriviaModel);
        // expectations -> compare result to expected value
        final expectedJson = json.encode(tNumberTriviaModel.toJson());
        verify(preferences.put(kCachedNumberTrivia, expectedJson));
      },
    );
  });
}
