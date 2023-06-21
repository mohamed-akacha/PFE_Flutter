import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:pfe_flutter/core/class/statusrequest.dart';
import 'package:pfe_flutter/core/functions/checkinternet.dart';
import 'package:pfe_flutter/core/functions/handingdatacontroller.dart';
import 'package:pfe_flutter/data/model/evaluation.dart';
import 'package:pfe_flutter/linkapi.dart';

class SendEvaluation {
  Future<StatusRequest> sendEvaluation(List<Evaluation> evaluations , String token ) async {

      if (await checkInternet()) {
        try {
          const url = AppLink.sendEvaluation;
          final headers = {'Authorization': 'Bearer $token'};

          final response = await http.post(Uri.parse(url),
              headers: headers, body: evaluations);

          print(response.statusCode);

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
