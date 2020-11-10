import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class NumberTrivia extends Equatable {
  NumberTrivia({
    @required this.number,
    @required this.text,
  });

  final int number;
  final String text;

  @override
  List<Object> get props => [number, text];
}
