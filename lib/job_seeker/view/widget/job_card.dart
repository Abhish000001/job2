import 'dart:convert';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../constants.dart';
import '../../model/job_model.dart';
import 'package:http/http.dart'as http;
import '../details_view/detail_screen.dart';
var uren;
final userdata = uren['data'];
class JobCard extends StatefulWidget {
  final Job data;

  const JobCard({Key? key, required this.data}) : super(key: key);

  @override
  State<JobCard> createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
  @override
  void initState() {
    // TODO: implement initState
    getdata();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [kCardShadow],
      ),
      child: OpenContainer(
        transitionType: ContainerTransitionType.fade,
        transitionDuration: const Duration(milliseconds: 500),
        openColor: kSilverColor,
        openElevation: 0,
        openBuilder: (context, action) {
          return DetailScreen(data: widget.data);
        },
        closedColor: Colors.transparent,
        closedElevation: 0,
        closedBuilder: (context, action) {
          return Container(
            height: 190,
            padding: EdgeInsets.all(kSpacingUnit * 2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadiusDirectional.circular(kSpacingUnit * 3),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      widget.data.imgUrl,
                      height: 30,
                      width: 30,
                    ),
                    SizedBox(width: kSpacingUnit),
                    Text(
                      widget.data.companyName,
                      style: kCardTitleTextStyle,
                    ),
                    const Spacer(),
                    SvgPicture.asset(
                      'assets/icons/heart_icon.svg',
                      height: 20,
                      width: 20,
                    ),
                  ],
                ),

                const Spacer(),
                Text(
                  widget.data.position,
                  style: kSubTitleTextStyle,
                ),
                const Spacer(),
                Text(
                      widget.data.post,
                      style:  kCardTitleTextStyle,
                    ),
                SizedBox(height: kSpacingUnit * 0.5),
                Row(
                  children: [
                    Icon(Icons.location_history,size: 20,
                    color: Colors.grey,),
                     SizedBox(width: 10,),
                    Text(
                      widget.data.location,
                      style: kCaptionTextStyle,
                    ),
                  ],
                ),
                 SizedBox(height: kSpacingUnit * 0.5),

                Row(
                  children: [
                    Icon(Icons.money,size: 20,
                    color: Colors.grey,),
                    SizedBox(width: 10,),
                    Text(
                      widget.data.ctc,
                      style: kCaptionTextStyle,
                    ),
                  ],
                ),

              ],
            ),
          );
        },
      ),
    );
  }

  Future getdata() async {
    var shared_preferences = await SharedPreferences.getInstance();
    var isLogedIn = shared_preferences.getString('id');
    final urdata = await http
        .post(Uri.parse("https://rojgaarr.com/api/get_job_list"), body: {
      'user_id': isLogedIn,
    });

    uren = jsonDecode(urdata.body.toString());
    print(uren['data'].toString());
  }
}