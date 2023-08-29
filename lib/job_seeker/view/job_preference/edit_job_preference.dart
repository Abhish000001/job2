import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart'as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../components/box_btn.dart';
import '../../../constants.dart';
import '../../../utils/utils.dart';
import '../profile_view/edit_profile_details.dart';
import '../profile_view/profile_screen.dart';
import '../profile_view/sub_profile_screen/city_location.dart';
import 'job_preferance.dart';
var uren;
final userdata = uren['data'];
TextEditingController functionArea1 = TextEditingController();
TextEditingController city_name1 = TextEditingController();
var isLogedIn;
class Edit_jobpreferance extends StatefulWidget {
  const Edit_jobpreferance({super.key});

  @override
  State<Edit_jobpreferance> createState() => _Edit_jobpreferanceState();
}

class _Edit_jobpreferanceState extends State<Edit_jobpreferance> {
  List<String> data = <String>[
    'PartTime',
    'Full Time',
    'Internship',
  ];

  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
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
  void initState() {
    // TODO: implement initState
    getdata();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key:formKey ,
        child: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: ListView(
                children: [
                  Column(
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
                      Text('Get your recommendations',
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
                      // ListTile(
                      //   onTap: () {
                      //     //  Get.to( Location_city());
                      //   },
                      //   title: Text('${userdata["Function_area"].toString()}'),
                      //   trailing: Icon(Icons.arrow_forward_ios),
                      // ),
                      FiledArea('Enter Function Area', controller: functionArea1,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please fill data';
                            }
                            return null;
                          }, keyboardType: TextInputType.text),
                      Divider(),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Preferred City',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      SizedBox(
                        height: 20,
                      ),
                      FiledArea('Enter city ', controller: city_name1,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please fill data';
                            }
                            return null;
                          }, keyboardType: TextInputType.text),
                      // ListTile(
                      //   onTap: () {
                      //     Get.to(Location_city());
                      //   },
                      //   title: Text('${userdata["prefered_city"].toString()}'),
                      //   trailing: Icon(Icons.arrow_forward_ios),
                      // ),
                      Divider(),
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
                                    children: List<Widget>.generate(items.length,
                                        (int index) {
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
                ],
              )),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(18.0),
        child: BoxButton(
            text: 'Save',
            onTap: () async{
              if (formKey.currentState!.validate()) {
                setState(() {
                  isLoading = true;
                });
                Map body = {
                  'user_id':   isLogedIn.toString(),
                  'job_type': data[raw].toString(),
                  'Function_area': functionArea1.text,
                  'prefered_city': city_name1.text,
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

                  Get.offAll(Profile_details(),
                      transition: Transition.rightToLeftWithFade);
                  // log(res.body);
                } else {
                  Utils().sendMassage('${resData['msg']}');
                  setState(() {
                    isLoading = false;
                  });
                }
              }

              // Get.offAll(Add_name());
            }),
      ),
    );
  }
  Future getdata() async {
    var shared_preferences = await SharedPreferences.getInstance();
     isLogedIn = shared_preferences.getString('id');
    final urdata = await http
        .post(Uri.parse("https://rojgaarr.com/api/get_profiles"), body: {
      'user_id': isLogedIn,
    });
    uren = jsonDecode(urdata.body.toString());
    print(uren['data'].toString());
    print("done");
    // setState(() {
    //   city_name1=userdata["prefered_city"]     ;
    //   functionArea1=userdata["Function_area"];
    // });



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
