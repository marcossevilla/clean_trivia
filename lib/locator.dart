// ignore_for_file: cascade_invocations

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'package:network_info/network_info.dart';
import 'package:number_trivia/number_trivia.dart';

import 'src/core/utils/input_converter.dart';
import 'src/number_trivia/presentation/bloc/numbertrivia_bloc.dart';

const _kPreferencesBox = '_preferencesBox';

final locator = GetIt.instance;

Future<void> init() async {
  // * Features - Number Trivia
  // Bloc
  locator.registerFactory(
    () => NumberTriviaBloc(
      specific: locator(),
      random: locator(),
      converter: locator(),
    ),
  );

  // Use cases
  locator.registerLazySingleton(() => GetSpecificNumberTrivia(locator()));
  locator.registerLazySingleton(() => GetRandomNumberTrivia(locator()));

  // Repositories
  locator.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaImplementation(
      remoteDataSource: locator(),
      localDataSource: locator(),
      networkInfo: locator(),
    ),
  );

  // Data sources
  locator.registerLazySingleton<NumberTriviaRemoteDataSource>(
    () => NumberTriviaRemoteDataSourceImpl(client: locator()),
  );
  locator.registerLazySingleton<NumberTriviaLocalDataSource>(
    () => NumberTriviaLocalDataSourceImpl(prefs: locator()),
  );

  // * Features - NetworkInfo
  locator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImplementation(locator()),
  );

  // * Core
  locator.registerLazySingleton(() => InputConverter());

  // * External
  final prefs = await Hive.openBox(_kPreferencesBox);

  locator.registerLazySingleton(() => prefs);
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => DataConnectionChecker());
}
