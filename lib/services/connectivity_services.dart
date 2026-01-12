import 'dart:io';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';



class ConnectivityServices {

  static  Future<bool> hasNetwork() async {
    try {
      // This checks multiple reliable addresses (e.g., Google DNS)
      final bool isConnected = await InternetConnection().hasInternetAccess;
      return isConnected;
    } on SocketException catch (_) {
      // Handle potential socket errors
      return false;
    }
  }
}