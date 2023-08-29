import 'package:flutter/material.dart';


import '../../../constants.dart';

import '../../model/job_model.dart';
import 'detail_content.dart';
import 'detail_footer.dart';
import 'detail_header.dart';

class DetailScreen extends StatelessWidget {
  final Job data;

  const DetailScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSilverColor,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                DetailHeader(data: data),
                DetailContent(data: data),
              ],
            ),
            DetailFooter(),
          ],
        ),
      ),
    );
  }
}