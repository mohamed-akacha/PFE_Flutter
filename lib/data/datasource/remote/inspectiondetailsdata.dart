import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:pfe_flutter/core/class/crud.dart';
import 'package:pfe_flutter/core/class/statusrequest.dart';
import 'package:pfe_flutter/core/services/services.dart';
import 'package:pfe_flutter/data/model/inspection.dart';
import 'package:pfe_flutter/linkapi.dart';

class InspectionDetailsData {
  final Crud crud;  // Utilisation de la classe Crud
  InspectionDetailsData(this.crud);  // Injection de Crud dans le constructeur
  final MyServices myServices = Get.find();

  Future<Either<StatusRequest, Inspection?>> getInspectionDetails(int id) async {
    final token = myServices.sharedPreferences.getString('token');
    if (token == null) {
      return Left(StatusRequest.invalidToken);
    }

    var response = await crud.getData(AppLink.inspection + "/${id}",
        headers: {'Authorization': 'Bearer $token'});

    return response.fold(
          (statusRequest) => Left(statusRequest),
          (responseBody) => Right(Inspection.fromJson(responseBody)),
    );
  }
}

