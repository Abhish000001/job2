import 'package:flutter/material.dart';


import '../../../constants.dart';

import '../../../job_seeker/model/job_model.dart';

import 'detail_content.dart';
import 'detail_footer.dart';
import 'detail_header.dart';

class DetailScreenR extends StatelessWidget {
  final Job data;

  const DetailScreenR({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSilverColor,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                DetailHeaderR(data: data),
                DetailContentR(data: data),
              ],
            ),
            DetailFooterR(),
          ],
        ),
      ),
    );
  }
}