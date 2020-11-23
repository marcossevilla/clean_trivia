part of 'numbertrivia_bloc.dart';

@immutable
abstract class NumberTriviaEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetTriviaForSpecificNumber extends NumberTriviaEvent {
  GetTriviaForSpecificNumber(this.numberStr);

  final String numberStr;
}

class GetTriviaForRandomNumber extends NumberTriviaEvent {}
