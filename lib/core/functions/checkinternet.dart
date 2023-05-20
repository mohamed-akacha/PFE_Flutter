import 'package:connectivity_plus/connectivity_plus.dart';

checkInternet() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    // J'ai une connexion mobile
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    // J'ai une connexion wifi
    return true;
  } else {
    // Je n'ai aucune connexion
    return false;
  }
}
