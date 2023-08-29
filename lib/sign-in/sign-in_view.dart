import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:job2/components/box_btn.dart';
import 'package:country_picker/country_picker.dart';
import '../constants.dart';
import '../job_seeker/model/user_model.dart';
import '../job_seeker/view/verification/otp-verification.dart';
import '../main.dart';
import '../otp_verification/otp_verification_view.dart';
import 'package:http/http.dart' as http;
import '../utils/utils.dart';

class MyPhone extends StatefulWidget {
  final String user_type;

  const MyPhone({Key? key, required this.user_type}) : super(key: key);

  @override
  State<MyPhone> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {
  TextEditingController numberController = TextEditingController();
  String countryCode = '';
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  var userstatus;


  @override
  void initState() {
    // TODO: implement initState
    // countryController.text = "+91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZICGbHGMgoj85tWivwsJNkp0s-C7YRVwwmQ&usqp=CAU'),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "We need to register your phone without getting started!",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Form(
                key: formKey,
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 50,
                        child: TextButton(
                            style: TextButton.styleFrom(
                              fixedSize: const Size(10, 50),
                            ),
                            onPressed: () {
                              showCountryPicker(
                                context: context,
                                showPhoneCode: true,
                                favorite: ['IN'],
                                // optional. Shows phone code before the country name.
                                onSelect: (Country country) {
                                  setState(() {
                                    countryCode = country.phoneCode.toString();
                                  });

                                  print(
                                      'Select country: ${country.displayName}');
                                  countryListTheme:
                                  CountryListThemeData(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10)),
                                      inputDecoration: InputDecoration(
                                        hintText: 'Start typing to sear',
                                        labelText: 'Search ',
                                      ));
                                },
                              );
                            },
                            child: Text(
                              '+' + countryCode,
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                            )),

                        // child: TextField(
                        //   controller: countryController,
                        //   keyboardType: TextInputType.number,
                        //   decoration: InputDecoration(
                        //     border: InputBorder.none,
                        //   ),
                        // ),
                      ),
                      Text(
                        "|",
                        style: TextStyle(fontSize: 33, color: Colors.grey),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: TextFormField(
                        inputFormatters: [LengthLimitingTextInputFormatter(10)],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Mobile Number';
                          }
                          return null;
                        },
                        controller: numberController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Phone",
                        ),
                      ))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              BoxButton(
                  isloading: isLoading,
                  text: 'Generate otp',
                  onTap: () async {
                    var usertype = widget.user_type.toString();
                    print(usertype);
                    // Get.to(MyVerify());
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      Map body = {
                        'mobile': '+' + countryCode + numberController.text,
                      };
                      log(body.toString());
                      var res = await http.post(Uri.parse(baseurl + usertype),
                          body: body);
                      var resData = json.decode(res.body);
                      if(
                      usertype=="user_signup"
                      ){
                        userstatus = resData["user_status"].toString();
                        print(userstatus);
                        print(resData["data"]["id"].toString());
                      }
                      else{
                         userstatus = resData["recruiter_status"].toString();
                        print(userstatus);
                        print(resData["data"]["id"].toString());
                      }


                      if (res.statusCode == 200 &&
                          resData["result"].toString() == true.toString()) {
                        loggedinUser = UserModel.fromJson(resData);
                        Utils().sendMassage('Please verify otp');
                        setState(() {
                          isLoading = false;
                        });
                        if(usertype=="user_signup"){Get.to(
                            MyVerify(
                              userstatus: userstatus,
                            ),
                            transition: Transition.rightToLeft,
                            arguments: [
                              resData["data"],]);}
                        else{
                          Get.to(
                              MyVerifyR(
                                userstatus: userstatus,
                              ),
                              transition: Transition.rightToLeft,
                              arguments: [resData["data"],"recruiter"]);
                        }

                        log(res.body);
                      } else {
                        Utils().sendMassage('${resData['msg']}');
                        setState(() {
                          isLoading = false;
                        });
                      }
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
