import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants.dart';
import '../../model/job_model.dart';
import 'detail_content.dart';
import 'detail_footer.dart';
import 'detail_header.dart';

var jobde;
var savedjo;
var jobdesc = jobde["data"][0];

// var jobdesc=jobde["data"];
class DetailScreen extends StatefulWidget {
  final Job? data;
  final jobid;

  const DetailScreen({Key? key, this.data, this.jobid}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kSilverColor,
      appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text("Job Details")),
      body: SingleChildScrollView(
        child: SafeArea(
            child: FutureBuilder(
          future: Jobdes(),
          builder: (context, snapshot) {
            return Padding(
              padding: const EdgeInsets.only(
                  right: 20.0, left: 20, bottom: 20, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        maxRadius: 35,
                        child: Image.network(
                            "https://rojgaarr.com/assets/images/company/${jobde["data"][0]["image"].toString()}",
                            fit: BoxFit.fill,
                            scale: 1),
                      ),
                      SizedBox(
                        width: w / 30,
                      ),
                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            jobde["data"][0]["title"].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          SizedBox(
                            height: h / 100,
                          ),
                          Text(
                            jobde["data"][0]["company_name"].toString(),
                            style: TextStyle(
                                 fontSize: 15),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: h / 30,
                  ),
                  Row(children: [
                    Column(children: [
                      Icon(Icons.location_on_outlined),
                      Icon(Icons.category),
                      Icon(Icons.business_center_outlined),
                      Icon(Icons.money),

                    ]),
                    SizedBox(width: w/50),
                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Location:",
                          style: TextStyle(
                              fontSize: 15),
                        ),
                        SizedBox(
                          height: h / 100,
                        ),
                        Text(
                          "Category:",
                          style: TextStyle(
                              fontSize: 15),
                        ),
                        SizedBox(
                          height: h / 100,
                        ),
                        Text(
                          "Job Type: ",
                          style: TextStyle(
                              fontSize: 15),
                        ),
                        SizedBox(
                          height: h / 150,
                        ),
                        Text(
                          "Salary:",
                          style: TextStyle(
                              fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(width: w/50),
                    Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                      Text(
                        jobde["data"][0]["city"].toString(),
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: h / 100,
                      ),
                      Text(
                        jobde["data"][0]["job_category"].toString(),
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: h / 100,
                      ),
                      Text(
                        jobde["data"][0]["job_type"].toString(),
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: h / 100,
                      ),
                      Text(
                        jobde["data"][0]["sallary"].toString(),
                        style: TextStyle(fontSize: 15),
                      )
                    ],),
                  ]),
                  SizedBox(
                    height: h / 80,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Text("***",
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    Text( jobde["data"][0]["hiring_type"].toString(),
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    SizedBox(width: w/50),
                    Text( jobde["data"][0]["title"].toString(),
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    Text("***",
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  ],),
                  SizedBox(
                    height: h / 80,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("***",
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      Text( "Job location",
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      SizedBox(width: w/50),
                      Text( jobde["data"][0]["city"].toString(),
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      Text("***",
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    ],),
                  SizedBox(
                    height: h / 80,
                  ),
                  Text(jobde["data"][0]["discription"].toString()),
                  SizedBox(
                    height: h / 50,
                  ),
                  Row(
                    children: [
                      Text("Job Type: "),
                      SizedBox(width: w/100),
                      Text(jobde["data"][0]["job_type"].toString()),
                    ],
                  ),
                  SizedBox(
                    height: h / 80,
                  ),
                  Row(
                    children: [
                      Text("Salary: "),
                      SizedBox(width: w/100),
                      Text(jobde["data"][0]["sallary"].toString()+" "+jobde["data"][0]["salary_type"].toString()),
                    ],
                  ),
                  SizedBox(
                    height: h / 50,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20,left: 15,bottom: 20),
                    decoration: BoxDecoration(border: Border.all(color: Colors.black),borderRadius: BorderRadius.circular(15)),
                    width: w/1,
                    child: 
                    Row(
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Text("Job Summary:",style: TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: h / 100,
                              ),
                              Text("Job Posted:"),
                              SizedBox(
                                height: h / 100,
                              ),
                              Text("Expiration:"),
                              SizedBox(
                                height: h / 100,
                              ),
                              Text("Vacancy:"),
                              SizedBox(
                                height: h / 100,
                              ),
                              Text("Experiences:"),
                              SizedBox(
                                height: h / 100,
                              ),
                              Text("Gender:"),

                        ]),
                        SizedBox(width: w/100),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(" "),
                              SizedBox(
                                height: h / 100,
                              ),
                              Text(jobde["data"][0]["created_date"].toString()),
                              SizedBox(
                                height: h / 100,
                              ),
                              Text(jobde["data"][0]["deadline"].toString()),
                              SizedBox(
                                height: h / 100,
                              ),
                              Text(jobde["data"][0]["no_candidate"].toString()),
                              SizedBox(
                                height: h / 100,
                              ),
                              Text(jobde["data"][0]["experience"].toString()),
                              SizedBox(
                                height: h / 100,
                              ),
                              Text(jobde["data"][0]["gender"].toString()),

                            ]),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: h / 30,
                  ),
                  Row(children: [

                    IconButton(onPressed: (){
                      savedjob();
                    }, icon: Icon(CupertinoIcons.heart)),
                    Text("Saved jobs"),
                    SizedBox(width: w/4),
                    Container(
                      width: w/3.5,
                        child: ElevatedButton(
                            style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.greenAccent)),
                            onPressed: (){}, child: Text("apply")))

                  ],)
                  


                  






                ],
              ),
            );
          },
        )),
      ),
    );
  }

  Jobdes() async {
    print(widget.jobid);

    final jobd = await http
        .post(Uri.parse("https://rojgaarr.com/api/job_description"), body: {
      'job_id': widget.jobid.toString(),
    });
    jobde = jsonDecode(jobd.body.toString());
    // print(jobde["data"][0]["title"].toString());
  }

  Future<void> savedjob() async {
    var shared_preferences = await SharedPreferences.getInstance();
    var isLogedIn = shared_preferences.getString('id');
    var st=jobde["data"][0]["status"].toString();
    print(st);
    final jobd = await http
        .post(Uri.parse("https://rojgaarr.com/api/save_job"), body: {
      'job_id': widget.jobid.toString(),
      "user_id":isLogedIn.toString(),
      "status":st.toString(),
    });
    jobde = jsonDecode(jobd.body.toString());
    print(jobde);
  }
}
