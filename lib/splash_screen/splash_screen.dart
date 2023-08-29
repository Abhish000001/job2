import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job2/job_seeker/view/bottom_nav_view.dart/bottom_navebar.dart';
import 'package:job2/recruiter/view/bottom_bar/bottom_navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../job_seeker/view/welcome_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
  with TickerProviderStateMixin {
  late AnimationController animationController;
  late AnimationController slideAnimation;
  late Animation<Offset> offsetAnimation;
  late Animation<Offset> textAnimation;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this,
        lowerBound: 0,
        upperBound: 60,
        animationBehavior: AnimationBehavior.normal,
        duration: const Duration(milliseconds: 700));

    animationController.forward();

    slideAnimation = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));

    offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-0.5, 0.0),
    ).animate(CurvedAnimation(
      parent: slideAnimation,
      curve: Curves.fastOutSlowIn,
    ));

    textAnimation = Tween<Offset>(
      begin: const Offset(-0.5, 0.0),
      end: const Offset(0.2, 0.0),
    ).animate(
        CurvedAnimation(parent: slideAnimation, curve: Curves.fastOutSlowIn));

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        slideAnimation.forward();
      }
    });

    Future.delayed(const Duration(seconds: 4), () async {
      var shared_preferences = await SharedPreferences.getInstance();
      var isLogedIn = shared_preferences.getString('id');
      var uTyper = shared_preferences.getString('type');
      var isLogedInr = shared_preferences.getString('user_id');
      var uType = shared_preferences.getString('user_type');


      print(uType);
      print(isLogedIn);
      print(uTyper);
      print(isLogedInr);

      if (isLogedIn != null && uType != 'recruiter Exits') {
        Get.offAll(DashboardPage(), transition: Transition.rightToLeftWithFade);
      } else if (isLogedInr != null && uTyper == 'recruiter Exits') {
        Get.offAll(DashboardPageR(),
            transition: Transition.rightToLeftWithFade);
      } else {
        print('f');
        Get.offAll(DreamJob(),transition: Transition.rightToLeftWithFade);
      }

      // Get.offAll( DreamJob(),);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        // color: primary,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('assets/images/img_main.png'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: animationController,
                    builder: (_, child) {
                      return SlideTransition(
                        position: offsetAnimation,
                        child: Icon(
                          Icons.search,
                          color: primary,
                          size: animationController.value,
                        ),
                      );
                    },
                  ),
                  SlideTransition(
                    position: textAnimation,
                    child: const Text(
                      "Job hunting \nmade easy",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: primary,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
