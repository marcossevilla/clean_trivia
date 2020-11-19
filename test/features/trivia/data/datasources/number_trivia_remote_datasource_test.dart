import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'package:number_trivia/number_trivia.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  NumberTriviaRemoteDataSourceImpl dataSource;
}
