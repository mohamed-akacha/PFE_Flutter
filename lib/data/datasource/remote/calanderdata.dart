import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pfe_flutter/core/class/statusrequest.dart';
import 'package:pfe_flutter/core/services/services.dart';
import 'dart:convert';
import 'package:pfe_flutter/data/model/inspection.dart';
import 'package:pfe_flutter/linkapi.dart';

class CalendarData {
  var client = http.Client();
  final String apiUrl = AppLink.inspection;
  final MyServices myServices = Get.find();

  Future<dynamic> getInspections() async {
    final token = myServices.sharedPreferences.getString('token');
    try {
      var response = await client.get( Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonString = response.body;
        List jsonList = json.decode(jsonString);  // Ensure that the json is a List type

        return jsonList.map<Inspection>((inspection) => Inspection.fromJson(inspection)).toList();
      } else {
        // Here we can return StatusRequest.failure or a more specific status depending on the error
        return StatusRequest.serverfailure;
      }
    } catch (e) {
      print(e);
      // Here we return a status in case of any error
      return StatusRequest.failure;
    }
  }
}


