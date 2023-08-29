import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job2/components/box_btn.dart';
import '../../../constants.dart';
import '../../../main.dart';
import '../../../utils/utils.dart';
import '../job_preference/job_preferance.dart';
import '../profile_view/Add_skill.dart';
import '../profile_view/sub_profile_screen/responiblity.dart';

class Work_Experiance extends StatefulWidget {
  const Work_Experiance({super.key});

  @override
  State<Work_Experiance> createState() => _Work_ExperianceState();
}

class _Work_ExperianceState extends State<Work_Experiance> {
  TextEditingController Company = TextEditingController();
  TextEditingController profile = TextEditingController();
  TextEditingController roll_res = TextEditingController();
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  DateTime dateTime = DateTime.now();
  DateTime dateTime1 = DateTime.now();
  List<String> data = <String>[
    'less then 6th month',
    'more then 6th month',
    '1-3 years',
    '3-5 years',
    '5+ years',
  ];
  int raw = 0;
  double _kItemExtent = 32.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kSilverColor,
        elevation: 0,
        centerTitle: true,
        title: Text('Work Experiance',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87)),
      ),
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
                        height: 10,
                      ),
                      Text('Total Experiance',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) {
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.35,
                                  decoration: new BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: new BorderRadius.only(
                                      topLeft: const Radius.circular(25.0),
                                      topRight: const Radius.circular(25.0),
                                    ),
                                  ),
                                  child: CupertinoPicker(
                                    magnification: 1.22,
                                    squeeze: 1.2,
                                    useMagnifier: true,
                                    itemExtent: _kItemExtent,
                                    // This is called when selected item is changed.
                                    onSelectedItemChanged: (int selectedItem) {
                                      setState(() {
                                        raw = selectedItem;
                                      });
                                    },
                                    children: List<Widget>.generate(data.length,
                                        (int index) {
                                      return Center(
                                        child: Text(
                                          data[index],
                                        ),
                                      );
                                    }),
                                  ),
                                );
                              });
                        },
                        title: Text('${data[raw]}'),
                        trailing: Icon(Icons.arrow_forward_ios_rounded),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Company Name',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      SizedBox(
                        height: 20,
                      ),
                      FiledArea('Enter Company name', controller: Company,
                          validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please fill data';
                        }
                        return null;
                      }, keyboardType: TextInputType.text),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Start & End Time',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) {
                                return Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.35,
                                    decoration: new BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: new BorderRadius.only(
                                        topLeft: const Radius.circular(25.0),
                                        topRight: const Radius.circular(25.0),
                                      ),
                                    ),
                                    child: CupertinoDatePicker(
                                      initialDateTime: dateTime,
                                      mode: CupertinoDatePickerMode.date,
                                      onDateTimeChanged: (newTime) {
                                        setState(() {
                                          dateTime = newTime;
                                        });
                                      },
                                    ));
                              });
                        },
                        title: Text(
                            '${dateTime.day}-${dateTime.month}-${dateTime.year}'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) {
                                return Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.35,
                                    decoration: new BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: new BorderRadius.only(
                                        topLeft: const Radius.circular(25.0),
                                        topRight: const Radius.circular(25.0),
                                      ),
                                    ),
                                    child: CupertinoDatePicker(
                                      initialDateTime: dateTime1,
                                      mode: CupertinoDatePickerMode.date,
                                      onDateTimeChanged: (newTime) {
                                        setState(() {
                                          dateTime1 = newTime;
                                        });
                                      },
                                    ));
                              });
                        },
                        title: Text(
                            '${dateTime1.day}-${dateTime1.month}-${dateTime1.year}'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('MY Designation',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      SizedBox(
                        height: 20,
                      ),
                      FiledArea('Enter Designation', controller: profile,
                          validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please fill data';
                        }
                        return null;
                      }, keyboardType: TextInputType.text),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Rols & Responsibility',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      SizedBox(
                        height: 10,
                      ),
                      FiledArea('Describe', controller: roll_res,
                          validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please fill data';
                        }
                        return null;
                      }, keyboardType: TextInputType.text),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(18.0),
        child: BoxButton(
          isloading: isLoading,
          text: 'post',
          onTap: () async {
            Get.offAll(Add_skill());
            if (formKey.currentState!.validate()) {
              setState(() {
                isLoading = true;
              });
              Map body = {
                'user_id': loggedinUser!.data!.id,
                'total_experiance': data[raw].toString(),
                'Company_name': Company.text,
                'My_desination': profile.text,
                'roles_responsibility': roll_res.text,
                'work_start_date': dateTime.toString(),
                'work_end_date': dateTime1.toString()
              };
              log(body.toString());
              var res = await http.post(Uri.parse(baseurl + "work_experiance"),
                  body: body);
              var resData = json.decode(res.body);

              if (res.statusCode == 200 &&
                  resData["result"].toString() == true.toString()) {
                Utils().sendMassage('${resData['msg']}');
                setState(() {
                  isLoading = false;
                });

                Get.offAll(Add_skill(),
                    transition: Transition.rightToLeftWithFade);
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
