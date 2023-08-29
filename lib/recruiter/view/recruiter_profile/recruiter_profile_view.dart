import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job2/components/box_btn.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job2/job_seeker/view/log-in/log_in.dart';
import '../../../constants.dart';
import '../../../utils/utils.dart';
import 'company_verification.dart';
import 'post_job_view.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;
// import 'package:image/image.dart';
var isLogedIn;

class Recruiter_profile extends StatefulWidget {
  const Recruiter_profile({super.key});

  @override
  State<Recruiter_profile> createState() => _Recruiter_profileState();
}

class _Recruiter_profileState extends State<Recruiter_profile> {
  TextEditingController First_name = TextEditingController();
  TextEditingController Last_name = TextEditingController();
  TextEditingController Company_name = TextEditingController();
  TextEditingController job_position_name = TextEditingController();
  TextEditingController email = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  File? selectedImage;
  String base64Image = "";

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
    }
    else {
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
    var shared_preferences = await SharedPreferences.getInstance();
    isLogedIn = shared_preferences.getString('user_id');
    var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length(); //imageFile is your image file
    Map<String, String> headers = {
      "Accept": "application/json",
      // "Authorization": "Bearer " + token
    }; // ignore this headers if there is no authentication

    // string to uri
    var uri = Uri.parse("https://rojgaarr.com/api/recruiter_user_profile");
    // create multipart request
    var request = http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFileSign = http.MultipartFile('image', stream, length,
        filename: basename(imageFile.path));

    // final image = decodeImage(File('test.png').readAsBytesSync())!;
    //
    // File('thumbnail.jpg').writeAsBytesSync(encodeJpg(image));
    // add file to multipart
    request.files.add(multipartFileSign);

    //add headers
    request.headers.addAll(headers);
    print(isLogedIn);
    //adding params
    request.fields['user_id'] = isLogedIn.toString();
    request.fields['first_name'] = First_name.text.toString();
    request.fields['last_name'] = Last_name.text.toString();
    request.fields['company_name'] = Company_name.text.toString();
    request.fields['job_position'] = job_position_name.text.toString();
    request.fields['email'] = email.text.toString();

    // send
    var response = await request.send();

    print(response.statusCode);

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      log(value);
      var decoded = json.decode(value.toString());
      log(decoded.toString());
      if (decoded["result"].toString() == "true") {
        Utils().sendMassage('${decoded['msg']}');
        Get.offAll(Job_Post(), transition: Transition.rightToLeft);
      } else {
        Utils().sendMassage('${decoded['msg']}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: ListView(
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text('My Recruiter Profile',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 10,
                      ),
                      Text('introduce yourself to the candidate',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('My profile Picture',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey)),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Choose a Photo or Select an Avatar',
                                  style: TextStyle(
                                    fontSize: 14,
                                  )),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              Get.dialog(AlertDialog(
                                content: Container(
                                  height: 180,
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
                                        onTap: () {
                                          Get.back();
                                        },
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
                      Text('First Name',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      SizedBox(
                        height: 20,
                      ),
                      FiledArea('Enter name', controller: First_name,
                          validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please fill data';
                        }
                        return null;
                      }, keyboardType: TextInputType.name),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Last Name',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      SizedBox(
                        height: 20,
                      ),
                      FiledArea('Enter Last Name', controller: Last_name,
                          validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please fill data';
                        }
                        return null;
                      }, keyboardType: TextInputType.name),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Company Name',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      SizedBox(
                        height: 20,
                      ),
                      FiledArea('My Company', controller: Company_name,
                          validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please fill data';
                        }
                        return null;
                      }, keyboardType: TextInputType.text),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Add Poition',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      SizedBox(
                        height: 20,
                      ),
                      FiledArea('My job poition', controller: job_position_name,
                          validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please fill data';
                        }
                        return null;
                      }, keyboardType: TextInputType.text),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Add Email',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      SizedBox(
                        height: 20,
                      ),
                      FiledArea('My Email', controller: email,
                          validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please fill data';
                        }
                        return null;
                      }, keyboardType: TextInputType.emailAddress)
                    ],
                  ),
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
              if (selectedImage != null && formKey.currentState!.validate()) {
                setState(() {
                  isLoading = true;
                });
                setState(() {
                  isLoading = false;
                });
                 uploaddata();
               // uploadImage(imageFile: selectedImage!);
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

  uploaddata() async {
    var shared_preferences = await SharedPreferences.getInstance();
    isLogedIn = shared_preferences.getString('user_id');
    print("done");
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://rojgaarr.com/api/recruiter_user_profile'));
    request.fields.addAll({
      'user_id': isLogedIn.toString(),
      'first_name': First_name.text.toString(),
      'last_name': Last_name.text.toString(),
      'company_name': Company_name.text.toString(),
      'job_position': job_position_name.text.toString(),
      'email': email.text.toString(),
    });

    request.files
        .add(await http.MultipartFile.fromPath('image', selectedImage!.path));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());

      Get.off(Company_Verification(),
          transition: Transition.rightToLeft);

    }
    else {
      print(response.reasonPhrase);
    }
  }

  uploaddata2()async{
    print("done2");

    var uri = Uri.parse("https://rojgaarr.com/api/recruiter_user_profile");
    var request = http.MultipartRequest('POST', uri);
    if (selectedImage != null) {
      print("nhjklnkl");
    var stream = http.ByteStream(selectedImage!.openRead());
    var length = await selectedImage!.length();
    var multipartFile = http.MultipartFile(
      'image',
      stream,
      length,
      filename: path.basename(selectedImage!.path),
      contentType: MediaType('image', 'jpeg'), // Specify JPEG format
    );
    print("xv");
    request.files.add(multipartFile);
    }
    request.fields['user_id'] = isLogedIn.toString();
    request.fields['first_name'] = First_name.text.toString();
    request.fields['last_name'] = Last_name.text.toString();
    request.fields['company_name'] = Company_name.text.toString();
    request.fields['job_position'] = job_position_name.text.toString();
    request.fields['email'] = email.text.toString();
    print("iuhhjk");
    try {
      var response = await request.send();
print("hjkjknl");
      var responseString = await response.stream.bytesToString();
      print("guuhgki");
      var jsonResponse = json.decode(responseString.toString());
      // print(jsonResponse);
      print("xiuuy");

      if (response.statusCode == 200) {
        // notifyListeners();
        print("${jsonResponse['msg']}");
        Utils().sendMassage('${jsonResponse['msg']}');
        // Get.offAll(Job_Post(), transition: Transition.rightToLeft);
        print("uhhjc");
        return "Success";
      } else {
        print("Failed to update profile. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Failed to update profile: $e");
    }
  }
}

Widget FiledArea(String title,
    {required controller, required validator, required keyboardType}) {
  return TextFormField(
    controller: controller,
    validator: validator,
    keyboardType: TextInputType.name,
    decoration: InputDecoration(hintText: title),
  );
}
