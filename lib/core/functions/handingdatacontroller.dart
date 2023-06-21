import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../class/statusrequest.dart';

handlingData(response){
  if (response is StatusRequest){
    return response ;
  }else {
    return StatusRequest.success ;
  }
}

StatusRequest handleException(dynamic e) {
  if (e is SocketException) {
    print('SocketException: $e');
    return StatusRequest.serverException;
  } else if (e is http.ClientException) {
    print('HTTP ClientException: $e');
    return StatusRequest.serverException;
  } else if (e is TimeoutException) {
    print('TimeoutException: $e');
    return StatusRequest.timeout;
  } else {
    print('Unknown Exception: $e');
    return StatusRequest.serverException;
  }
}