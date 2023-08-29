import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job2/components/box_btn.dart';
import 'package:job2/job_seeker/view/bottom_nav_view.dart/bottom_navebar.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import '../job_seeker/view/job_preference/job_preferance.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../recruiter/view/recruiter_profile/recruiter_profile_view.dart';
import '../utils/utils.dart';
import 'verify_controller.dart';

class MyVerify extends StatefulWidget {
  final String userstatus;
  const MyVerify({Key? key, required this.userstatus}) : super(key: key);

  @override
  State<MyVerify> createState() => _MyVerifyState();
}

class _MyVerifyState extends State<MyVerify> {
  bool isLoading = false;
  final otpController = Get.put(OtpController());
  final formKey = GlobalKey<FormState>();
  String otp = '';
  String reendotp = Get.arguments[0]['otp'];
  SharedPreferences? pref;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZICGbHGMgoj85tWivwsJNkp0s-C7YRVwwmQ&usqp=CAU'),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "OTP Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "We sent your code ${Get.arguments[0]['otp']} to  ${Get.arguments[0]['mobile'].toString()}",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              buildTimer(),
              SizedBox(
                height: 30,
              ),
              Pinput(
                  length: 4,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,
                  showCursor: true,
                  onCompleted: (pin) {
                    setState(() {
                      otp = pin;
                    });
                  }),
              SizedBox(
                height: 20,
              ),
              BoxButton(
                  isloading: isLoading,
                  text: 'Verify Phone Number',
                  onTap: () async {
                    pref = await SharedPreferences.getInstance();
                    setState(() {
                      isLoading = true;
                    });
                    // Get.offAll(Job_preference());
                    Map body = {
                      'user_id': loggedinUser!.data!.id,
                      'otp': otp,
                    };
                    log(body.toString());


                    var res = await http.post(Uri.parse(baseurl + "verify_otp"),
                        body: body);
                    var resData = json.decode(res.body);
                    if (res.statusCode == 200 &&
                        resData["result"].toString() == "true") {
                      var isLogedIn = pref!
                          .setString('id', loggedinUser!.data!.id.toString());
                      var uType = pref!.setString(
                          'user_type', loggedinUser!.data!.userType.toString());
                      print(isLogedIn);
                      print(uType);
                      Utils().sendMassage('Otp verify Successfully');
                      setState(() {
                        isLoading = false;
                      });
                      if(widget.userstatus.toString()=="User Not Exits"){
                        Get.offAll(Job_preference(),
                          transition: Transition.rightToLeft);}
                      else if(widget.userstatus.toString()=="User Exits"){
                        Get.offAll(DashboardPage(),transition: Transition.rightToLeftWithFade);
                      }
                      log(res.statusCode.toString());
                      log(res.body);
                    } else {
                      Utils().sendMassage('${resData['msg']}');
                      setState(() {
                        isLoading = false;
                      });
                    }
                  }),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  Map body = {'user_id': loggedinUser!.data!.id};
                  log(body.toString());
                  var res = await http.post(Uri.parse(baseurl + "resend_otp"),
                      body: body);
                  var resData = json.decode(res.body);
                  if (res.statusCode == 200 &&
                      resData["result"].toString() == "true") {
                    Utils().sendMassage('${resData['msg']}');

                    log(res.statusCode.toString());
                    log(res.body);
                  } else {
                    Utils().sendMassage('${resData['msg']}');
                  }

                  // OTP code resend
                },
                child: Text(
                  "Resend OTP Code",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Row buildTimer() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text("This code will expired in "),
      TweenAnimationBuilder(
        tween: Tween(begin: 60.0, end: 0.0),
        duration: Duration(seconds: 30),
        builder: (_, dynamic value, child) => Text(
          "00:${value.toInt()}",
          style: TextStyle(color: primary),
        ),
      ),
    ],
  );
}
