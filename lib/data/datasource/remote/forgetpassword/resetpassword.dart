
import 'package:pfe_flutter/core/class/crud.dart';
import 'package:pfe_flutter/linkapi.dart';

class ResetPasswordData {
  Crud crud;
  ResetPasswordData(this.crud);
  postdata(String email ,String password) async {
    var response = await crud.postData(AppLink.resetPassword, {
      "email" : email , 
      "newPassword" : password
    });
    return response.fold((l) => l, (r) => r);
  }
}
