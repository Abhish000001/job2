import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants.dart';
class SearchTag extends StatelessWidget {
  final String tag;

  const SearchTag({
    Key? key,
    required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kSpacingUnit * 3,
      width: kSpacingUnit * 15,
      margin: EdgeInsets.only(left: kSpacingUnit),
      decoration: BoxDecoration(
        color: kAccentColor,
        borderRadius: BorderRadius.circular(kSpacingUnit * 3),
      ),
      child: Center(
        child: Row(
          children: [
            SizedBox(width: kSpacingUnit),
            Text(
              tag,
              style: kCaptionTextStyle.copyWith(
                color: Colors.white,
              ),
            ),
            const Spacer(),
            SvgPicture.asset(
              'assets/icons/close_icon.svg',
              height: 15,
              width: 15,
            ),
            SizedBox(width: kSpacingUnit * 0.5),
          ],
        ),
      ),
    );
  }
}