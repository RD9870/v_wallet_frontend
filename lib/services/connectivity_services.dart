import 'dart:io';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ConnectivityServices {
  static Future<bool> hasNetwork() async {
    try {
      final bool isConnected = await InternetConnection().hasInternetAccess;
      return isConnected;
    } on SocketException catch (_) {
      return false;
    }
  }
}
