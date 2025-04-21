import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ten_x_app/common/commonTextField/common_text_field.dart';
import '../../auth/api_services/api_service.dart';
import '../../auth/model/aws_response_model.dart';
import '../../common/colors/colors.dart';
import '../../common/commonButton/common_button.dart';
import '../../common/commonButton/common_button_get_otp.dart';
import '../../common/commonText/common_text.dart';
import '../../common/commonText/common_text_colors.dart';
import 'counsellor_register.dart';
import 'documents_register.dart';

class RegisterNext extends StatefulWidget {
  final String fullName;
  final String email;
  final String mobile;
  final List<String> language;
  final String dob;
  final String age;
  final String gender;
  final String state;
  final String country;
  final String city;
  final String pincode;
  final String bio;
  final String profilePicture;
  const RegisterNext({super.key,required this.fullName, required this.email, required this.mobile, required this.language,
  required this.dob, required this.age, required this.gender, required this.state, required this.country, required this.city,
  required this.pincode, required this.bio, required this.profilePicture});

  @override
  State<RegisterNext> createState() => _RegisterNextState();
}

class _RegisterNextState extends State<RegisterNext> {
  File? _image;
  String? fileName;
  String extensionWithoutDot = "",presignedUrl = "",objectUrl = "";
  bool isLoading = false;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController collegeController = TextEditingController();
  final TextEditingController degreeController = TextEditingController();
  final TextEditingController specializationController = TextEditingController();
  final TextEditingController educationController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController fbController = TextEditingController();
  final TextEditingController instaController = TextEditingController();
  final TextEditingController twitController = TextEditingController();
  final TextEditingController linkedinController = TextEditingController();

  Future<void> _pickCertificateImage(ImageSource source) async {
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


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  Padding(
        padding: EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20,left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: 'Qualification',
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                    CommonTextColors(
                        text: 'Step 2 of 3',
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        color: AppColors.mediumDarkGray)
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: CommonTextField(
                  hintText: 'Enter your college/university',
                  text: 'College/university',
                  controller: collegeController,
                  inputType: TextInputType.text,
                  readOnly: false,
                  height: 50,
                  width: 380,),
              ),
              SizedBox(height: 10,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: CommonTextField(
                  hintText: 'enter your degree',
                  text: 'Degree',
                  controller: degreeController,
                  inputType: TextInputType.text,
                  readOnly: false,
                  height: 50,
                  width: 380,),
              ),
              SizedBox(height: 10,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: CommonTextField(
                  hintText: 'Specialist in',
                  text: 'Specialization',
                  controller: specializationController,
                  inputType: TextInputType.text,
                  readOnly: false,
                  height: 50,
                  width: 380,),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: CommonTextField(
                  hintText: 'Higher Education',
                  text: 'Education',
                  controller: educationController,
                  inputType: TextInputType.text,
                  readOnly: false,
                  height: 50,
                  width: 380,),
              ),Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: CommonTextField(
                  hintText: 'Experience',
                  text: 'Experience',
                  controller: experienceController,
                  inputType: TextInputType.text,
                  readOnly: false,
                  height: 50,
                  width: 380,),
              ),
              SizedBox(height: 20,),
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 30),
                    child: CommonText(
                        text: 'Certification', fontSize: 13,
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
                                  _pickCertificateImage(ImageSource.camera);
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.photo_library),
                                title: Text('Choose from gallery'),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  _pickCertificateImage(ImageSource.gallery);
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
                            "Click to upload multiple certificates",
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
              SizedBox(height: 15,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: CommonText(text: 'Social media links',
                    fontSize: 20,
                    fontFamily: 'Poppins', fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: CommonTextField(
                  hintText: 'optional',
                  text: 'Facebook',
                  controller: fbController,
                  inputType: TextInputType.text,
                  readOnly: false,
                  height: 50,
                  width: 380,),
              ),
              SizedBox(height: 10,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: CommonTextField(
                  hintText: 'optional',
                  text: 'Instagram',
                  controller: instaController,
                  inputType: TextInputType.text,
                  readOnly: false,
                  height: 50,
                  width: 380,),
              ),
              SizedBox(height: 10,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: CommonTextField(
                  hintText: 'optional',
                  text: 'Twitter',
                  controller: twitController,
                  inputType: TextInputType.text,
                  readOnly: false,
                  height: 50,
                  width: 380,),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: CommonTextField(
                  hintText: 'optional',
                  text: 'Linkedin',
                  controller: linkedinController,
                  inputType: TextInputType.text,
                  readOnly: false,
                  height: 50,
                  width: 380,),
              ),
              SizedBox(height: 20,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context)=>CounsellorRegister()),
                        );
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
                        List<String> specialization = [];
                        String college = collegeController.text.toString().trim();
                        String degree = degreeController.text.toString().trim();
                        String specializations = specializationController.text.toString().trim();
                        String linkedInUrl = linkedinController.text.toString().trim();
                        String facebookUrl = fbController.text.toString().trim();
                        String instaUrl = instaController.text.toString().trim();
                        String twitter = twitController.text.toString().trim();
                        String education = educationController.text.toString().trim();
                        specialization.add(specializations);
                        String certificate = objectUrl;
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context)=>DocumentsRegister(fullName: widget.fullName,
                            email:widget.email,mobile: widget.mobile,profilePicture:widget.profilePicture,language: widget.language, dob: widget.dob,
                          age: widget.age,gender: widget.gender,country: widget.country,city:widget.city,state: widget.state,
                          pincode: widget.pincode,bio: widget.bio,college:college,degree:degree,education : education, specialization: specialization,
                            linkedInUrl: linkedInUrl,instagramUrl: instaUrl,
                            facebookUrl :facebookUrl, twitterUrl: twitter,certificate:objectUrl)),
                        );
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 26, vertical: 8),
                        backgroundColor: AppColors.redOrange, // Button background
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // Rounded corners
                        ),
                      ),
                      child: CommonTextColors(
                          text:'Next',
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                        fontFamily: 'Poppins',// White text
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  void _saveStepTwoData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('college', collegeController.text);
    await prefs.setString('degree', degreeController.text);
    await prefs.setStringList('specialization',specializationController.text.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty)
          .toList(),);
    await prefs.setString('Education', educationController.text);
    await prefs.setString('experience', experienceController.text);
    await prefs.setString('facebook', fbController.text);
    await prefs.setString('instagram', instaController.text);
    await prefs.setString('twitter', twitController.text);
    await prefs.setString('linkedin', linkedinController.text);
    // You can also save certificate image path or URL if needed
  }


}
