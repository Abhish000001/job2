import 'package:flutter/material.dart';
import '../../../constants.dart';

class DetailItemR extends StatelessWidget {
  final String data;

  const DetailItemR({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: kSpacingUnit * 2),
      child: Text(
        data,
        style: kCaptionTextStyle.copyWith(
          color: kPrimaryTextColor,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}