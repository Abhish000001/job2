import 'dart:convert';

import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../model/job_data.dart';
import '../widget/job_card.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
List jblist=[];
var uren;
final userdata = uren['data'];
class HomeRecentJobs extends StatefulWidget {
  const HomeRecentJobs({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeRecentJobs> createState() => _HomeRecentJobsState();
}

class _HomeRecentJobsState extends State<HomeRecentJobs> {
  @override
  Widget build(BuildContext context) {
    return
      FutureBuilder(future: getdata(), builder: (context, snapshot) {
      return ListView.builder(itemCount: jblist.length,itemBuilder: (context, index) {
        return Container(
          height: 100,width: 200,
          color: Colors.red,
        );
      },);
    },);
    //   Flexible(
    //   child: Column(
    //     mainAxisSize: MainAxisSize.min,
    //     children: recentJobs
    //         .asMap()
    //         .entries
    //         .map(
    //           (item) => Container(
    //             margin: EdgeInsets.symmetric(horizontal: kSpacingUnit * 3).copyWith(
    //               top: item.key == 0 ? kSpacingUnit * 2 : 0,
    //               bottom: kSpacingUnit * 2,
    //             ),
    //             child: JobCard(data: item.value),
    //           ),
    //         )
    //         .toList(),
    //   ),
    // );
  }

  Future getdata() async {
    var shared_preferences = await SharedPreferences.getInstance();
    var isLogedIn = shared_preferences.getString('id');
    final urdata = await http
        .post(Uri.parse("https://rojgaarr.com/api/get_job_list"), body: {
      'user_id': isLogedIn,
    });

    uren = jsonDecode(urdata.body.toString());
     jblist.add(uren['data']);
    print(jblist.length);
  }
}