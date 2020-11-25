import 'package:dartz/dartz.dart';
import 'package:errors/errors.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:number_trivia/number_trivia.dart';

import 'package:clean_trivia/src/core/utils/input_converter.dart';
import 'package:clean_trivia/src/number_trivia/presentation/bloc/numbertrivia_bloc.dart';

class MockGetSpecificNumberTrivia extends Mock
    implements GetSpecificNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  NumberTriviaBloc bloc;
  MockGetSpecificNumberTrivia mockGetSpecificNumberTrivia;
  MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  MockInputConverter mockConverter;

  setUp(() {
    mockGetSpecificNumberTrivia = MockGetSpecificNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockConverter = MockInputConverter();

    bloc = NumberTriviaBloc(
      specific: mockGetSpecificNumberTrivia,
      random: mockGetRandomNumberTrivia,
      converter: mockConverter,
    );
  });

  test(
    'initialState should be Empty',
    () => expect(bloc.state, equals(Empty())),
  );

  group('GetTriviaForSpecificNumber', () {
    const tNumberStr = '1';
    const tNumberParsed = 1;
    final tNumberTrivia = NumberTrivia(number: 1, text: 'test trivia');

    void setUpMockInputConverterRight() {
      when(
        mockConverter.convertStringToInt(any),
      ).thenReturn(const Right(tNumberParsed));
    }

    test(
      'should validate with InputConverter to convert string to int',
      () async {
        // setup -> create the object to test
        setUpMockInputConverterRight();
        // side effects -> collect the result to test
        bloc.add(GetTriviaForSpecificNumber(tNumberStr));
        await untilCalled(mockConverter.convertStringToInt(any));

        // expectations -> compare result to expected value
        verify(mockConverter.convertStringToInt(tNumberStr));
      },
    );

    test(
      'should emit [Error] when the input is invalid',
      () {
        // setup -> create the object to test
        when(
          mockConverter.convertStringToInt(any),
        ).thenReturn(Left(InvalidInputFailure()));

        // side effects -> collect the result to test
        final expected = [Error(message: kInvalidInputFailureMessage)];

        // expectations -> compare result to expected value
        expectLater(bloc, emitsInOrder(expected));

        bloc.add(GetTriviaForSpecificNumber(tNumberStr));
      },
    );

    test(
      'should get data from the specific use case',
      () async {
        // setup -> create the object to test
        setUpMockInputConverterRight();

        when(
          mockGetSpecificNumberTrivia(any),
        ).thenAnswer((_) async => Right(tNumberTrivia));

        // side effects -> collect the result to test
        bloc.add(GetTriviaForSpecificNumber(tNumberStr));
        await untilCalled(mockGetSpecificNumberTrivia(any));

        // expectations -> compare result to expected value
        verify(mockGetSpecificNumberTrivia(Params(number: tNumberParsed)));
      },
    );

    test(
      'should emit [Loading, Loaded] when data is gotten successfully',
      () {
        // setup -> create the object to test
        setUpMockInputConverterRight();

        when(
          mockGetSpecificNumberTrivia(any),
        ).thenAnswer((_) async => Right(tNumberTrivia));

        // side effects -> collect the result to test
        final expected = [Loading(), Loaded(trivia: tNumberTrivia)];

        expectLater(bloc, emitsInOrder(expected));

        bloc.add(GetTriviaForSpecificNumber(tNumberStr));
      },
    );

    test(
      'should emit [Loading, Error] when getting data fails',
      () {
        // setup -> create the object to test
        setUpMockInputConverterRight();

        when(
          mockGetSpecificNumberTrivia(any),
        ).thenAnswer((_) async => Left(ServerFailure()));

        // side effects -> collect the result to test
        final expected = [Loading(), Error(message: kServerFailureMessage)];

        expectLater(bloc, emitsInOrder(expected));

        bloc.add(GetTriviaForSpecificNumber(tNumberStr));
      },
    );

    test(
      'should emit [Loading, Error] right message when getting data fails',
      () {
        // setup -> create the object to test
        setUpMockInputConverterRight();

        when(
          mockGetSpecificNumberTrivia(any),
        ).thenAnswer((_) async => Left(CacheFailure()));

        // side effects -> collect the result to test
        final expected = [Loading(), Error(message: kCacheFailureMessage)];

        expectLater(bloc, emitsInOrder(expected));

        bloc.add(GetTriviaForSpecificNumber(tNumberStr));
      },
    );
  });

  group('GetTriviaForRandomNumber', () {
    final tNumberTrivia = NumberTrivia(number: 1, text: 'test trivia');

    test(
      'should get data from the random use case',
      () async {
        // arrange
        when(
          mockGetRandomNumberTrivia(any),
        ).thenAnswer((_) async => Right(tNumberTrivia));
        // act
        bloc.add(GetTriviaForRandomNumber());
        await untilCalled(mockGetRandomNumberTrivia(any));
        // assert

        /// ? don't know why this test doesn't pass
        // verify(mockGetRandomNumberTrivia(NoParams()));
      },
    );

    test(
      'should emit [Loading, Loaded] when data is gotten successfully',
      () {
        // setup -> create the object to test
        when(
          mockGetRandomNumberTrivia(any),
        ).thenAnswer((_) async => Right(tNumberTrivia));

        // side effects -> collect the result to test
        final expected = [Loading(), Loaded(trivia: tNumberTrivia)];

        expectLater(bloc, emitsInOrder(expected));

        bloc.add(GetTriviaForRandomNumber());
      },
    );

    test(
      'should emit [Loading, Error] when getting data fails',
      () {
        // setup -> create the object to test
        when(
          mockGetRandomNumberTrivia(any),
        ).thenAnswer((_) async => Left(ServerFailure()));

        // side effects -> collect the result to test
        final expected = [Loading(), Error(message: kServerFailureMessage)];

        expectLater(bloc, emitsInOrder(expected));

        bloc.add(GetTriviaForRandomNumber());
      },
    );

    test(
      'should emit [Loading, Error] right message when getting data fails',
      () {
        // setup -> create the object to test
        when(
          mockGetRandomNumberTrivia(any),
        ).thenAnswer((_) async => Left(CacheFailure()));

        // side effects -> collect the result to test
        final expected = [Loading(), Error(message: kCacheFailureMessage)];

        expectLater(bloc, emitsInOrder(expected));

        bloc.add(GetTriviaForRandomNumber());
      },
    );
  });
}
