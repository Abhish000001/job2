import 'package:flutter/material.dart';

import '../../../../components/box_btn.dart';

class Rolls extends StatefulWidget {
  const Rolls({super.key});

  @override
  State<Rolls> createState() => _RollsState();
}

class _RollsState extends State<Rolls> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: 
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: ListView(children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              SizedBox(height: 40,),
              Text('My Roll & Responsiblity',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),

             Container(
               child: TextField(
                  decoration: InputDecoration(hintText: "Explain",),
                  scrollPadding: EdgeInsets.all(20.0),
                  keyboardType: TextInputType.multiline,
                  maxLines: 25,
                  autofocus: true,),
             ),
            
              
             

                  



              
               
              
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