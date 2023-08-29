import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job2/components/box_btn.dart';
import '../../../constants.dart';
import '../../../main.dart';
import '../../../utils/utils.dart';
import '../bottom_nav_view.dart/bottom_navebar.dart';
import '../work_experiance/add_work_experiance.dart';

class My_bio extends StatefulWidget {
  const My_bio({super.key});

  @override
  State<My_bio> createState() => _My_bioState();
}

class _My_bioState extends State<My_bio> {
  TextEditingController about = TextEditingController();
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
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
                      Text('My Bio',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                      Container(
                        child: TextFormField(
                          controller: about,
                          validator: (value) {
                            if(value==null||value.isEmpty){
                              return 'please fill data';
                            }
                             return null;
                          },
                          
                          decoration: InputDecoration(
                            hintText: "Insert About you",
                          ),
                          scrollPadding: EdgeInsets.all(20.0),
                          keyboardType: TextInputType.multiline,
                          maxLines: 25,
                          autofocus: true,
                        ),
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
                'about_you': about.text,
              };
              log(body.toString());
              var res = await http.post(Uri.parse(baseurl + "my_bio"),
                  body: body);
              var resData = json.decode(res.body);

              if (res.statusCode == 200 &&
                  resData["result"].toString() == true.toString()) {
                Utils().sendMassage('${resData['msg']}');
                setState(() {
                  isLoading = false;
                });

                Get.offAll(Work_Experiance(),
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
