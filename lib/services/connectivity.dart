import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityService with ChangeNotifier {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();

  ConnectivityService() {
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _checkInitialConnectivity();
  }

  ConnectivityResult get connectionStatus => _connectionStatus;
  bool get isConnected => _connectionStatus != ConnectivityResult.none;

  // Update the connection status and notify listeners
  Future _updateConnectionStatus(List<ConnectivityResult> result) async {
    if (_connectionStatus != result) {
      _connectionStatus = result.first;
      notifyListeners();
    }
  }

  // Check the initial connectivity status when the service is created
  Future<void> _checkInitialConnectivity() async {
    final List<ConnectivityResult> result =
        await _connectivity.checkConnectivity();
    _updateConnectionStatus(result);
  }
}
