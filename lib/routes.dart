import 'package:get/get.dart';
import 'package:pfe_flutter/core/constant/routes.dart';
import 'package:pfe_flutter/core/middleware/mymiddleware.dart';
import 'package:pfe_flutter/view/screen/auth/forgetpassword/forgetpassword.dart';
import 'package:pfe_flutter/view/screen/auth/forgetpassword/resetpassword.dart';
import 'package:pfe_flutter/view/screen/auth/forgetpassword/success_resetpassword.dart';
import 'package:pfe_flutter/view/screen/auth/forgetpassword/verifycode.dart';
import 'package:pfe_flutter/view/screen/auth/login.dart';
import 'package:pfe_flutter/view/screen/calanderpage.dart';
import 'package:pfe_flutter/view/screen/evaluationpage.dart';
import 'package:pfe_flutter/view/screen/homescreen.dart';
import 'package:pfe_flutter/view/screen/inspectiondetailspage.dart';
import 'package:pfe_flutter/view/screen/language.dart';


List<GetPage<dynamic>>? routes = [
  GetPage(name: "/", page: ()=>const Language(),middlewares: [
    MyMiddleWare()
  ]) ,
    // Auth
  GetPage(name: AppRoute.login, page: ()=>const Login()) ,
  GetPage(name: AppRoute.calander, page: ()=> const CalanderPage()) ,
  GetPage(name: AppRoute.forgetPassword, page: ()=>const ForgetPassword()) ,
  GetPage(name: AppRoute.verfiyCode, page: ()=>const VerfiyCode()) ,
  GetPage(name: AppRoute.resetPassword, page: ()=>const ResetPassword()) ,
  GetPage(name: AppRoute.successResetpassword, page: ()=>const SuccessResetPassword()) ,
  GetPage(name: AppRoute.InspectionDetailsPage, page: ()=>const InspectionDetailsPage()) ,
  GetPage(name: AppRoute.EvaluationPage, page: ()=>const EvaluationPage()) ,
  GetPage(name: AppRoute.homepage, page: () => const HomeScreen()),
  //GetPage(name: AppRoute.verfiyCodeSignUp, page: ()=>const VerfiyCodeSignUp()) ,
] ;
//Map<String, Widget Function(BuildContext)> routess = {
  // Auth
 // AppRoute.login: (context) => const Login(),
 // AppRoute.signUp: (context) => const SignUp(),
  //AppRoute.forgetPassword: (context) => const ForgetPassword(),
  //AppRoute.verfiyCode: (context) => const VerfiyCode(),
  //AppRoute.resetPassword: (context) => const ResetPassword(),
  //AppRoute.successResetpassword: (context) => const SuccessResetPassword(),
  //AppRoute.successSignUp: (context) => const SuccessSignUp(),
  //AppRoute.verfiyCodeSignUp: (context) => const VerfiyCodeSignUp(),
  // OnBoarding
  //AppRoute.onBoarding: (context) => const OnBoarding(),
//};
