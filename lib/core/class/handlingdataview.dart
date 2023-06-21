import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pfe_flutter/core/class/statusrequest.dart';
import 'package:pfe_flutter/core/constant/imgaeasset.dart';

class HandlingDataView extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;

  const HandlingDataView({Key? key, required this.statusRequest, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (statusRequest) {
      case StatusRequest.loading:
        return Center(child: Lottie.asset(AppImageAsset.loading, width: 250, height: 250));
      case StatusRequest.offlinefailure:
        return Center(child: Lottie.asset(AppImageAsset.offline, width: 250, height: 250));
      case StatusRequest.serverfailure:
        return Center(child: Lottie.asset(AppImageAsset.server, width: 250, height: 250));
      case StatusRequest.serverException:
        return Center(child: Lottie.asset(AppImageAsset.serverException, width: 250, height: 250));
      case StatusRequest.timeout:
        return Center(child: Lottie.asset(AppImageAsset.timeout, width: 250, height: 250));
      case StatusRequest.clientError:
        return Center(child: Lottie.asset(AppImageAsset.clientError, width: 250, height: 250));
      case StatusRequest.notFound:
        return Center(child: Lottie.asset(AppImageAsset.notFound, width: 250, height: 250));
      case StatusRequest.noData:
        return Center(child: Lottie.asset(AppImageAsset.noData, width: 250, height: 250, repeat: true));
      default:
        return widget;
    }
  }
}



class HandlingDataRequest extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  const HandlingDataRequest(
      {Key? key, required this.statusRequest, required this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? Center(
        child: Lottie.asset(AppImageAsset.loading, width: 250, height: 250))
        : statusRequest == StatusRequest.offlinefailure
        ? Center(
        child: Lottie.asset(AppImageAsset.offline,
            width: 250, height: 250))
        : statusRequest == StatusRequest.serverfailure
        ? Center(
        child: Lottie.asset(AppImageAsset.server,
            width: 250, height: 250))
        : widget;
  }
}