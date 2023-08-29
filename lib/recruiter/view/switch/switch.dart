import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job2/job_seeker/view/job_preference/job_preferance.dart';

import '../../../components/box_btn.dart';
import '../../../constants.dart';

class Switch_position extends StatefulWidget {
  const Switch_position({super.key});

  @override
  State<Switch_position> createState() => _Switch_positionState();
}

class _Switch_positionState extends State<Switch_position> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kSilverColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Switch',
          style: TextStyle(
              fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage("assets/images/images.jfif")),
            Text(
              'You Are currently a Recruiter',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            BoxButton(
                text: 'Switch to JobSeeker',
                onTap: () {
                  Get.off(Job_preference(),
                      transition: Transition.rightToLeftWithFade);
                }),
            BoxButton(
                text: 'Back',
                onTap: () {
                  Get.back();
                })
          ],
        ),
      ),
    );
  }
}
