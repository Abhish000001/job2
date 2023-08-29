import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job2/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../components/box_btn.dart';
import 'edit_profile_details.dart';
import 'job_status.dart';
import 'resume_screen.dart';
import 'setting.dart';
import 'switch_screen.dart';
var jobde1;
var isLogedIn;
class Profile_details extends StatefulWidget {
  const Profile_details({super.key});

  @override
  State<Profile_details> createState() => _Profile_detailsState();
}

class _Profile_detailsState extends State<Profile_details> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kSilverColor,
        actions: [
          IconButton(
              onPressed: () {
                Get.to(Settings(), transition: Transition.rightToLeft);
              },
              icon: Icon(
                Icons.settings,
                color: Colors.black87,
              ))
        ],
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('My profile Picture',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Get.to(Edit_details(),
                                          transition:
                                              Transition.rightToLeftWithFade);
                                    },
                                    icon: Icon(Icons.edit_outlined)),
                                Text('Edit My Profile',
                                    style: TextStyle(
                                      fontSize: 14,
                                    )),
                              ],
                            )
                          ],
                        ),
                        CircleAvatar(
                            radius: 35,
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.camera_alt_outlined,
                                size: 30,
                              ),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            FutureBuilder(future: get_tootaljob_view(), builder: (context, snapshot) {
                              return  Text(
                                jobde1['view job'].toString(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              );
                            },),

                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Viewed jobs',
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '40',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'job chat',
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '20',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Sent Resume',
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '50',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Saved Resume',
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 80,
                      width: 400,
                      color: Colors.white,
                      child: ListTile(
                        onTap: () {
                          Get.to(Job_status(),
                              transition: Transition.rightToLeftWithFade);
                        },
                        leading: Icon(Icons.icecream),
                        title: Text('Job Searching Status'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 300,
                      width: 400,
                      color: Colors.white,
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.icecream),
                            title: Text('Saved Jobs'),
                            trailing: Icon(Icons.arrow_forward_ios),
                          ),
                          ListTile(
                            onTap: () {
                              Get.to(Upload_resume(),
                                  transition: Transition.rightToLeftWithFade);
                            },
                            leading: Icon(Icons.document_scanner),
                            title: Text('Upload Resume'),
                            trailing: Icon(Icons.arrow_forward_ios),
                          ),
                          ListTile(
                            onTap: () {
                              Get.to(Switch_Screen(),
                                  transition: Transition.rightToLeftWithFade);
                            },
                            leading: Icon(Icons.swipe),
                            title: Text('Switch'),
                            trailing: Icon(Icons.arrow_forward_ios),
                          ),
                          ListTile(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        ListTile(
                                          leading: new Icon(Icons.person),
                                          title: new Text('Whatsapp'),
                                          subtitle: Text('+919999999999'),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        ListTile(
                                          leading: new Icon(Icons.mail),
                                          title: new Text('Email'),
                                          subtitle: Text('123@gmail.com'),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            },
                            leading: Icon(Icons.contact_page),
                            title: Text('Contect Us'),
                            trailing: Icon(Icons.arrow_forward_ios),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }

  get_tootaljob_view() async {
    var shared_preferences = await SharedPreferences.getInstance();
    isLogedIn = shared_preferences.getString('id');
   // print(isLogedIn);
    final jobd1 = await http
        .post(Uri.parse("https://rojgaarr.com/api/get_total_view"),
        body: {
      'user_id': isLogedIn.toString(),
    });
    jobde1 = jsonDecode(jobd1.body.toString());
    print(jobde1);
  }

}
