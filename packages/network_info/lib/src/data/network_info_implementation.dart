import 'package:data_connection_checker/data_connection_checker.dart';

import '../domain/network_info.dart';

class NetworkInfoImplementation implements NetworkInfo {
  NetworkInfoImplementation(this.connectionChecker);

  final DataConnectionChecker connectionChecker;

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
