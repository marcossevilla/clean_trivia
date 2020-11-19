import 'dart:convert';

import 'package:errors/errors.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../models/remote/number_trivia_model.dart';

/// *
/// * constant for key in preferences, can be used to test too
/// *
const kCachedNumberTrivia = 'CACHED_NUMBER_TRIVIA';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTriviaModel> getLastNumberTrivia();
  Future<void> cacheNumberTrivia(NumberTriviaModel trivia);
}

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  NumberTriviaLocalDataSourceImpl({@required this.prefs});

  final Box prefs;

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() async {
    final jsonStr = prefs.get(kCachedNumberTrivia);

    if (jsonStr != null) {
      final trivia = NumberTriviaModel.fromJson(json.decode(jsonStr));

      return Future.value(trivia);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel trivia) {
    return prefs.put(kCachedNumberTrivia, json.encode(trivia.toJson()));
  }
}
