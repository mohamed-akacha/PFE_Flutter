import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pfe_flutter/core/class/crud.dart';
import 'package:pfe_flutter/core/class/statusrequest.dart';
import 'package:pfe_flutter/core/services/services.dart';
import 'dart:convert';
import 'package:pfe_flutter/data/model/inspection.dart';
import 'package:pfe_flutter/linkapi.dart';

class CalendarData {
  final Crud crud;
  CalendarData(this.crud);
  final MyServices myServices = Get.find();

  Future<Either<StatusRequest, List<Inspection>>> getInspections() async {
    final token = myServices.sharedPreferences.getString('token');

    if (token == null) {
      return Left(StatusRequest.invalidToken);
    }
    var response = await crud.getData(AppLink.inspection,
        headers: {
          'Authorization': 'Bearer $token',
        });

    return response.fold((statusRequest) {
      // En cas d'erreur, nous retournons le StatusRequest correspondant
      return Left(statusRequest);
    }, (data) {
      // En cas de succès, nous transformons les données en une liste d'Inspection
      if (data is List) {
        List<Inspection> inspections = (data as List).map<Inspection>((inspectionJson) => Inspection.fromJson(inspectionJson as Map<String, dynamic>)).toList();
        return Right(inspections);
      } else {
        // Si les données ne sont pas une liste, nous retournons une erreur
        return Left(StatusRequest.serverfailure);
      }

    });
  }

}




