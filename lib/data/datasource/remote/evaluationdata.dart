import 'dart:async';
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:pfe_flutter/core/class/crud.dart';
import 'package:pfe_flutter/core/class/statusrequest.dart';
import 'package:pfe_flutter/core/functions/checkinternet.dart';
import 'package:pfe_flutter/core/services/services.dart';
import 'package:pfe_flutter/data/model/evaluationdatamodel.dart';
import 'package:pfe_flutter/linkapi.dart';
import 'package:http/http.dart' as http;

class EvaluationData {
  final Crud crud;

  EvaluationData(this.crud);
  final MyServices myServices = Get.find();

  Future<Either<StatusRequest, EvaluationDataModel?>> getEvaluationData(int id) async {
   // final MyServices myServices = Get.find();
    final token = myServices.sharedPreferences.getString('token');

    if (token == null) {
      return Left(StatusRequest.invalidToken);
    }

    var response = await crud.getData(AppLink.evaluation + "/${id}",
        headers: {'Authorization': 'Bearer $token'});
    return response.fold(
            (statusRequest) => Left(statusRequest),
            (json) {
          if(json.isNotEmpty) {
            return Right(EvaluationDataModel.fromJson(json));
          } else {
            return const Left(StatusRequest.noData);
          }
        }
    );
  }
}

