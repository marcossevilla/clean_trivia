import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:errors/errors.dart';
import 'package:number_trivia/number_trivia.dart';

import '../../../core/utils/input_converter.dart';

part 'numbertrivia_event.dart';
part 'numbertrivia_state.dart';

const kServerFailureMessage = 'Server Failure';
const kCacheFailureMessage = 'Server Failure';
const kInvalidInputFailureMessage = 'Invalid Input Failure - 0<=x';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  NumberTriviaBloc({
    @required GetSpecificNumberTrivia specific,
    @required GetRandomNumberTrivia random,
    @required InputConverter converter,
  })  : assert(specific != null),
        assert(random != null),
        assert(converter != null),
        _getSpecificNumberTrivia = specific,
        _getRandomNumberTrivia = random,
        _inputConverter = converter,
        super(Empty());

  final GetSpecificNumberTrivia _getSpecificNumberTrivia;
  final GetRandomNumberTrivia _getRandomNumberTrivia;
  final InputConverter _inputConverter;

  @override
  Stream<NumberTriviaState> mapEventToState(
    NumberTriviaEvent event,
  ) async* {
    if (event is GetTriviaForSpecificNumber) {
      final inputEither = _inputConverter.convertStringToInt(event.numberStr);

      yield* inputEither.fold(
        (failure) async* {
          yield Error(message: kInvalidInputFailureMessage);
        },
        (integer) async* {
          yield Loading();
          final failureOrTrivia =
              await _getSpecificNumberTrivia(Params(number: integer));
          yield* _eitherLoadedOrErrorState(failureOrTrivia);
        },
      );
    } else if (event is GetTriviaForRandomNumber) {
      yield Loading();
      final failureOrTrivia = await _getRandomNumberTrivia(NoParams());
      yield* _eitherLoadedOrErrorState(failureOrTrivia);
    }
  }

  Stream<NumberTriviaState> _eitherLoadedOrErrorState(
    Either<Failure, NumberTrivia> failureOrTrivia,
  ) async* {
    yield failureOrTrivia.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (trivia) => Loaded(trivia: trivia),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return kServerFailureMessage;
      case CacheFailure:
        return kCacheFailureMessage;
      default:
        return 'Unexpected error';
    }
  }
}
