import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/Add_tag.dart';
import '../../../constants.dart';
import '../education_level/education_level.dart';
import '../job_preference/edit_job_preference.dart';
import '../job_preference/job_preferance.dart';
import '../my_bio/my_bio.dart';
import '../my_profile/my_profile.dart';
import '../work_experiance/add_work_experiance.dart';
import 'Add_skill.dart';
import 'package:http/http.dart' as http;

var uren;
final userdata = uren['data'];

class Edit_details extends StatefulWidget {
  const Edit_details({super.key});

  @override
  State<Edit_details> createState() => _Edit_detailsState();
}

class _Edit_detailsState extends State<Edit_details> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   setState(() {
  //     isLoading = true;
  //   });
  //   super.initState();
  // }
bool islooading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black87,
            )),
        backgroundColor: kSilverColor,
        elevation: 0,
        centerTitle: true,
        title: Text('My Online Resume',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87)),
      ),
      body: SafeArea(
        child:
        FutureBuilder(future: getdata(),builder: (context, snapshot) {
          // return
          return Padding(
              padding: const EdgeInsets.all(18.0),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                      "${userdata["first_name"].toString()} ${userdata["last_name"].toString()}"??""
                                      ,
                                      style: TextStyle(

                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  IconButton(
                                      onPressed: () {
                                        Get.to(Add_name(),
                                            transition: Transition.rightToLeft);
                                      },
                                      icon: Icon(Icons.edit_outlined)),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text('${userdata["Experiance_level"].toString()}',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('${userdata["dob"].toString().substring(0,10)}',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('${userdata["Education_level"].toString()}',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey)),
                                ],
                              )
                            ],
                          ),
                          CircleAvatar(
                              radius: 35,
                              child: Image.network(imageurl+userdata["profile_image"].toString())
                            // IconButton(
                            //   onPressed: () {},
                            //   icon: Icon(
                            //     Icons.camera_alt_outlined,
                            //     size: 30,
                            //   ),
                            // )
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('My bio',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          IconButton(
                              onPressed: () {
                                Get.to(My_bio(),
                                    transition: Transition.rightToLeft);
                              },
                              icon: Icon(Icons.edit_outlined)),
                        ],
                      ),
                      Text(
                        "${userdata["about_you"].toString()}" ?? "",
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Job Preference',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          IconButton(
                              onPressed: () {
                                Get.to(Edit_jobpreferance(),
                                    transition: Transition.rightToLeft);
                              },
                              icon: Icon(Icons.add_box_outlined)),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${userdata["job_type"].toString()}" ?? "null"),
                          Text("${userdata["Expected_selery"].toString()}"),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${userdata["Function_area"].toString()}',
                              style: TextStyle(color: Colors.grey)),
                          Text('${userdata["prefered_city"].toString()}',
                              style: TextStyle(color: Colors.grey)),
                          IconButton(
                              onPressed: () {
                                Get.to(Edit_jobpreferance(),
                                    transition: Transition.rightToLeft);
                              },
                              icon: Icon(Icons.arrow_forward_ios)),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Work Experience',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          IconButton(
                              onPressed: () {
                                Get.to(Work_Experiance(),
                                    transition: Transition.rightToLeft);
                              },
                              icon: Icon(Icons.edit_outlined)),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Education',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          IconButton(
                              onPressed: () {
                                Get.to(Education_level());
                              },
                              icon: Icon(Icons.add_box_outlined)),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${userdata["institude_name"].toString()}",
                              style: TextStyle(color: Colors.grey)),
                          Text(
                              "${userdata["education_startdate"].toString().substring(0, 4)}-${userdata["education_enddate"].toString().substring(0, 4)}",
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Graduation',
                              style: TextStyle(color: Colors.grey)),
                          IconButton(
                              onPressed: () {
                                Get.to(Edit_jobpreferance(),
                                    transition: Transition.rightToLeft);
                              },
                              icon: Icon(Icons.arrow_forward_ios)),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('My Skill',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          IconButton(
                              onPressed: () {
                                Get.to(Add_skill(),
                                    transition: Transition.rightToLeft);
                              },
                              icon: Icon(Icons.edit_outlined)),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SearchTag(
                        tag: '${userdata["skill"].toString()}',
                      ),
                    ],
                  ),
                ],
              ));
          //   if(snapshot.hasData ){
          //     return Padding(
          //         padding: const EdgeInsets.all(18.0),
          //         child: ListView(
          //           children: [
          //             Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 SizedBox(
          //                   height: 40,
          //                 ),
          //                 Row(
          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                   children: [
          //                     Column(
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       children: [
          //                         Row(
          //                           children: [
          //                             Text(
          //                                 "${userdata["first_name"].toString()} ${userdata["last_name"].toString()}"??""
          //                                 ,
          //                                 style: TextStyle(
          //
          //                                     fontSize: 20,
          //                                     fontWeight: FontWeight.bold)),
          //                             IconButton(
          //                                 onPressed: () {
          //                                   Get.to(Add_name(),
          //                                       transition: Transition.rightToLeft);
          //                                 },
          //                                 icon: Icon(Icons.edit_outlined)),
          //                           ],
          //                         ),
          //                         SizedBox(
          //                           height: 10,
          //                         ),
          //                         Row(
          //                           children: [
          //                             Text('${userdata["Experiance_level"].toString()}',
          //                                 style: TextStyle(
          //                                     fontSize: 14, color: Colors.grey)),
          //                             SizedBox(
          //                               width: 10,
          //                             ),
          //                             Text('${userdata["dob"].toString().substring(0,10)}',
          //                                 style: TextStyle(
          //                                     fontSize: 14, color: Colors.grey)),
          //                             SizedBox(
          //                               width: 10,
          //                             ),
          //                             Text('${userdata["Education_level"].toString()}',
          //                                 style: TextStyle(
          //                                     fontSize: 14, color: Colors.grey)),
          //                           ],
          //                         )
          //                       ],
          //                     ),
          //                     CircleAvatar(
          //                         radius: 35,
          //                         child: Image.network(imageurl+userdata["profile_image"].toString())
          //                       // IconButton(
          //                       //   onPressed: () {},
          //                       //   icon: Icon(
          //                       //     Icons.camera_alt_outlined,
          //                       //     size: 30,
          //                       //   ),
          //                       // )
          //                     )
          //                   ],
          //                 ),
          //                 SizedBox(
          //                   height: 20,
          //                 ),
          //                 Divider(),
          //                 SizedBox(
          //                   height: 20,
          //                 ),
          //                 Row(
          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                   children: [
          //                     Text('My bio',
          //                         style: TextStyle(
          //                             fontSize: 20, fontWeight: FontWeight.bold)),
          //                     IconButton(
          //                         onPressed: () {
          //                           Get.to(My_bio(),
          //                               transition: Transition.rightToLeft);
          //                         },
          //                         icon: Icon(Icons.edit_outlined)),
          //                   ],
          //                 ),
          //                 Text(
          //                   "${userdata["about_you"].toString()}" ?? "",
          //                   style: TextStyle(color: Colors.grey),
          //                 ),
          //                 SizedBox(
          //                   height: 20,
          //                 ),
          //                 Divider(),
          //                 Row(
          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                   children: [
          //                     Text('Job Preference',
          //                         style: TextStyle(
          //                             fontSize: 20, fontWeight: FontWeight.bold)),
          //                     IconButton(
          //                         onPressed: () {
          //                           Get.to(Edit_jobpreferance(),
          //                               transition: Transition.rightToLeft);
          //                         },
          //                         icon: Icon(Icons.add_box_outlined)),
          //                   ],
          //                 ),
          //                 SizedBox(
          //                   height: 30,
          //                 ),
          //                 Row(
          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                   children: [
          //                     Text("${userdata["job_type"].toString()}" ?? "null"),
          //                     Text("${userdata["Expected_selery"].toString()}"),
          //                   ],
          //                 ),
          //                 SizedBox(
          //                   height: 20,
          //                 ),
          //                 Row(
          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                   children: [
          //                     Text('${userdata["Function_area"].toString()}',
          //                         style: TextStyle(color: Colors.grey)),
          //                     Text('${userdata["prefered_city"].toString()}',
          //                         style: TextStyle(color: Colors.grey)),
          //                     IconButton(
          //                         onPressed: () {
          //                           Get.to(Edit_jobpreferance(),
          //                               transition: Transition.rightToLeft);
          //                         },
          //                         icon: Icon(Icons.arrow_forward_ios)),
          //                   ],
          //                 ),
          //                 SizedBox(
          //                   height: 20,
          //                 ),
          //                 Divider(),
          //                 Row(
          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                   children: [
          //                     Text('Work Experience',
          //                         style: TextStyle(
          //                             fontSize: 20, fontWeight: FontWeight.bold)),
          //                     IconButton(
          //                         onPressed: () {
          //                           Get.to(Work_Experiance(),
          //                               transition: Transition.rightToLeft);
          //                         },
          //                         icon: Icon(Icons.edit_outlined)),
          //                   ],
          //                 ),
          //                 SizedBox(
          //                   height: 20,
          //                 ),
          //                 Divider(),
          //                 Row(
          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                   children: [
          //                     Text('Education',
          //                         style: TextStyle(
          //                             fontSize: 20, fontWeight: FontWeight.bold)),
          //                     IconButton(
          //                         onPressed: () {
          //                           Get.to(Education_level());
          //                         },
          //                         icon: Icon(Icons.add_box_outlined)),
          //                   ],
          //                 ),
          //                 SizedBox(
          //                   height: 10,
          //                 ),
          //                 Row(
          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                   children: [
          //                     Text("${userdata["institude_name"].toString()}",
          //                         style: TextStyle(color: Colors.grey)),
          //                     Text(
          //                         "${userdata["education_startdate"].toString().substring(0, 4)}-${userdata["education_enddate"].toString().substring(0, 4)}",
          //                         style: TextStyle(color: Colors.grey)),
          //                   ],
          //                 ),
          //                 Row(
          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                   children: [
          //                     Text('Graduation',
          //                         style: TextStyle(color: Colors.grey)),
          //                     IconButton(
          //                         onPressed: () {
          //                           Get.to(Edit_jobpreferance(),
          //                               transition: Transition.rightToLeft);
          //                         },
          //                         icon: Icon(Icons.arrow_forward_ios)),
          //                   ],
          //                 ),
          //                 SizedBox(
          //                   height: 20,
          //                 ),
          //                 Divider(),
          //                 Row(
          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                   children: [
          //                     Text('My Skill',
          //                         style: TextStyle(
          //                             fontSize: 20, fontWeight: FontWeight.bold)),
          //                     IconButton(
          //                         onPressed: () {
          //                           Get.to(Add_skill(),
          //                               transition: Transition.rightToLeft);
          //                         },
          //                         icon: Icon(Icons.edit_outlined)),
          //                   ],
          //                 ),
          //                 SizedBox(
          //                   height: 30,
          //                 ),
          //                 SearchTag(
          //                   tag: '${userdata["skill"].toString()}',
          //                 ),
          //               ],
          //             ),
          //           ],
          //         ));
          //   }
          //   else{
          //     return   Center(child: CircularProgressIndicator(
          //
          //     ),);
          //   }


        },)

      ),
    );
  }

  Future getdata() async {
    var shared_preferences = await SharedPreferences.getInstance();
    var isLogedIn = shared_preferences.getString('id');
    final urdata = await http
        .post(Uri.parse("https://rojgaarr.com/api/get_profiles"), body: {
      'user_id': isLogedIn.toString(),
    });

    uren = jsonDecode(urdata.body.toString());
    print(uren['data'].toString());
  }
}
