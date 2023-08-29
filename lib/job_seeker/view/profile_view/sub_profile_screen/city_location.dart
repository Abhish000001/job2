import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job2/components/search_view.dart';

import '../../../../components/box_btn.dart';
import '../../../../constants.dart';

class Location_city extends StatefulWidget {
  const Location_city({super.key});

  @override
  State<Location_city> createState() => _Location_cityState();
}

class _Location_cityState extends State<Location_city> {
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
      Text('Select Location',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
              color: Colors.black87)),),
      body: SafeArea(
        child: 
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: ListView(children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
             SearchForm(),
             
              
             

                  



              
               
              
            ],),
            ],)
          ),
        ),
         bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(18.0),
          child: BoxButton(text: 'Save', onTap: (){
            
          }),
        ),
       
      
    );
  }
}