import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:pfe_flutter/core/class/crud.dart';
import 'package:pfe_flutter/core/class/statusrequest.dart';
import 'package:pfe_flutter/core/services/services.dart';
import 'package:pfe_flutter/data/model/notification.dart';
import 'package:pfe_flutter/linkapi.dart';

class NotificationData {
  Crud crud;

  NotificationData(this.crud);

  Future<Either<StatusRequest, List<NotificationModel>>> getData(int id) async {
    final MyServices myServices = Get.find();
    final token = myServices.sharedPreferences.getString('token');
    if (token == null) {
      return const Left(StatusRequest.invalidToken);
    }
    var response = await crud.getData(AppLink.notifications + "/${id}",
        headers: {'Authorization': 'Bearer $token'});
    return response.fold(
            (l) => Left(l),
            (r) => Right((r as List<dynamic>).map((item) => NotificationModel.fromJson(item as Map<String, dynamic>)).toList())
    );
  }

  Future<Either<StatusRequest, NotificationModel?>> markNotificationAsRead(int notificationId) async {
    final MyServices myServices = Get.find();
    final token = myServices.sharedPreferences.getString('token');
    if (token == null) {
      return Left(StatusRequest.invalidToken);
    }

    var response = await crud.patchData(AppLink.notifications + "/$notificationId" , {"read": true},
        headers: {'Authorization': 'Bearer $token'},
       );

    return response.fold(
          (l) => Left(l),
          (r) => Right(NotificationModel.fromJson(r as Map<String, dynamic>)),
    );
  }



}
