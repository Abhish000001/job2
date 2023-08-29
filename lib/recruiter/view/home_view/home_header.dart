import 'package:flutter/material.dart';


import '../../../constants.dart';


class HomeHeaderR extends StatelessWidget {
  const HomeHeaderR({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: kSpacingUnit * 2,
      ),
      child: RichText(
        text: TextSpan(
          style: kHeadingTextStyle,
          children: [
            TextSpan(text: 'Hey Adam, \n'),
            TextSpan(
              text: 'Looking for a Job?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}