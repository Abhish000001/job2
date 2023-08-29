import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job2/components/box_btn.dart';
import 'package:job2/job_seeker/view/log-in/log_in.dart';
import 'package:http/http.dart' as http;
import '../../../constants.dart';
import '../../../utils/utils.dart';
import '../sub_screen/describe_job.dart';
import 'company_verification.dart';
import 'recruiter_profile_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Job_Post extends StatefulWidget {
  const Job_Post({super.key});

  @override
  State<Job_Post> createState() => _Job_PostState();
}

class _Job_PostState extends State<Job_Post> {
  TextEditingController job_title = TextEditingController();
  TextEditingController job_description = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController skill = TextEditingController();
  TextEditingController noOfcandidate = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? dropdownvalue = 'Experiance';
  String? dropdownvalue2 = 'Education';
  String? dropdownvalue1 = 'Salary';
  bool isLoading = false;

  // List of items in our dropdown menu
  var items = [
    'Experiance',
    'Fresher',
    '0-1 Year',
    '1-2 Year',
    '2-3 Year',
    '3-5 Year',
    '5-10 Year',
  ];
  var items1 = ['Education', 'School', 'Graduation', 'Post Graduation'];
  var list = [
    'Salary',
    'Rs 1-2LPA',
    'Rs 2-4LPA',
    'Rs 4-6LPA',
    'Rs 6-10LPA',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: ListView(
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text('Post a Job',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Add About job details',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      SizedBox(
                        height: 20,
                      ),
                      //

                      Divider(),

                      Text('Job Title',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      SizedBox(
                        height: 20,
                      ),

                      FiledArea('Fill the job title', controller: job_title,
                          validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please fill data';
                        }
                        return null;
                      }, keyboardType: TextInputType.name),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Job Description',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      SizedBox(
                        height: 20,
                      ),
                      //  ListTile(
                      //   onTap: (){
                      //     Get.to(Describe_job());
                      //   },
                      //   title: Text('Describe Job'),
                      //    trailing: Icon(Icons.arrow_forward_ios),
                      //   ),
                      FiledArea('Describe Job', controller: description,
                          validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please fill data';
                        }
                        return null;
                      }, keyboardType: TextInputType.name),

                      SizedBox(
                        height: 20,
                      ),
                      Text('Job Requirements',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          DropdownButtonHideUnderline(
                            child: Container(
                              height: 70,
                              width: 110,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: DropdownButton(
                                // Initial Value
                                value: dropdownvalue,

                                // Down Arrow Icon
                                icon: const Icon(Icons.keyboard_arrow_down),

                                // Array list of items
                                items: items.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(items,
                                          style: TextStyle(fontSize: 10)),
                                    ),
                                  );
                                }).toList(),
                                // After selecting the desired option,it will
                                // change button value to selected value
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownvalue = newValue!;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          DropdownButtonHideUnderline(
                            child: Container(
                              height: 70,
                              width: 110,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: DropdownButton(
                                // Initial Value
                                value: dropdownvalue2,

                                // Down Arrow Icon
                                icon: const Icon(Icons.keyboard_arrow_down),

                                // Array list of items
                                items: items1.map((String items1) {
                                  return DropdownMenuItem(
                                    value: items1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        items1,
                                        style: TextStyle(fontSize: 7),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                // After selecting the desired option,it will
                                // change button value to selected value
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownvalue2 = newValue!;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          DropdownButtonHideUnderline(
                            child: Container(
                              height: 70,
                              width: 110,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: DropdownButton(
                                // Initial Value
                                value: dropdownvalue1,

                                // Down Arrow Icon
                                icon: const Icon(Icons.keyboard_arrow_down),

                                // Array list of items
                                items: list.map((String list) {
                                  return DropdownMenuItem(
                                    value: list,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        list,
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                // After selecting the desired option,it will
                                // change button value to selected value
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownvalue1 = newValue!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      Text('Job Location',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      SizedBox(
                        height: 20,
                      ),
                      FiledArea('Add City', controller: city,
                          validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please fill data';
                        }
                        return null;
                      }, keyboardType: TextInputType.name),
                      SizedBox(
                        height: 20,
                      ),

                      Text('number of opening',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      SizedBox(
                        height: 20,
                      ),
                      FiledArea('Add number', controller: noOfcandidate,
                          validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please fill data';
                        }
                        return null;
                      }, keyboardType: TextInputType.phone),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Require Skills',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      SizedBox(
                        height: 20,
                      ),
                      FiledArea('Add Skill', controller: skill,
                          validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please fill data';
                        }
                        return null;
                      }, keyboardType: TextInputType.name),
                    ],
                  ),
                ),
              ],
            )),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BoxButton(
          isloading: isLoading,
          text: 'post',
          onTap: () async {
            var shared_preferences = await SharedPreferences.getInstance();
           var isLogedIn = shared_preferences.getString('user_id');
            if (formKey.currentState!.validate()) {
              setState(() {
                isLoading = true;
              });
              Map body = {
                'user_id':isLogedIn.toString() ,
                'title': job_title.text,
                'experience': dropdownvalue,
                'education': dropdownvalue2,
                'sallary': dropdownvalue1,
                'city': city.text,
                'skill': skill.text,
                'no_candidate': noOfcandidate.text,
                'discription': description.text,
              };
              log(body.toString());
              var res = await http
                  .post(Uri.parse(baseurl + "recruiter_job_post"), body: body);
              var resData = json.decode(res.body);

              if (res.statusCode == 200 &&
                  resData["result"].toString() == true.toString()) {
                Utils().sendMassage('${resData['msg']}');
                setState(() {
                  isLoading = false;
                });

                Get.off(Company_Verification(),
                    transition: Transition.rightToLeft);
                log(res.body);
              } else {
                Utils().sendMassage('${resData['msg']}');
                setState(() {
                  isLoading = false;
                });
              }
            }
          },
        ),
      ),
    );
  }
}
