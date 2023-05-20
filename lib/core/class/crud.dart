import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:pfe_flutter/core/class/statusrequest.dart';
import '../functions/checkinternet.dart';

class Crud {
  Future<Either<StatusRequest, Map<String, dynamic>>> postData(
      String linkurl, Map<String, String> data) async {
    if (await checkInternet()) {
      try {
        var response = await http
            .post(Uri.parse(linkurl), body: data)
            .timeout(Duration(seconds: 10));
        print(data);
        print(response.statusCode);

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map<String, dynamic> responsebody = jsonDecode(response.body);
          print(responsebody);

          return Right(responsebody);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } on SocketException catch (e) {
        print('SocketException: $e');
        return const Left(StatusRequest.serverException);
      } on http.ClientException catch (e) {
        print('HTTP ClientException: $e');
        return const Left(StatusRequest.serverException);
      } on TimeoutException catch (e) {
        print('TimeoutException: $e');
        return const Left(StatusRequest.timeout); // change this line
      } catch (e) {
        print('Unknown Exception: $e');
        return const Left(StatusRequest.serverException);
      }
    } else {
      return const Left(StatusRequest.offlinefailure);
    }
  }
}

