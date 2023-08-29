import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job2/recruiter/view/bottom_bar/bottom_navbar.dart';
import 'package:job2/recruiter/view/recruiter_profile/company_verification.dart';
import 'package:job2/recruiter/view/recruiter_profile/post_job_view.dart';
import 'package:job2/recruiter/view/recruiter_profile/recruiter_profile_view.dart';
import 'job_seeker/model/user_model.dart';
import 'job_seeker/view/education_level/education_level.dart';
import 'job_seeker/view/my_bio/my_bio.dart';
import 'job_seeker/view/work_experiance/add_work_experiance.dart';
import 'splash_screen/splash_screen.dart';

void main() {
  runApp(MyApp());
}

UserModel? loggedinUser;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Find Job',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: DashboardPageR(),
      home: SplashScreen(),
    );
  }
}
