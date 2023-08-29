import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../../../components/box_btn.dart';

class Upload_resume extends StatefulWidget {
  const Upload_resume({super.key});

  @override
  State<Upload_resume> createState() => _Upload_resumeState();
}

class _Upload_resumeState extends State<Upload_resume> {
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
                    Text('Resumes',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                        leading: Icon(Icons.picture_as_pdf),
                        title: Text('Resume'),
                        subtitle: Text('Date'),
                        trailing: PopupMenuButton(
                          onSelected: (value) {
                            // your logic
                          },
                          itemBuilder: (BuildContext) {
                            return const [
                              PopupMenuItem(
                                child: Text("Share"),
                                value: '/hello',
                              ),                                                                                                                                                                                                                   
                              PopupMenuItem(
                                child: Text("Rename"),
                                value: '/about',
                              ),
                              PopupMenuItem(
                                child: Text("Delete"),
                                value: '/contact',
                              ),
                              PopupMenuItem(
                                child: Text("Cancel"),
                                value: '/contact',
                              )
                            ];
                          },
                        )),
                    Divider()
                  ],
                ),
              ],
            )),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(18.0),
        child: BoxButton(text: 'Upload', onTap: ()async {
          FilePickerResult ? result = await FilePicker.platform.pickFiles();

          if (result != null) {
            File file = File(result.files.single.path.toString());
            print(file);
          } else {
            // User canceled the picker
          }
        }),
      ),
    );
  }
}
