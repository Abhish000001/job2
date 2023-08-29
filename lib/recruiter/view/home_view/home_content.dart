import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'home_popular_job.dart';
import 'home_resentjob.dart';
import 'package:shared_preferences/shared_preferences.dart';
List jblist = [];
var uren;
final userdata = uren['data'];
class HomeContentR extends StatelessWidget {
  const HomeContentR({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
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
              HomePopularJobsR(),
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
              //HomeRecentJobsR(),
              Center(
                child: Container(
                   height: 10000,
                  width: 350,
                  child: FutureBuilder(
                    future: getdata(),
                    builder: (context, snapshot) {
                      return ListView.builder(physics: ScrollPhysics(),
                        itemCount: jblist.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
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
                                          userdata
                                              .elementAt(index)["user_id"]
                                              .toString(),
                                          style: kCardTitleTextStyle,
                                        ),

                                      ],
                                    ),

                                    SizedBox(height: 20),
                                    Text(
                                      userdata
                                          .elementAt(index)["first_name"]
                                          .toString() +" "+ userdata
                                          .elementAt(index)["last_name"]
                                          .toString(),
                                      style: kSubTitleTextStyle,
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Text(
                                            userdata
                                                .elementAt(index)["skill"]
                                                .toString() ,
                                            style: TextStyle(color: Colors.grey)),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.account_tree_outlined,
                                          size: 20,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          userdata
                                              .elementAt(index)["Experiance_level"]
                                              .toString(),
                                          style: kCaptionTextStyle,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.school,
                                          size: 20,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          userdata
                                              .elementAt(index)["Education_level"]
                                              .toString(),
                                          style: kCaptionTextStyle,
                                        ),
                                      ],
                                    )
                                  ],
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
      ),
    );
  }
  getdata() async {
    var shared_preferences = await SharedPreferences.getInstance();
    var isLogedIn = shared_preferences.getString('id');
    print("nkn");
    final urdata = await http
        .get(Uri.parse("https://rojgaarr.com/api/get_user_list")
        );
    print("nbjbnhik");
     uren= jsonDecode(urdata.body.toString());
    // uren =jsonDecode(urdata.body.toString());
    print(uren);
    print("hkjlhkl");
    jblist = uren['data'];
    print(jblist.length);
  }
}