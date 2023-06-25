import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyServices extends GetxService {
  
  late SharedPreferences sharedPreferences ; 

  Future<MyServices> init() async {
  await Firebase.initializeApp();
  sharedPreferences =   await SharedPreferences.getInstance() ; 
  return this ; 
  }

  bool isTokenValid() {
    String? token = sharedPreferences.getString('token');
    if (token != null) {
      Map<String, dynamic> decodedToken = Jwt.parseJwt(token);
      if (decodedToken.containsKey('exp')) {
        int expirationTimestamp = decodedToken['exp'];
        int currentTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
        return currentTimestamp < expirationTimestamp;
      }
    }
    return false; // Le token est considéré comme invalide si le token n'est pas disponible ou ne contient pas de champ 'exp' valide
  }



  Map<String, dynamic>? decodeToken() {
    String? token = sharedPreferences.getString('token');
    if (token != null) {
      Map<String, dynamic> decodedToken = Jwt.parseJwt(token);
      print(decodedToken);
      return decodedToken;
    }
    return null;
  }


  // Récupère la liste des blocs évalués à partir de SharedPreferences
  Future<List<int>> getEvaluatedBlocks() async {
    String? json = sharedPreferences.getString('evaluatedBlocks');
    if (json != null && json.isNotEmpty) {
      List<dynamic> list = jsonDecode(json);
      return list.map((item) => item as int).toList();
    } else {
      return [];
    }
  }

  // Enregistre la liste des blocs évalués dans SharedPreferences
  Future<void> setEvaluatedBlocks(List<int> evaluatedBlocks) async {
    String json = jsonEncode(evaluatedBlocks);
    sharedPreferences.setString('evaluatedBlocks', json);
  }

}
initialServices() async  {
  await Get.putAsync(() => MyServices().init()) ; 
}