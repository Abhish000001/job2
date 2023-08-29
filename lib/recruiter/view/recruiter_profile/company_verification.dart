import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job2/recruiter/view/recruiter_profile/recruiter_profile_view.dart';
import '../../../components/box_btn.dart';
import '../email_otp/email_otp.dart';

class Company_Verification extends StatefulWidget {
  const Company_Verification({super.key});

  @override
  State<Company_Verification> createState() => _Company_VerificationState();
}

class _Company_VerificationState extends State<Company_Verification> {
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(' Recruiter Company Verification',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Verify with your work email',
                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                    SizedBox(
                      height: 20,
                    ),
                    FiledArea('Enter Your Email ID', controller: email,
                        validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please fill data';
                      }
                      return null;
                    }, keyboardType: TextInputType.emailAddress)
                  ],
                ),
              ],
            )),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(18.0),
        child: BoxButton(
            text: 'Next',
            onTap: () {
              Get.to(Email_otp(), transition: Transition.rightToLeftWithFade);
            }),
      ),
    );
  }
}
