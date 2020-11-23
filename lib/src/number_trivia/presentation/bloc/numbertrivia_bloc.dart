import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:number_trivia/number_trivia.dart';

part 'numbertrivia_event.dart';
part 'numbertrivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  NumberTriviaBloc() : super(Empty());

  @override
  Stream<Empty> mapEventToState(
    NumberTriviaEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
