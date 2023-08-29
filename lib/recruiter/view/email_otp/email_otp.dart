import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job2/components/box_btn.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import '../../../otp_verification/otp_verification_view.dart';
import '../bottom_bar/bottom_navbar.dart';

class Email_otp extends StatefulWidget {
  const Email_otp({super.key});

  @override
  State<Email_otp> createState() => _Email_otpState();
}

class _Email_otpState extends State<Email_otp> {
  String? otp = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Text(
                    "OTP Verification",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text("We sent your code to +1 898 860 ***"),
                  buildTimer(),
                  SizedBox(height: 30),
                  OTPTextField(
                    length: 4,
                    width: MediaQuery.of(context).size.width,
                    fieldWidth: 50,
                    style: TextStyle(fontSize: 10),
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldStyle: FieldStyle.box,
                    onCompleted: (pin) {
                      setState(() {
                        otp = pin;
                      });
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
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
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BoxButton(
          text: 'verify',
          onTap: () {
            Get.offAll(DashboardPageR(),
                transition: Transition.rightToLeftWithFade);
          },
        ),
      ),
    );
  }
}
