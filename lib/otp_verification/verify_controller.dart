import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../job_seeker/view/job_preference/job_preferance.dart';

class OtpController extends GetxController {
  final formKey = GlobalKey<FormState>();
  SharedPreferences? pref;
  String otp = '';
  otpValue(String pin) {
    otp = pin;
    log('hy' + pin.toString());
    update();
  }

  // verify()async{
  //    Map body = {
  //     'user_id':
  //       'otp': otp,
  //     };
  //      log('hiii'+body.toString());
  //     var res = await http.post(Uri.parse(baseurl + "verify_otp"), body: body);
  //     var resData = json.decode(res.body);
  //     if (res.statusCode == 200 && resData["result"].toString() == "true"){
  //        Get.offAll(Job_preference());
  //       //  loggedinUser = UserModel.fromJson(resData);
  //       // log("renu" + loggedinUser!.toJson().toString());
  //       // pref!.setString('id', loggedinUser!.data!.id.toString());
  //       //  log(res.body);

  //     }else{

  //     }
}
