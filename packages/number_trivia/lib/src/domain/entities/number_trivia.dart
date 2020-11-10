import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class NumberTrivia extends Equatable {
  NumberTrivia({
    @required this.text,
    @required this.number,
  }) : super();

  final String text;
  final int number;

  @override
  List<Object> get props => [text, number];
}
