import 'dart:convert';
import 'dart:developer';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../components/box_btn.dart';
import '../../../constants.dart';
import '../../../recruiter/model/user_model.dart';
import '../../../utils/utils.dart';
import '../verification/otp-verification.dart';
User_modelR ? userid;
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}
class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  TextEditingController numberController = TextEditingController();
  bool isLoading=false;
   String countryCode = '' ;
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
                  child:Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZICGbHGMgoj85tWivwsJNkp0s-C7YRVwwmQ&usqp=CAU') ,
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
                  style: TextButton.styleFrom( fixedSize: const Size(10, 50),),
                  onPressed: (){
                                  showCountryPicker(

                context: context,
                showPhoneCode: true,
                favorite: ['IN'],
                 // optional. Shows phone code before the country name.
                onSelect: (Country country) {
                  setState(() {
                    countryCode=country.phoneCode.toString();

                  });


                  print('Select country: ${country.displayName}'


                  );
                  countryListTheme: CountryListThemeData(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10)
                      ),
                      inputDecoration: InputDecoration(
                        hintText: 'Start typing to sear' ,
                        labelText: 'Search ' ,
                      ));
                },
              );
                                }, child: Text('+'+countryCode, style: TextStyle(
                                      color: Colors.black54,
                                    ),)),


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
              text: 'Generate otp', onTap: ()async{
              // Get.to(MyVerify());
              if(formKey.currentState!.validate()){
                setState(() {
               isLoading=true;
              });
                Map body = {
                          'mobile':countryCode+numberController.text,

                         };
                           log(body.toString());
                         var res = await http.post(
                            Uri.parse(
                                baseurl+"user_recruiter_signup"),
                            body: body);
                              var resData = json.decode(res.body);


                            if(res.statusCode == 200 &&
                    resData["result"].toString() == true.toString()){
                      userid=User_modelR .fromJson(resData);
                       Utils().sendMassage('${resData['msg']}');
                    setState(() {
                      isLoading=false;
                        });

                              Get.to(MyVerifyR (userstatus: '',),transition: Transition.rightToLeftWithFade,arguments: [
                                resData["data"]
                               ]); log(res.body);

                            }else{
                               Utils().sendMassage('${resData['msg']}');
                    setState(() {
                      isLoading=false;
                        });
                              }
}
              }),


            ],
          ),
        ),
      ),
    );
  }
}