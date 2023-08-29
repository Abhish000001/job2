import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../constants.dart';
import '../../../job_seeker/model/job_model.dart';

import 'detail_item.dart';
class DetailContentR extends StatelessWidget {
  const DetailContentR({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Job data;

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
                      data.imgUrl,
                      height: 50,
                      width: 50,
                    ),
                    SizedBox(height: kSpacingUnit * 2),
                    Text(
                      data.companyName,
                      style: kTitleTextStyle,
                    ),
                    SizedBox(height: kSpacingUnit),
                    Row(
                      children: [
                        Icon(Icons.maps_home_work),
                        SizedBox(width: 20,),
                        Text(
                          data.location,
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
                      'AnnualCTC '+data.ctc,
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
              if (data.responsibilities != null && data.responsibilities.length > 0)
                ...data.responsibilities
                    .map((responsibility) => DetailItemR(data: responsibility))
                    .toList(),
              SizedBox(height: kSpacingUnit),
              Text(
                'Qualifications',
                style: kSubTitleTextStyle,
              ),
              SizedBox(height: kSpacingUnit * 2),
              if (data.qualifications != null && data.qualifications.length > 0)
                ...data.qualifications
                    .map((qualification) => DetailItemR(data: qualification))
                    .toList(),
              SizedBox(height: kSpacingUnit * 15),
              
            ],
          ),
        ),
      ),
    );
  }
}