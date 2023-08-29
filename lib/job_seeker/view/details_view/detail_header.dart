import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';


import '../../../constants.dart';

import '../../model/job_model.dart';

class DetailHeader extends StatelessWidget {
  const DetailHeader({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Job data;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            data.companyName,
            style: kSubTitleTextStyle.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),

          IconButton(onPressed: (){}, icon: Icon(Icons.chat_bubble_outline)),
         
        ],
      ),
    );
  }
}