import 'package:flutter/material.dart';

import '../../../components/box_btn.dart';

class Describe_job extends StatefulWidget {
  const Describe_job({super.key});

  @override
  State<Describe_job> createState() => _Describe_jobState();
}

class _Describe_jobState extends State<Describe_job> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Text('Describe job',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                    Container(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Insert About job",
                        ),
                        scrollPadding: EdgeInsets.all(20.0),
                        keyboardType: TextInputType.multiline,
                        maxLines: 25,
                        autofocus: true,
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(18.0),
        child: BoxButton(text: 'Save', onTap: () {}),
      ),
    );
  }
}
