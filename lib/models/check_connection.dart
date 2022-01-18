import 'package:connectivity/connectivity.dart' as connection;

Future<bool> checkConnection() async {
  var connectivityResult =
      await (connection.Connectivity().checkConnectivity());
  if (connectivityResult == connection.ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == connection.ConnectivityResult.wifi) {
    return true;
  }
  return false;
}
