import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_svg/flutter_svg.dart';


import '../../../constants.dart';

import '../../model/job_model.dart';
var jobde;
var savedjo;
class DetailHeader extends StatefulWidget {
  final jobid;
  final Job ?data;
  const DetailHeader({
    Key? key,
     this.data, this.jobid,
  }) : super(key: key);


  @override
  State<DetailHeader> createState() => _DetailHeaderState();
}

class _DetailHeaderState extends State<DetailHeader> {
  @override
  void initState() {
    // TODO: implement initState
    Jobdes();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(
        horizontal: kSpacingUnit * 2,
        vertical: kSpacingUnit * 3,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: SvgPicture.asset(
              'assets/icons/chevron_left_icon.svg',
              height: 30,
              width: 30,
            ),
          ),
          Text(
            jobde["data"]["company_name"],
            style: kSubTitleTextStyle.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),

          IconButton(onPressed: (){}, icon: Icon(Icons.chat_bubble_outline)),

        ],
      ),
    );
    //   Column(
    //   children: [
    //     FutureBuilder(future: Jobdes(), builder: (context, snapshot) {
    //       if(snapshot.hasData){
    //         return
    //           Padding(
    //           padding: EdgeInsets.symmetric(
    //             horizontal: kSpacingUnit * 2,
    //             vertical: kSpacingUnit * 3,
    //           ),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               GestureDetector(
    //                 onTap: () => Navigator.pop(context),
    //                 child: SvgPicture.asset(
    //                   'assets/icons/chevron_left_icon.svg',
    //                   height: 30,
    //                   width: 30,
    //                 ),
    //               ),
    //               Text(
    //                 jobde["data"]["company_name"],
    //                 style: kSubTitleTextStyle.copyWith(
    //                   fontWeight: FontWeight.w600,
    //                 ),
    //               ),
    //
    //               IconButton(onPressed: (){}, icon: Icon(Icons.chat_bubble_outline)),
    //
    //             ],
    //           ),
    //         );
    //       }
    //       else{
    //       Center(child: CircularProgressIndicator());
    //     }
    //     },),
    //   ],
    // );

  }
  Jobdes() async {
    print(widget.jobid);
    final jobd = await http
        .post(Uri.parse("https://rojgaarr.com/api/job_description"), body: {
      'job_id':widget.jobid ,
    });
    jobde=jsonDecode(jobd.body.toString());
    print(jobde["data"]);
  }
}