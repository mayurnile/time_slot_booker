import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfo {
  static Future<bool> get isConnected async {
    final Connectivity _connectivity = Connectivity();
    final ConnectivityResult _connectionStatus =
        await _connectivity.checkConnectivity();
    final bool result = _connectionStatus == ConnectivityResult.mobile ||
        _connectionStatus == ConnectivityResult.wifi;
    return result;
  }
}
