import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job2/main.dart';
import '../../../components/box_btn.dart';
import '../../../constants.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';
import '../../../utils/utils.dart';
import '../education_level/education_level.dart';
import '../job_preference/job_preferance.dart';

class Add_name extends StatefulWidget {
  const Add_name({super.key});

  @override
  State<Add_name> createState() => _Add_nameState();
}

class _Add_nameState extends State<Add_name> {
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController email = TextEditingController();
  File? selectedImage;
  String base64Image = "";
  DateTime dateTime = DateTime.now();
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  final items = [
    'Male',
    'Female',
  ];
  double _kItemExtent = 32.0;

  final data = [
    'Fresher',
    'Experiance',
  ];
  int index = 0;
  int raw = 0;
  Future<void> chooseImage(type) async {
    // ignore: prefer_typing_uninitialized_variables
    var image;
    if (type == "camera") {
      print('camera');
      image = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 10);
    } else if (type != "camera") {
      image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 25);
    } else {
      print('try again');
    }
    if (image != null) {
      setState(() {
        selectedImage = File(
          image.path,
        );
        base64Image = base64Encode(selectedImage!.readAsBytesSync());
        // won't have any error now
      });
    }
  }

  uploadImage({required File imageFile}) async {
    var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length(); //imageFile is your image file
    Map<String, String> headers = {
      "Accept": "application/json",
      // "Authorization": "Bearer " + token
    }; // ignore this headers if there is no authentication

    // string to uri
    var uri = Uri.parse("${baseurl}my_profile");

    // create multipart request
    var request = http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFileSign = http.MultipartFile(
        'image', stream, length,
        filename: basename(imageFile.path));

    // add file to multipart
    request.files.add(multipartFileSign);

    //add headers
    request.headers.addAll(headers);

    //adding params
    request.fields['user_id'] = loggedinUser!.data!.id.toString();
    request.fields['first_name'] = fname.text.toString();
    request.fields['last_name'] = lname.text.toString();
    request.fields['gender'] = items[index].toString();
    request.fields['Experiance_level'] = data[raw].toString();
    request.fields['dob'] = dateTime.toString();
    request.fields['email'] = email.text.toString();

    // send
    var response = await request.send();

    print(response.statusCode);

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      log(value);
      var decoded = json.decode(value);
      log(decoded.toString());
      if (decoded["result"].toString() == "true") {
        Utils().sendMassage('${decoded['msg']}');
        Get.offAll(Education_level(),
            transition: Transition.rightToLeftWithFade);
      } else {
        Utils().sendMassage('${decoded['msg']}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black87,
            )),
        backgroundColor: kSilverColor,
        elevation: 0,
        centerTitle: true,
        title: Text('My Profile',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87)),
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('My Profile Picture',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Complete your profile to connect\n easily',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey)),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.dialog(AlertDialog(
                              content: Container(
                                height: 200,
                                child: Column(
                                  children: [
                                    ListTile(
                                      onTap: () {
                                        chooseImage(ImageSource.camera);
                                      },
                                      title: Text('Take Photo'),
                                    ),
                                    ListTile(
                                      onTap: () {
                                        chooseImage(ImageSource.gallery);
                                      },
                                      title: Text('Choose photo'),
                                    ),
                                    ListTile(
                                      title: Text('Cancel'),
                                    ),
                                  ],
                                ),
                              ),
                            ));
                          },
                          child: CircleAvatar(
                            radius: 35,
                            child: ClipOval(
                                child: selectedImage != null
                                    ? Image.file(
                                        selectedImage!,
                                        fit: BoxFit.cover,
                                        height: 100,
                                        width: 100,
                                      )
                                    : Image.network(
                                        'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg',
                                        fit: BoxFit.cover,
                                        height: 100,
                                        width: 100,
                                      )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    SizedBox(
                      height: 20,
                    ),
                    Text('First Name',
                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                    SizedBox(
                      height: 20,
                    ),
                    FiledArea('Enter Name ', controller: fname,
                        validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please fill data';
                      }
                      return null;
                    }, keyboardType: TextInputType.text),
                    SizedBox(
                      height: 30,
                    ),
                    Text('Last Name',
                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                    SizedBox(
                      height: 20,
                    ),
                    FiledArea('Enter Last Name ', controller: lname,
                        validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please fill data';
                      }
                      return null;
                    }, keyboardType: TextInputType.text),
                    SizedBox(
                      height: 20,
                    ),
                    Text('MY Gender',
                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.35,
                                decoration: new BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: new BorderRadius.only(
                                    topLeft: const Radius.circular(25.0),
                                    topRight: const Radius.circular(25.0),
                                  ),
                                ),
                                child: CupertinoPicker(
                                  magnification: 1.22,
                                  squeeze: 1.2,
                                  useMagnifier: true,
                                  itemExtent: _kItemExtent,
                                  // This is called when selected item is changed.
                                  onSelectedItemChanged: (int selectedItem) {
                                    setState(() {
                                      index = selectedItem;
                                    });
                                  },
                                  children: List<Widget>.generate(items.length,
                                      (int index) {
                                    return Center(
                                      child: Text(
                                        items[index],
                                      ),
                                    );
                                  }),
                                ),
                              );
                            });
                      },
                      title: Text('${items[index]}'),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    Divider(),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Experiance Level',
                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.35,
                                decoration: new BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: new BorderRadius.only(
                                    topLeft: const Radius.circular(25.0),
                                    topRight: const Radius.circular(25.0),
                                  ),
                                ),
                                child: CupertinoPicker(
                                  magnification: 1.22,
                                  squeeze: 1.2,
                                  useMagnifier: true,
                                  itemExtent: _kItemExtent,
                                  // This is called when selected item is changed.
                                  onSelectedItemChanged: (int selectedItem) {
                                    setState(() {
                                      raw = selectedItem;
                                    });
                                  },
                                  children: List<Widget>.generate(data.length,
                                      (int index) {
                                    return Center(
                                      child: Text(
                                        data[index],
                                      ),
                                    );
                                  }),
                                ),
                              );
                            });
                      },
                      title: Text('${data[raw]}'),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    Divider(),
                    SizedBox(
                      height: 10,
                    ),
                    Text('My DOB',
                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              return Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.35,
                                  decoration: new BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: new BorderRadius.only(
                                      topLeft: const Radius.circular(25.0),
                                      topRight: const Radius.circular(25.0),
                                    ),
                                  ),
                                  child: CupertinoDatePicker(
                                    initialDateTime: dateTime,
                                    mode: CupertinoDatePickerMode.date,
                                    onDateTimeChanged: (newTime) {
                                      setState(() {
                                        dateTime = newTime;
                                      });
                                    },
                                  ));
                            });
                      },
                      title: Text(
                          '${dateTime.month}-${dateTime.month}-${dateTime.year}'),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    Divider(),
                    SizedBox(
                      height: 10,
                    ),
                    Text('My Email',
                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                    SizedBox(
                      height: 10,
                    ),
                    FiledArea('Enter Email', controller: email,
                        validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please fill data';
                      }
                      return null;
                    }, keyboardType: TextInputType.text),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
            )),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(18.0),
        child: BoxButton(
            isloading: isLoading,
            text: 'Save',
            onTap: () async {

              if (formKey.currentState!.validate() && selectedImage != null) {
                setState(() {
                  isLoading = true;
                });
                setState(() {
                  isLoading = false;
                });

                uploadImage(imageFile: selectedImage!);
              } else {
                setState(() {
                  isLoading = true;
                });
                Utils().sendMassage('"Please select image "');
              }
            }),
      ),
    );
  }
}



//  
