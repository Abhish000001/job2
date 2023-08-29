import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../constants.dart';
import '../../model/job_model.dart';
import 'detail_item.dart';
var jobde;
var savedjo;
class DetailContent extends StatefulWidget {
  const DetailContent({
    Key? key,
     this.data, this.jobid,
  }) : super(key: key);

  final Job? data;
  final jobid;

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  @override
  void initState() {
    // TODO: implement initState
    Jobdes();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: kSpacingUnit * 4,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
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
              Center(
                child: Column(
                  children: [
                    SvgPicture.asset(
                      // data.imgUrl
                      Image.network("/assets/images/company/New_Project_(2)1.png") as String,
                      height: 50,
                      width: 50,
                    ),
                    SizedBox(height: kSpacingUnit * 2),
                    Text(
                      // data.companyName
                      jobde["data"]["company_name"]
                      ,
                      style: kTitleTextStyle,
                    ),
                    SizedBox(height: kSpacingUnit),
                    Row(
                      children: [
                        Icon(Icons.maps_home_work),
                        SizedBox(width: 20,),
                        Text(
                          jobde["data"]["state"],
                          style: kCaptionTextStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
               SizedBox(height: kSpacingUnit * 1),
              Text(
                'Selery',
                style: kSubTitleTextStyle,
              ),
               SizedBox(height: kSpacingUnit * 1),
              Row(
                  children: [
                    Icon(Icons.money,size: 20,
                    ),
                    SizedBox(width: 10,),
                    Text(
                      'AnnualCTC '+jobde["data"]["sallary"],
                      style: kCaptionTextStyle,
                    ),
                  ],
                ),
                 SizedBox(height: kSpacingUnit * 2),
                Text(
                'Number Of Openings',
                style: kSubTitleTextStyle,
              ),
              SizedBox(height: kSpacingUnit * 2),

              Text(
                      '4',
                      style: kCaptionTextStyle,
                    ),
                    SizedBox(height: kSpacingUnit * 2),

                  Text(
                'Skills required',
                style: kSubTitleTextStyle,
              ),
              SizedBox(height: kSpacingUnit * 2),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [

                    Text(
                      'Management',
                      style: kCaptionTextStyle,
                    ),
                    Text(
                      'Problem solver',
                      style: kCaptionTextStyle,
                    ),
                    Text(
                      'Team lead',
                      style: kCaptionTextStyle,
                    ),
                  ],
                ),
              SizedBox(height: kSpacingUnit * 5),
              Text(
                'Responsibilities',
                style: kSubTitleTextStyle,
              ),
              SizedBox(height: kSpacingUnit * 2),
              // if (widget.data.responsibilities != null && widget.data.responsibilities.length > 0)
              //   ...widget.data.responsibilities
              //       .map((responsibility) => DetailItem(data: responsibility))
              //       .toList(),
              // SizedBox(height: kSpacingUnit),
              Text(
                'Qualifications',
                style: kSubTitleTextStyle,
              ),
              SizedBox(height: kSpacingUnit * 2),
              // if (widget.data.qualifications != null && widget.data.qualifications.length > 0)
              //   ...widget.data.qualifications
              //       .map((qualification) => DetailItem(data: qualification))
              //       .toList(),
              // SizedBox(height: kSpacingUnit * 15),

            ],
          ),
        ),
      ),
    );
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