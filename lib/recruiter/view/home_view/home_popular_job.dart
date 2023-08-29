import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../constants.dart';
import '../../../job_seeker/model/job_data.dart';
import '../../widget/recruiter_jobcard.dart';


class HomePopularJobsR extends StatefulWidget {
  const HomePopularJobsR({super.key});

  @override
  _HomePopularJobsRState createState() => _HomePopularJobsRState();
}

class _HomePopularJobsRState extends State<HomePopularJobsR> {
  int _cardIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 235,
      child: CarouselSlider.builder(
        options: CarouselOptions(
          height: 190,
          autoPlay: true,
          aspectRatio: 16 / 9,
          viewportFraction: 0.9,
          initialPage: _cardIndex,
          enlargeCenterPage: true,
          onPageChanged: (index, reason) {
            setState(() {
              _cardIndex = index;
            });
          },
        ),
        itemCount: popularJobs.length,
       itemBuilder: (context, index, realIndex) {
         return Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: kSpacingUnit),
          child: JobCard(data: popularJobs[index]),
        );
       },
      ),
    );
  }
}