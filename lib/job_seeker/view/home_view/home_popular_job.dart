

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../constants.dart';
import '../../model/job_data.dart';
import '../widget/job_card.dart';


class HomePopularJobs extends StatefulWidget {
  const HomePopularJobs({super.key});

  @override
  _HomePopularJobsState createState() => _HomePopularJobsState();
}

class _HomePopularJobsState extends State<HomePopularJobs> {
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