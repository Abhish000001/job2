import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants.dart';

class Job_Status extends StatefulWidget {
  const Job_Status({super.key});

  @override
  State<Job_Status> createState() => _Job_StatusState();
}

class _Job_StatusState extends State<Job_Status> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       automaticallyImplyLeading: false,
       leading: IconButton(onPressed: (){
        Get.back();
       }, icon: Icon(Icons.arrow_back_ios,
       color: Colors.black87,)),
        backgroundColor: kSilverColor,
      elevation: 0,
        centerTitle: true,
        title: 
      Text('My Online Resume',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,
              color: Colors.black87)),),
      body: SafeArea(
        child: 
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: ListView(children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              SizedBox(height: 40,),
               Text('Renu Jaiwal',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              
           ],),
            ],)
          ),
        ),
       
      
    );
  }
}