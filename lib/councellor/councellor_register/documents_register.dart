import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ten_x_app/councellor/councellor_register/register_next.dart';
import '../../auth/api_services/api_service.dart';
import '../../auth/model/aws_response_model.dart';
import '../../auth/model/complete_therapist_registration_response_model.dart';
import '../../common/colors/colors.dart';
import '../../common/commonText/common_text.dart';
import '../../common/commonText/common_text_colors.dart';
import '../../common/commonTextField/common_text_field.dart';
import '../councellor_Home/counsellor_dashboard.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

import '../councellor_Home/counsellor_status_scrren.dart';

class DocumentsRegister extends StatefulWidget {
  final String fullName;
  final String email;
  final String mobile;
  final String profilePicture;
  final List<String> language;
  final String dob;
  final String age;
  final String gender;
  final String state;
  final String country;
  final String city;
  final String pincode;
  final String bio;
  final String college;
  final String degree;
  final String education;
  final List<String> specialization;
  final String linkedInUrl;
  final String instagramUrl;
  final String facebookUrl;
  final String twitterUrl;
  final String certificate;
  const DocumentsRegister({super.key,required this.fullName, required this.email, required this.mobile, required this.language,
    required this.dob, required this.age, required this.gender, required this.state, required this.country, required this.city,
    required this.pincode, required this.bio, required this.college, required this.degree, required this.education,required this.specialization,
    required this.linkedInUrl,required this.instagramUrl,
    required this.facebookUrl, required this.twitterUrl, required this.certificate,required this.profilePicture});

 // const DocumentsRegister({super.key});

  @override
  State<DocumentsRegister> createState() => _DocumentsRegisterState();
}

class _DocumentsRegisterState extends State<DocumentsRegister> {
  final TextEditingController aadhaarController = TextEditingController();
  final TextEditingController pancardController = TextEditingController();
  File? _image;
  File? _image1;
  String presignedUrl = "",presignedUrl1 = "",teenagerName = "",age = "", objectUrl = "",objectUrl1 = "",extensionWithoutDot = "",extensionWithoutDot1 = "";
  String? extension;
  String? fileName;
  String? fileName1;
  final ImagePicker _picker = ImagePicker();
  bool isLoading = false;

  Future<void> _pickFrontAadharImage(ImageSource source) async {
    final XFile? photo = await _picker.pickImage(source: source);

    if (photo != null) {
      setState(() {
        _image = File(photo.path);
        fileName = p.basename(photo.path); // Get file name with extension
        String extension = p.extension(photo.path); // Get extension with dot
        extensionWithoutDot = extension.substring(1); // Remove dot
        print("File Name: $fileName");
        print("File Extension (with dot): $extension");
        print("File Extension (without dot): $extensionWithoutDot");
      });

      // Auto upload image after selection
      await getAwsUrl();
    }
  }


  Future<void> _pickBackAadharImage(ImageSource source) async {
    final XFile? photo = await _picker.pickImage(source: source);

    if (photo != null) {
      setState(() {
        _image1 = File(photo.path);
        fileName1 = p.basename(photo.path); // Get file name with extension
        String extension = p.extension(photo.path); // Get extension with dot
        extensionWithoutDot1 = extension.substring(1); // Remove dot
        print("File Name: $fileName1");
        print("File Extension (with dot): $extension");
        print("File Extension (without dot): $extensionWithoutDot1");
      });

      // Auto upload image after selection
      await getAwsUrl1();
    }
  }

  getAwsUrl() async {
    String fileType = "image/$extensionWithoutDot", folder_name = "documents";
    print('Image FileType is $fileType');
    setState(() {
      isLoading = true; // Start loading
    });
    try {
      AwsResponseModel model = await CallService().getAwsUrl(fileType,folder_name);
      presignedUrl = model.presignedUrl.toString();
      objectUrl = model.objectUrl.toString();
      print("Presigned Url value is: $presignedUrl");
      print("Object Url value is: $objectUrl");
      callPresignedUrl(presignedUrl);
    } catch (error) {
      Fluttertoast.showToast(
        msg: "Failed to update details. Please try again.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } finally {
      setState(() {
        isLoading = false; // Stop loading
      });
    }
  }

  Future<void> callPresignedUrl(String presignedUrl) async {
    try {
      Uri url = Uri.parse(presignedUrl);
      print("Url is $url");

      // Read the image file as bytes
      final imageBytes = await _image!.readAsBytes();

      // Make the PUT request
      var response = await http.put(
        url,
        headers: {
          'accept': 'application/json',
          'Content-Type': 'image/$extensionWithoutDot', // Replace 'image/jpeg' with your image type if needed
        },
        body: imageBytes,
      );

      // Handle the response
      print("Response is $response");
      print("Response body: ${response.body}");
      print("Upload Image Response code is: ${response.statusCode}");

      if (response.statusCode == 200) {
        isLoading = false;
        print("Uploaded user profile image successfully");
        //completeTherapistRegistration();
        // updateUI();
      } else {
        print("Failed to upload image. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("An error occurred: $e");
    }
  }

  getAwsUrl1() async {
    String fileType = "image/$extensionWithoutDot1", folder_name = "documents";
    print('Image FileType is $fileType');
    setState(() {
      isLoading = true; // Start loading
    });
    try {
      AwsResponseModel model = await CallService().getAwsUrl(fileType,folder_name);
      presignedUrl1 = model.presignedUrl.toString();
      objectUrl1 = model.objectUrl.toString();
      print("Presigned Url1 value is: $presignedUrl1");
      print("Object Url1 value is: $objectUrl1");
      callPresignedUrl1(presignedUrl1);
    } catch (error) {
      Fluttertoast.showToast(
        msg: "Failed to update details. Please try again.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } finally {
      setState(() {
        isLoading = false; // Stop loading
      });
    }
  }


  Future<void> callPresignedUrl1(String presignedUrl) async {
    try {
      Uri url = Uri.parse(presignedUrl);
      print("Url1 is $url");

      // Read the image file as bytes
      final imageBytes = await _image1!.readAsBytes();

      // Make the PUT request
      var response = await http.put(
        url,
        headers: {
          'accept': 'application/json',
          'Content-Type': 'image/$extensionWithoutDot1', // Replace 'image/jpeg' with your image type if needed
        },
        body: imageBytes,
      );

      // Handle the response
      print("Response is $response");
      print("Response body: ${response.body}");
      print("Upload Image Response code is: ${response.statusCode}");
      if (response.statusCode == 200) {
        isLoading = false;
        print("Uploaded user profile image successfully");
        //completeTherapistRegistration();
        // updateUI();
      } else {
        print("Failed to upload image. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("An error occurred: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(12.0),
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                    margin: EdgeInsets.only(top: 20, left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          text: 'Documents',
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                        CommonTextColors(
                            text: 'Step 3 of 3',
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            color: AppColors.mediumDarkGray),
                      ],
                    ),
                  ),
                      SizedBox(height: 20,),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: CommonTextField(
                          hintText: '____ ____ ____',
                          text: 'Aadhaar Number',
                          controller: aadhaarController,
                          inputType: TextInputType.text,
                          readOnly: false,
                          height: 50,
                          width: 380,),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: CommonTextField(
                          hintText: '____ ____ ____',
                          text: 'Pan card Number',
                          controller: pancardController,
                          inputType: TextInputType.text,
                          readOnly: false,
                          height: 50,
                          width: 380,),
                      ),
                      SizedBox(height: 10,),
                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 30),
                            child: CommonText(
                                text: 'Aadhaar Front', fontSize: 13,
                                fontFamily: 'Inter', fontWeight: FontWeight.w600),
                          ),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => SafeArea(
                                  child: Wrap(
                                    children: <Widget>[
                                      ListTile(
                                        leading: Icon(Icons.photo_camera),
                                        title: Text('Take a picture'),
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          _pickFrontAadharImage(ImageSource.camera);
                                        },
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.photo_library),
                                        title: Text('Choose from gallery'),
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          _pickFrontAadharImage(ImageSource.gallery);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              height: 104,
                              width: 372,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: AppColors.redOrange
                                  )
                              ),
                              child: _image == null
                                  ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CommonTextColors(
                                    text:
                                    "Click to upload or drag and drop",
                                    fontSize: 13,
                                    color: AppColors.redOrange,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Poppins',
                                  ),
                                  SizedBox(height: 8),
                                  CommonTextColors(
                                    text: "Supported formats: PDF, PNG, JPG. Max",
                                    fontSize:13,
                                    color: AppColors.lightGray,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Poppins',
                                  ),
                                  CommonTextColors(
                                    text:
                                    "file size: 5MB",
                                    fontSize:13,
                                    color: AppColors.lightGray,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Poppins',
                                  ),
                                ],
                              )
                                  : ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.file(
                                  _image!,
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10,),
                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 30),
                            child: CommonText(
                                text: 'Aadhaar Back', fontSize: 13,
                                fontFamily: 'Inter', fontWeight: FontWeight.w600),
                          ),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => SafeArea(
                                  child: Wrap(
                                    children: <Widget>[
                                      ListTile(
                                        leading: Icon(Icons.photo_camera),
                                        title: Text('Take a picture'),
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          _pickBackAadharImage(ImageSource.camera);
                                        },
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.photo_library),
                                        title: Text('Choose from gallery'),
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          _pickBackAadharImage(ImageSource.gallery);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              height: 104,
                              width: 372,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: AppColors.redOrange
                                  )
                              ),
                              child: _image1 == null
                                  ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CommonTextColors(
                                    text:
                                    "Click to upload or drag and drop",
                                    fontSize: 13,
                                    color: AppColors.redOrange,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Poppins',
                                  ),
                                  SizedBox(height: 8),
                                  CommonTextColors(
                                    text:
                                    "Supported formats: PDF, PNG, JPG. Max",
                                    fontSize:13,
                                    color: AppColors.lightGray,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Poppins',
                                  ),
                                  CommonTextColors(
                                    text:
                                    "file size: 5MB",
                                    fontSize:13,
                                    color: AppColors.lightGray,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Poppins',
                                  ),
                                ],
                              )
                                  : ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.file(
                                  _image1!,
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      // SizedBox(height: 10,),
                      // Column(crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Container(
                      //       margin: EdgeInsets.only(left: 30),
                      //       child: CommonText(
                      //           text: 'PAN Card', fontSize: 13,
                      //           fontFamily: 'Inter', fontWeight: FontWeight.w600),
                      //     ),
                      //     GestureDetector(
                      //       onTap: () {
                      //         showModalBottomSheet(
                      //           context: context,
                      //           builder: (context) => SafeArea(
                      //             child: Wrap(
                      //               children: <Widget>[
                      //                 ListTile(
                      //                   leading: Icon(Icons.photo_camera),
                      //                   title: Text('Take a picture'),
                      //                   onTap: () {
                      //                     Navigator.of(context).pop();
                      //                     _pickImage(ImageSource.camera);
                      //                   },
                      //                 ),
                      //                 ListTile(
                      //                   leading: Icon(Icons.photo_library),
                      //                   title: Text('Choose from gallery'),
                      //                   onTap: () {
                      //                     Navigator.of(context).pop();
                      //                     _pickImage(ImageSource.gallery);
                      //                   },
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         );
                      //       },
                      //       child: Container(
                      //         margin: EdgeInsets.symmetric(horizontal: 20),
                      //         height: 104,
                      //         width: 372,
                      //         decoration: BoxDecoration(
                      //             color: Colors.white,
                      //             borderRadius: BorderRadius.circular(12),
                      //             border: Border.all(
                      //                 color: AppColors.redOrange
                      //             )
                      //         ),
                      //         child: _image == null
                      //             ? Column(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             CommonTextColors(
                      //               text:
                      //               "Click to upload or drag and drop",
                      //               fontSize: 13,
                      //               color: AppColors.redOrange,
                      //               fontWeight: FontWeight.w300,
                      //               fontFamily: 'Poppins',
                      //             ),
                      //             SizedBox(height: 8),
                      //             CommonTextColors(
                      //               text:
                      //               "Supported formats: PDF, PNG, JPG. Max",
                      //               fontSize:13,
                      //               color: AppColors.lightGray,
                      //               fontWeight: FontWeight.w300,
                      //               fontFamily: 'Poppins',
                      //             ),
                      //             CommonTextColors(
                      //               text:
                      //               "file size: 5MB",
                      //               fontSize:13,
                      //               color: AppColors.lightGray,
                      //               fontWeight: FontWeight.w300,
                      //               fontFamily: 'Poppins',
                      //             ),
                      //           ],
                      //         )
                      //             : ClipRRect(
                      //           borderRadius: BorderRadius.circular(15),
                      //           child: Image.file(
                      //             _image!,
                      //             width: double.infinity,
                      //             height: double.infinity,
                      //             fit: BoxFit.cover,
                      //           ),
                      //         ),
                      //       ),
                      //     )
                      //   ],
                      // ),
                      SizedBox(height: 45,),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) => RegisterNext()),
                                // );
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 26, vertical: 8),
                                side: BorderSide(color: AppColors.redOrange, width: 1), // Border color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12), // Rounded corners
                                ),
                              ),
                              child:CommonTextColors(
                                text:'Back',
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: AppColors.redOrange,
                                fontFamily: 'Poppins',// White text
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                completeTherapistRegistration();

                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 26, vertical: 8),
                                backgroundColor: AppColors.redOrange, // Button background
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12), // Rounded corners
                                ),
                              ),
                              child: CommonTextColors(
                                text:'Submit',
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: AppColors.white,
                                fontFamily: 'Poppins',// White text
                              ),
                            ),
                          ],
                        ),
                      )
                    ]
                )
            )
        )
    );
  }

  Future<void> completeTherapistRegistration()
  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var map = Map<String, dynamic>();
    String aadharnumber = aadhaarController.text.toString().trim();
    String pancardNumber = pancardController.text.toString().trim();
    map["fullName"]= widget.fullName;
    map["email"]= widget.email;
    map["phoneNumber"]= widget.mobile;
    map["profilePicture"]= widget.profilePicture;
    map["bio"]= widget.bio;
    map["dateOfBirth"]= widget.dob;
    map["gender"]= widget.gender;
    map["languages"]= widget.language;
    map["specialization"]= widget.specialization;
    map["country"]= widget.country;
    map["state"]= widget.state;
    map["city"]= widget.city;
    map["pincode"]= widget.pincode;
    map["collegeName"]= widget.college;
    map["degree"]= widget.degree;
    map["higherEducation"]= widget.education;
    map["yearsOfExperience"]= 3;
    map["aadharNumber"]= aadharnumber;
    map["aadharFront"]= objectUrl;
    map["aadharBack"]= objectUrl1;
    map["pancard"]= pancardNumber;
    map["linkedinProfile"]= widget.linkedInUrl;
    map["instagramProfile"]= widget.instagramUrl;
    map["facebookProfile"]= widget.facebookUrl;
    map["twitterProfile"]= widget.twitterUrl;
   // map["certification"]= widget.certificate;

    print("Map value is :$map");

    isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      CompleteTherapistRegistrationResponseModel model =
      await CallService().completeRegistrationTherapist(map);
      isLoading = false;
      String message = model.message.toString();
      String profileStatus =model.profileStatus.toString();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print("userProfileStatus is $profileStatus");
      await prefs.setString('approve_status',profileStatus);
      if(profileStatus == "APPROVED"){
        Navigator.push(context,
          MaterialPageRoute(builder: (context) => CounsellorDashboard()),
        );
      }else{
        Navigator.push(context,
          MaterialPageRoute(builder: (context) => CounsellorStatusScreen()),
        );
      }
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }
}
