import 'package:flutter/material.dart';

import '../../../constants.dart';

class Privacy_policy extends StatefulWidget {
  const Privacy_policy({super.key});

  @override
  State<Privacy_policy> createState() => _Privacy_policyState();
}

class _Privacy_policyState extends State<Privacy_policy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kSilverColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Settings',
          style: TextStyle(
              fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
