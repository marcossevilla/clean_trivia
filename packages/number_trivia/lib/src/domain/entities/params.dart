import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Params extends Equatable {
  Params({@required this.number});

  final int number;

  @override
  List<Object> get props => [number];
}

/// alternative class
class NoParams extends Equatable {
  @override
  List<Object> get props => throw UnimplementedError();
}
