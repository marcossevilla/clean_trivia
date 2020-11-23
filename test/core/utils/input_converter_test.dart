import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:clean_trivia/src/core/utils/input_converter.dart';

void main() {
  InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('convertStringToInt', () {
    test(
      'should return an int when strings is really an integer',
      () {
        // setup -> create the object to test
        const str = '123';
        // side effects -> collect the result to test
        final result = inputConverter.convertStringToInt(str);
        // expectations -> compare result to expected value
        expect(result, const Right(123));
      },
    );

    test(
      'should return a failure when the string is a negative int',
      () {
        // setup -> create the object to test
        const str = '-123';
        // side effects -> collect the result to test
        final result = inputConverter.convertStringToInt(str);
        // expectations -> compare result to expected value
        expect(result, Left(InvalidInputFailure()));
      },
    );
  });
}
