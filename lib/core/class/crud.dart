import 'dart:async';
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:pfe_flutter/core/class/statusrequest.dart';
import 'package:pfe_flutter/core/functions/handingdatacontroller.dart';
import 'package:pfe_flutter/core/services/services.dart';
import '../functions/checkinternet.dart';

class Crud {

  final MyServices myServices; // ajoutez une instance de MyServices

  Crud({required this.myServices});

  Future<Either<StatusRequest, Map<String, dynamic>>> postData(
      String linkurl, Map<String, String> data, {Map<String, String>? headers}) async {
    if (headers != null && !myServices.isTokenValid()) {
      return Left(StatusRequest.invalidToken);
    }
    if (await checkInternet()) {
      try {
        var response = await http
            .post(Uri.parse(linkurl), body: data , headers: headers)
            .timeout(Duration(seconds: 10));
        print(data);
        print(response.statusCode);

        if (response.statusCode == 200 || response.statusCode == 201) {
          if (response.body.isEmpty) {
            return const Left(StatusRequest.noData);
          }
          Map<String, dynamic> responsebody = jsonDecode(response.body);
          print(responsebody);

          return Right(responsebody);
        } else if (response.statusCode == 404) {
          return const Left(StatusRequest.notFound);
        } else if (response.statusCode == 401) {
          return Left(StatusRequest.unauthorized) ;
        }
        else if (response.statusCode >= 500) {
          return const Left(StatusRequest.serverfailure);
        } else {
          return const Left(StatusRequest.clientError);
        }
      } catch (e) {
        return Left(handleException(e));
      }
    } else {
      return const Left(StatusRequest.offlinefailure);
    }
  }

  Future<Either<StatusRequest, dynamic>> getData(String linkurl , {Map<String, String>? headers}) async {

    if (headers != null && !myServices.isTokenValid()) {
      return Left(StatusRequest.invalidToken);
    }
    if (await checkInternet()) {
      try {
        var response = await http.get(Uri.parse(linkurl) , headers: headers).timeout(Duration(seconds: 10));
        print(response.statusCode);
        if (response.statusCode == 200 || response.statusCode == 201) {
          if (response.body.isEmpty) {
            return const Left(StatusRequest.noData);
          }
          var responsebody = jsonDecode(response.body);
          print(responsebody);
          return Right(responsebody);
        } else if (response.statusCode == 404) {
          return const Left(StatusRequest.notFound);
        } else if (response.statusCode >= 500) {
          return const Left(StatusRequest.serverfailure);
        } else {
          return const Left(StatusRequest.clientError);
        }
      } catch (e) {
        return Left(handleException(e));
      }
    } else {
      return const Left(StatusRequest.offlinefailure);
    }
  }

  Future<Either<StatusRequest, Map<String, dynamic>>> patchData(
      String linkurl, Map<String, dynamic> data, {Map<String, String>? headers}) async {
    if (headers != null && !myServices.isTokenValid()) {
      return Left(StatusRequest.invalidToken);
    }
    if (await checkInternet()) {
      try {
        var response = await http
            .patch(Uri.parse(linkurl), body: jsonEncode(data), headers: headers)
            .timeout(Duration(seconds: 10));
        print(data);
        print(response.statusCode);

        if (response.statusCode == 200 || response.statusCode == 201) {
          if (response.body.isEmpty) {
            return const Left(StatusRequest.noData);
          }
          Map<String, dynamic> responsebody = jsonDecode(response.body);
          print(responsebody);

          return Right(responsebody);
        }else if (response.statusCode == 401) {
          return Left(StatusRequest.unauthorized);
        }  else if (response.statusCode == 404) {
          return const Left(StatusRequest.notFound);
        } else if (response.statusCode >= 500) {
          return const Left(StatusRequest.serverfailure);
        } else {
          print(response);
          return const Left(StatusRequest.clientError);
        }
      } catch (e) {
        return Left(handleException(e));
      }
    } else {
      return const Left(StatusRequest.offlinefailure);
    }
  }


}

