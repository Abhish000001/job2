import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job2/components/Add_tag.dart';
import 'package:job2/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../components/box_btn.dart';
import '../../../utils/utils.dart';
import '../../model/user_model.dart';
import 'package:http/http.dart'as http;
import '../bottom_nav_view.dart/bottom_navebar.dart';
bool isLoading = false;
class Add_skill extends StatefulWidget {
  const Add_skill({super.key});

  @override
  State<Add_skill> createState() => _Add_skillState();
}

class _Add_skillState extends State<Add_skill> {
  List addskill=[];
  TextEditingController nameController = TextEditingController();

  void addItemToList(){
    setState(() {
     addskill.add(nameController.text);
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: 
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 SizedBox(height: 40,),
              Text('My Skill',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
             SizedBox(height: 30,),

             Container(
               
                child: Row(children: [
                Icon(Icons.add,color: primary,),
                TextButton(onPressed: (){
                 Get.dialog(
    AlertDialog(
      title: const Text('Add Skill'),
      content: TextField(
       controller: nameController,
        decoration: InputDecoration(hintText: 'enter skill tag'),),
      actions: [
        TextButton(
          child: const Text("Cancel"),
          onPressed: () => Get.back(),
        ),
        TextButton(
          child: const Text("Save"),
          onPressed: () => setState(() {
            Get.back();
            addItemToList();
          })
        ),
      ],
    ));
                }, child: Text('Add Skill',
                style: TextStyle(color: primary),))
              ],),),

             SizedBox(height: 30,),

             Divider(),

             Expanded(
  child: ListView.builder (
    itemCount: addskill.length,
    itemBuilder: (BuildContext context, int index) {
      return  Wrap(
        direction: Axis.horizontal,
        children: [
        SearchTag(tag: addskill[index].toString()),
        
      ],);
    }
  )
)
             

            //  
],),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(18.0),
          child: BoxButton(text: 'Save', onTap: ()async{
            var shared_preferences = await SharedPreferences.getInstance();
            var isLogedIn = shared_preferences.getString('id');
            Map body = {
              'user_id': isLogedIn.toString(),
              "skill":nameController.text.toString(),            };
            var res = await http.post(Uri.parse(baseurl + "add_skill"),
                body: body);
            var resData = json.decode(res.body);
    if (res.statusCode == 200 &&
    resData["result"].toString() == true.toString()) {
      Utils().sendMassage('${resData['msg']}');
      setState(() {
        isLoading = false;
      });
      Get.offAll(DashboardPage(), transition: Transition.rightToLeftWithFade);
    }
    else {
      Utils().sendMassage('${resData['msg']}');
      setState(() {
        isLoading = false;
      });
    }
          }),
        ),
       
      
    );
  }
}