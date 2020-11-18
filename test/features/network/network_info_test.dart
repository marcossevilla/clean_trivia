import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:network_info/network_info.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

void main() {
  NetworkInfoImplementation networkInfo;
  MockDataConnectionChecker dataConnectionChecker;

  setUp(() {
    dataConnectionChecker = MockDataConnectionChecker();
    networkInfo = NetworkInfoImplementation(dataConnectionChecker);
  });

  group('isConnected', () {
    test(
      'forward the call to DataConnectionChecker.hasConnection',
      () async {
        // setup -> create the object to test
        final tIsConnected = Future.value(true);

        when(
          dataConnectionChecker.hasConnection,
        ).thenAnswer((_) => tIsConnected);

        // side effects -> collect the result to test
        final result = networkInfo.isConnected;

        // expectations -> compare result to expected value
        verify(dataConnectionChecker.hasConnection);
        expect(result, tIsConnected);
      },
    );
  });
}
