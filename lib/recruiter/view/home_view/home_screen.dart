import 'package:flutter/material.dart';

import '../../../components/search_view.dart';
import '../../../constants.dart';
import 'home_content.dart';
import 'home_header.dart';

class HomeScreenR extends StatelessWidget {
  const HomeScreenR({super.key});

  @override
  Widget build(BuildContext context) {
    // ScreenUtil.init(context, height: 896, width: 414,
    //  allowFontScaling: true);

    return Scaffold(
     
      backgroundColor: Colors.white,
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: kSpacingUnit * 3),
          
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: SearchForm(),
            ),
           
            SizedBox(height: kSpacingUnit * 1),
            HomeContentR(),
          ],
        ),
    );
  }
}