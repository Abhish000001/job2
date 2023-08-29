import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job2/components/box_btn.dart';
import 'package:job2/sign-in/sign-in_view.dart';
import 'package:job2/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants.dart';
import '../../../option/option_view.dart';
import 'privacy_policy.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kSilverColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Settings',
          style: TextStyle(
              fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      onTap: () {
                        Get.to(Privacy_policy());
                      },
                      title: Text('Privacy Policy'),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    ListTile(
                      onTap: () {},
                      title: Text('Terms Condition'),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    ListTile(
                      onTap: () {},
                      title: Text('About'),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ],
                ),
              ],
            )),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(18.0),
        child: BoxButton(
          text: 'Log Out',
          onTap: () async {
            //  Get.offAll(MyPhone());
            Get.defaultDialog(
              title: 'LogOut',
              content: Text(
                "Are you sure you want to logout",
              ),
              onCancel: () {
                Get.back();
              },
              onConfirm: () async {
                var shared_preferences = await SharedPreferences.getInstance();
                shared_preferences.clear();
                Utils().sendMassage('LogOUT');
                Get.offAll(Option_btn());
              },
            );
          },
        ),
      ),
    );
  }
}
