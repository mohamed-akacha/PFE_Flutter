import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pfe_flutter/core/class/statusrequest.dart';
import 'package:pfe_flutter/core/functions/checkinternet.dart';
import 'package:pfe_flutter/core/functions/handingdatacontroller.dart';
import 'package:pfe_flutter/data/model/evaluation.dart';
import 'package:pfe_flutter/linkapi.dart';

class SendEvaluation {
  Future<StatusRequest> sendEvaluation(List<Evaluation> evaluations , String token ) async {

      if (await checkInternet()) {
        print("-----------------------");
        print(jsonEncode(evaluations.map((e) => e.toJson()).toList()));

        try {
          const url = AppLink.sendEvaluation;
          final headers = {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          };

          final response = await http.post(
            Uri.parse(url),
            headers: headers,
            body: jsonEncode(evaluations.map((e) => e.toJson()).toList()),
          );


          print(response.statusCode);
          print (response.body);

          if (response.statusCode == 200 || response.statusCode == 201) {
            return StatusRequest.success;
          } else if (response.statusCode == 404) {
            return StatusRequest.notFound;
          } else if (response.statusCode >= 500) {
            return StatusRequest.serverfailure;
          } else {
            return StatusRequest.clientError;
          }
        } catch (e) {
          return handleException(e);
        }
      } else {
        return StatusRequest.offlinefailure;
      }

  }
}
