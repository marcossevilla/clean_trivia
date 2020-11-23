part of 'numbertrivia_bloc.dart';

@immutable
abstract class NumberTriviaState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends NumberTriviaState {}

class Loading extends NumberTriviaState {
  Loading({@required this.trivia});

  @override
  List<Object> get props => [trivia];

  final NumberTrivia trivia;
}

class Error extends NumberTriviaState {
  Error({@required this.message});

  @override
  List<Object> get props => [message];

  final String message;
}
