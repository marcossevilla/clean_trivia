part of 'numbertrivia_bloc.dart';

@immutable
abstract class NumberTriviaEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetTriviaForSpecificNumber extends NumberTriviaEvent {
  GetTriviaForSpecificNumber(this.numberStr);

  final String numberStr;

  @override
  List<Object> get props => [numberStr];
}

class GetTriviaForRandomNumber extends NumberTriviaEvent {}
