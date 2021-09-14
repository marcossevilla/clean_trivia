import 'package:clean_trivia/src/core/utils/input_converter.dart';
import 'package:clean_trivia/src/number_trivia/presentation/bloc/numbertrivia_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:network_info/network_info.dart';
import 'package:number_trivia/number_trivia.dart';

import 'src/core/app.dart';

const _kPreferencesBox = '_preferencesBox';

void main() async {
  await Hive.initFlutter();
  final prefs = await Hive.openBox(_kPreferencesBox);

  final client = http.Client();
  final dataConnectionChecker = DataConnectionChecker();

  final numberTriviaLocalDataSource = NumberTriviaLocalDataSourceImpl(
    prefs: prefs,
  );

  final numberTriviaRemoteDataSource = NumberTriviaRemoteDataSourceImpl(
    client: client,
  );

  final networkInfo = NetworkInfoImplementation(dataConnectionChecker);

  final numberTriviaRepository = NumberTriviaImplementation(
    remoteDataSource: numberTriviaRemoteDataSource,
    localDataSource: numberTriviaLocalDataSource,
    networkInfo: networkInfo,
  );

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: numberTriviaRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => NumberTriviaBloc(
              specific: GetSpecificNumberTrivia(
                context.read<NumberTriviaImplementation>(),
              ),
              random: GetRandomNumberTrivia(
                context.read<NumberTriviaImplementation>(),
              ),
              converter: InputConverter(),
            ),
          ),
        ],
        child: CleanTriviaApp(),
      ),
    ),
  );
}
