import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants.dart';
import '../../../job_seeker/view/profile_view/setting.dart';
import '../recruiter_profile/post_job_view.dart';
import '../recruiter_profile/recruiter_profile_view.dart';
import '../switch/switch.dart';

class Edit_profile extends StatefulWidget {
  const Edit_profile({super.key});

  @override
  State<Edit_profile> createState() => _Edit_profileState();
}

class _Edit_profileState extends State<Edit_profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kSilverColor,
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(Settings(),
                      transition: Transition.rightToLeftWithFade);
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
                                      Get.to(Recruiter_profile(),
                                          transition: Transition.rightToLeft);
                                    },
                                    icon: Icon(Icons.edit_outlined)),
                                Text('Edit My Company Profile',
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
                            Text(
                              '110',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'View Candidate',
                              style: TextStyle(
                                fontSize: 8,
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
                              'Candidate chat',
                              style: TextStyle(
                                fontSize: 8,
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
                              'Received Resume',
                              style: TextStyle(
                                fontSize: 8,
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
                              'Save Candidate',
                              style: TextStyle(
                                fontSize: 8,
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
                          // Get.to(Job_status());
                        },
                        leading: Icon(Icons.icecream),
                        title: Text('Job opening Status'),
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
                            title: Text('Saved Candidate Profile'),
                            trailing: Icon(Icons.arrow_forward_ios),
                          ),
                          ListTile(
                            onTap: () {
                              Get.to(Job_Post(), transition: Transition.rightToLeft);
                            },
                            leading: Icon(Icons.document_scanner),
                            title: Text('Post Job'),
                            trailing: Icon(Icons.arrow_forward_ios),
                          ),
                          ListTile(
                            onTap: () {
                              Get.to(Switch_position(),
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
            ),
          ),
        ));
  }
}
