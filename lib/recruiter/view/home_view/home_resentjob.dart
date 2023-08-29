import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../job_seeker/model/job_data.dart';
import '../../widget/recruiter_jobcard.dart';

class HomeRecentJobsR extends StatelessWidget {
  const HomeRecentJobsR({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: recentJobs
            .asMap()
            .entries
            .map(
              (item) => Container(
                margin: EdgeInsets.symmetric(horizontal: kSpacingUnit * 3).copyWith(
                  top: item.key == 0 ? kSpacingUnit * 2 : 0,
                  bottom: kSpacingUnit * 2,
                ),
                child: JobCard(data: item.value),
              ),
            )
            .toList(),
      ),
    );
  }
}