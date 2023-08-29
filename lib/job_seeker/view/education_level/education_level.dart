import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../components/box_btn.dart';
import '../../../constants.dart';
import '../../../main.dart';
import '../../../utils/utils.dart';
import '../job_preference/job_preferance.dart';
import '../my_bio/my_bio.dart';
import '../my_profile/my_profile.dart';

class Education_level extends StatefulWidget {
  const Education_level({super.key});

  @override
  State<Education_level> createState() => _Education_levelState();
}

class _Education_levelState extends State<Education_level> {
  TextEditingController institude = TextEditingController();
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  DateTime dateTime = DateTime.now();
  DateTime dateTime1 = DateTime.now();
  final data = ['School', 'Graduate', 'Post Graduate', 'Phd.', 'Diploma'];
  int raw = 0;

 
  int index1 = 0;
  double _kItemExtent = 32.0;
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
                        height: 40,
                      ),
                      Text('Highest Education',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Fill your highest education details',
                          style: TextStyle(color: Colors.grey)),
                      SizedBox(
                        height: 40,
                      ),
                      Text('Institute Name',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      SizedBox(
                        height: 30,
                      ),
                      FiledArea('Enter city ', controller: institude,
                          validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please fill data';
                        }
                        return null;
                      }, keyboardType: TextInputType.text),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Education Level & degree',
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
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Start & End Date',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(),
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
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(18.0),
        child:
            // BoxButton(text: 'Save', onTap: (){
            //   Get.offAll(My_bio(),transition: Transition.rightToLeftWithFade);
            // }),
            BoxButton(
          isloading: isLoading,
          text: 'post',
          onTap: () async {
            if (formKey.currentState!.validate()) {
              setState(() {
                isLoading = true;
              });
              Map body = {
                'user_id': loggedinUser!.data!.id,
                'institude_name': institude.text,
                'Education_level': data[raw].toString(),
                'education_startdate': dateTime.toString(),
                'education_enddate': dateTime1.toString(),
              };
              log(body.toString());
              var res = await http.post(Uri.parse(baseurl + "job_education"),
                  body: body);
              var resData = json.decode(res.body);

              if (res.statusCode == 200 &&
                  resData["result"].toString() == true.toString()) {
                Utils().sendMassage('${resData['msg']}');
                setState(() {
                  isLoading = false;
                });

                Get.offAll(My_bio(),
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
