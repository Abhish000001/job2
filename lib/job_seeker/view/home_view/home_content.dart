import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../details_view/detail_screen.dart';
import 'home_popular_job.dart';
import 'home_resentjob.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
var jobde;
var savedjo;
List jblist = [];
var uren;
final userdata = uren['data'];
var isLogedIn;

class HomeContent extends StatelessWidget {
  const HomeContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kSilverColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(kSpacingUnit * 5),
          topRight: Radius.circular(kSpacingUnit * 5),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: kSpacingUnit * 5),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kSpacingUnit * 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Jobs',
                    style: kSubTitleTextStyle.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text('View All', style: kCardTitleTextStyle),
                ],
              ),
            ),
            HomePopularJobs(),
            SizedBox(height: kSpacingUnit * 2),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kSpacingUnit * 4),
              child: Text(
                'Recently Added',
                style: kSubTitleTextStyle.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            // HomeRecentJobs(),
            Center(
              child: Container(
                height: 1000,
                width: 350,
                child: FutureBuilder(
                  future: getdata(),
                  builder: (context, snapshot) {
                    return ListView.builder(physics: ScrollPhysics(),
                      itemCount: jblist.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: (){
                                Jobdes(index);
                              },
                              child: Material(
                                elevation: 10,
                                borderRadius: BorderRadius.circular(35),
                                child: Container(
                                  padding: EdgeInsets.only(left: 20, top: 20),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(35)),
                                  height: 200,
                                  width: 350,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          // SvgPicture.asset(
                                          //   widget.data.imgUrl,
                                          //   height: 30,
                                          //   width: 30,
                                          // ),
                                          SizedBox(width: kSpacingUnit),
                                          Text(
                                            jblist
                                                .elementAt(index)["company_name"]
                                                .toString(),
                                            style: kCardTitleTextStyle,
                                          ),

                                          // Icon(
                                          //   CupertinoIcons.suit_heart,
                                          //   color: Colors.grey,
                                          // )
                                        ],
                                      ),
                                      // Row(
                                      //   children: [
                                      //     Text("job id - "),
                                      //     Text(
                                      //         jblist.elementAt(index)["job_id"].toString(),
                                      //         style: TextStyle(color: Colors.black)),
                                      //   ],
                                      // ),
                                      SizedBox(height: 20),
                                      Text(
                                        jblist.elementAt(index)["title"].toString(),
                                        style: kSubTitleTextStyle,
                                      ),
                                      SizedBox(height: 20),
                                      Row(
                                        children: [
                                          Text("job id - ",
                                              style: TextStyle(color: Colors.grey)),
                                          Text(
                                              jblist
                                                  .elementAt(index)["job_id"]
                                                  .toString(),
                                              style: TextStyle(color: Colors.grey)),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_history,
                                            size: 20,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            jblist
                                                .elementAt(index)["city"]
                                                .toString(),
                                            style: kCaptionTextStyle,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.money,
                                            size: 20,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            jblist
                                                .elementAt(index)["sallary"]
                                                .toString(),
                                            style: kCaptionTextStyle,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  getdata() async {
    var shared_preferences = await SharedPreferences.getInstance();
    isLogedIn = shared_preferences.getString('id');
    final urdata = await http
        .post(Uri.parse("https://rojgaarr.com/api/get_job_list"), body: {
      'user_id': isLogedIn,
    });

    uren = jsonDecode(urdata.body.toString());
    jblist = uren['data'];
    print(jblist.length);
  }

  Future<void> Jobdes(int index) async {
    final savedjob= await http
        .post(Uri.parse("https://rojgaarr.com/api/view_job"), body: {
      'user_id': isLogedIn.toString(),
      'job_id': jblist
          .elementAt(index)["job_id"]
          .toString(),
    });
    savedjo=jsonDecode(savedjob.body.toString());
    print(savedjo["msg"]);
    Get.to(DetailScreen(jobid:jblist
        .elementAt(index)["job_id"]
        .toString() ,));
  }
}
