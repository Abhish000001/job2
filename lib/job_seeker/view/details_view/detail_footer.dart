import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


import '../../../constants.dart';


class DetailFooter extends StatelessWidget {
  const DetailFooter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: EdgeInsets.all(kSpacingUnit * 2),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [kFooterShadow],
        ),
        child: Row(
          children: [
            Container(
              height: kSpacingUnit * 6,
              width: kSpacingUnit * 8,
              decoration: BoxDecoration(
                color: kSilverColor,
                borderRadius: BorderRadius.circular(kSpacingUnit * 3),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/heart_icon.svg',
                  height: 20,
                  width: 20,
                  color: kAccentColor,
                ),
              ),
            ),
            SizedBox(width: kSpacingUnit * 2),
            Expanded(
              child: InkWell(
                onTap: (){
                  // Get.to(Add_details_form());
                },
                child: Container(
                  height: kSpacingUnit * 6,
                  decoration: BoxDecoration(
                    color: kAccentColor,
                    borderRadius: BorderRadius.circular(kSpacingUnit * 3),
                  ),
                  child: Center(
                    child: Text(
                      'Apply Now',
                      style: kTitleTextStyle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}