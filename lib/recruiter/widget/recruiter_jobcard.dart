import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import '../../../constants.dart';
import '../../job_seeker/model/job_model.dart';
import '../view/details_view/detail_screen.dart';

class JobCard extends StatelessWidget {
  final Job data;

  const JobCard({Key? key, required this.data}) : super(key: key);

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
          return DetailScreenR(data: data);
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
                      data.imgUrl,
                      height: 30,
                      width: 30,
                    ),
                    SizedBox(width: kSpacingUnit),
                    Text(
                      data.companyName,
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
                  data.position,
                  style: kSubTitleTextStyle,
                ),
                const Spacer(),
                Text(
                  data.post,
                  style: kCardTitleTextStyle,
                ),
                SizedBox(height: kSpacingUnit * 0.5),
                Row(
                  children: [
                    Icon(
                      Icons.location_history,
                      size: 20,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      data.location,
                      style: kCaptionTextStyle,
                    ),
                  ],
                ),
                SizedBox(height: kSpacingUnit * 0.5),
                Row(
                  children: [
                    Icon(
                      Icons.money,
                      size: 20,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      data.ctc,
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
}
