import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job2/components/box_btn.dart';
import '../constants.dart';
import '../job_seeker/view/log-in/log_in.dart';
import '../sign-in/sign-in_view.dart';

class Option_btn extends StatelessWidget {
  const Option_btn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kSilverColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Choose Your Role',
          style: TextStyle(
              fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage("assets/images/img.jfif"),
            ),
            BoxButton(
                text: 'I Am a Job Seeker',
                onTap: () {
                  Get.to(MyPhone(user_type: 'user_signup',), transition: Transition.rightToLeft);
                }),
            CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage("assets/images/images.jfif"),
            ),
            BoxButton(
                text: 'I Am a Recruiter',
                onTap: () {
                  // Get.to(Login(), transition:Transition.rightToLeft);
                  Get.defaultDialog(
                    title: "I AM A Recruiter",
                    content: SizedBox(
                      height: 150,
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                AssetImage("assets/images/img.jfif"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Now lets post a job and \nConnect with Job seekers",
                          ),
                        ],
                      ),
                    ),
                    onCancel: () {
                      Get.back();
                    },
                    onConfirm: () {
                      Get.to(MyPhone(user_type: 'recruiter_signup',));
                      // Get.to(Login(),
                      //     transition: Transition.rightToLeftWithFade);
                    },
                  );
                })
          ],
        ),
      ),
    );
  }
}
