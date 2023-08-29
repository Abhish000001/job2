import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/box_btn.dart';
import '../../../constants.dart';

class Job_status extends StatefulWidget {
  const Job_status({super.key});

  @override
  State<Job_status> createState() => _Job_statusState();
}

class _Job_statusState extends State<Job_status> {
  bool _hasBeenPressed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black87,
            )),
        backgroundColor: kSilverColor,
        elevation: 0,
        centerTitle: true,
        title: Text('Job Status',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black87)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Job Searching Status',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: CupertinoButton(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.amberAccent,
                    child: Text('Actively applying'),
                    onPressed: () {}),
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.amberAccent,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: CupertinoButton(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.amberAccent,
                    child: Text('Casually Looking'),
                    onPressed: () {}),
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.amberAccent,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Availability',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 20,
              ),
              Box('Join immediately'),
              SizedBox(
                height: 20,
              ),
              Box('1 week notice period'),
              SizedBox(
                height: 20,
              ),
              Box('2 week notice period'),
              SizedBox(
                height: 20,
              ),
              Box('2 week+ notice period')
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(18.0),
        child: BoxButton(text: 'Save', onTap: () {}),
      ),
    );
  }
}

Widget Box(
  String title,
) {
  return Container(
    height: 50,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.black87)),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(title),
    ),
  );
}
