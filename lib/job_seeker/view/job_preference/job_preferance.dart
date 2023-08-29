import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:animate_do/src/';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job2/components/box_btn.dart';
import 'package:http/http.dart' as http;
import 'package:job2/main.dart';
import '../../../constants.dart';
import '../../../recruiter/view/recruiter_profile/recruiter_profile_view.dart';
import '../../../utils/utils.dart';
import '../my_profile/my_profile.dart';
import '../profile_view/sub_profile_screen/city_location.dart';

TextEditingController functionArea = TextEditingController();
TextEditingController city_name = TextEditingController();
class Job_preference extends StatefulWidget {
  const Job_preference({super.key});

  @override
  State<Job_preference> createState() => _Job_preferenceState();
}

class _Job_preferenceState extends State<Job_preference> {

  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  List<String> data = <String>[
    'PartTime',
    'Full Time',
    'Internship',
  ];
  int raw = 0;
  double _kItemExtent = 32.0;

  final items = [
    'Rs 1LPA-2LPA',
    'Rs 2LPA-5LPA',
    'Rs 5LPA-10LPA',
    'Rs 10LPA-15LPA',
    'Rs 15LPA-20LPA',
    'Rs 20LPA-25LPA+',
  ];
  int index = 0;
  @override

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
                      Text('Job Preference',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 10,
                      ),
                      Text('What Type of Job are you looking for?',
                          style: TextStyle(color: Colors.grey)),
                      SizedBox(
                        height: 40,
                      ),
                      Text('Job Type',
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
                        title: Text(data[raw]),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      Divider(),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Functional Area',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      SizedBox(
                        height: 20,
                      ),
                      FiledArea('Enter Function Area', controller: functionArea,
                          validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please fill data';
                        }
                        return null;
                      }, keyboardType: TextInputType.text),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Preferred City',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FiledArea('Enter city ', controller: city_name,
                          validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please fill data';
                        }
                        return null;
                      }, keyboardType: TextInputType.text),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Expected Salary',
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
                                        index = selectedItem;
                                      });
                                    },
                                    children: List<Widget>.generate(
                                        items.length, (int index) {
                                      return Center(
                                        child: Text(
                                          items[index],
                                        ),
                                      );
                                    }),
                                  ),
                                );
                              });
                        },
                        title: Text('${items[index]}'),
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
            //  BoxButton(text: 'Save', onTap: (){
            //   Get.offAll(Add_name(),transition: Transition.rightToLeftWithFade);
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
                'job_type': data[raw].toString(),
                'Function_area': functionArea.text,
                'prefered_city': city_name.text,
                'Expected_selery': items[index].toString(),
              };
              log(body.toString());
              var res = await http.post(Uri.parse(baseurl + "job_preference"),
                  body: body);
              var resData = json.decode(res.body);

              if (res.statusCode == 200 &&
                  resData["result"].toString() == true.toString()) {
                Utils().sendMassage('${resData['msg']}');
                setState(() {
                  isLoading = false;
                });

                Get.offAll(Add_name(),
                    transition: Transition.rightToLeftWithFade);
                // log(res.body);
              } else {
                Utils().sendMassage('${resData['msg']}');
                setState(() {
                  isLoading = false;
                });
              }
            }

            //Get.offAll(Add_name(),transition: Transition.rightToLeftWithFade);
          },
        ),
      ),

    );
  }

}


Widget FiledArea(String title,
    {required controller, required validator, required keyboardType}) {
  return TextFormField(
    controller: controller,
    validator: validator,
    keyboardType: TextInputType.name,
    decoration: InputDecoration(hintText: title),
  );


}
