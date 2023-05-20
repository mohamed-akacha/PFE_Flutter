import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pfe_flutter/core/class/statusrequest.dart';
import 'package:pfe_flutter/core/functions/checkinternet.dart';
import 'package:pfe_flutter/core/services/services.dart';
import 'package:pfe_flutter/data/model/inspection.dart';
import 'package:pfe_flutter/linkapi.dart';

class InspectionDetailsData {
  var client = http.Client();
  final String apiUrl = AppLink.inspection; // Changer cela vers le bon endpoint
  final MyServices myServices = Get.find();

  Future<Either<StatusRequest, Inspection?>> getInspectionDetails(int id) async {
    if (await checkInternet()) {
      try {
        final token = myServices.sharedPreferences.getString('token');
        var response = await client.get( Uri.parse(apiUrl + "/$id"),
          headers: {
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          var jsonString = response.body;
          var inspectionJson = json.decode(jsonString);
          return Right(Inspection.fromJson(inspectionJson));
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } catch (e) {
        return const Left(StatusRequest.serverException);
      }
    } else {
      return const Left(StatusRequest.offlinefailure);
    }
  }
}
