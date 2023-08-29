import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/box_btn.dart';
import '../../../constants.dart';
import '../../../recruiter/view/recruiter_profile/recruiter_profile_view.dart';

class Switch_Screen extends StatefulWidget {
  const Switch_Screen({super.key});

  @override
  State<Switch_Screen> createState() => _Switch_ScreenState();
}

class _Switch_ScreenState extends State<Switch_Screen> {
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
              'You Are currently a job Seeker',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            BoxButton(
                text: 'Switch to Recruiter',
                onTap: () {
                  Get.off(Recruiter_profile());
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
