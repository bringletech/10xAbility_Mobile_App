import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ten_x_app/common/colors/colors.dart';
import '../../auth/api_services/api_service.dart';
import '../../auth/model/aws_response_model.dart';
import '../../auth/model/complete_patient_details_response_model.dart';
import '../../auth/model/get_current_user_details_response_model.dart';
import '../../auth/model/upload_profile_picture_response_model.dart';
import '../../common/commonButton/common_button.dart';
import '../../common/commonText/common_text.dart';
import '../../common/commonTextField/common_text_field.dart';
import '../../common/string_constant.dart';
import 'registeration_done_screen.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

class PatientRegisterScreen extends StatefulWidget {
  const PatientRegisterScreen({super.key});

  @override
  State<PatientRegisterScreen> createState() => _PatientRegisterScreenState();
}

class _PatientRegisterScreenState extends State<PatientRegisterScreen> {
  String? selectedValue; // Holds the selected item
  List<String> items = ['MALE', 'FEMALE'];
  UserData? data;
  String formattedDate = "";
  DateTime selectedDate = DateTime.now();
  File? _image;
  String presignedUrl = "",teenagerName = "",age = "", objectUrl = "",extensionWithoutDot = "";
  String? extension;
  String? fileName;
  bool isLoading = false;
  final ImagePicker _picker = ImagePicker();

  String name='',email='',phoneNumber='',problem='', DOB='',gender='',country='',
  state='',city='',pinCode='',profession='';

  final TextEditingController dueDateController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  //final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController problemController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController languageController = TextEditingController();
  final TextEditingController professionController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController emergencyNameController = TextEditingController();
  final TextEditingController emergencyNumberController = TextEditingController();
  final TextEditingController emergencyRelationController = TextEditingController();
  final TextEditingController birthController = TextEditingController();



  Future<void> _pickImage(ImageSource source) async {
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



  void userUpdateDetails() {
    setState(() {
      isLoading = true;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        GetCurrentUserResponseModel model =
        await CallService().getCurrentUserDetails();
        setState(() {
          isLoading = false;
          data = model.data!;
          name = model.data!.fullName?? '';
          email = model.data!.email??"";
          phoneNumber =model.data?.phoneNumber??"";
          problem =model.data?.currentFacingProb??"";
          DOB =model.data?.dateOfBirth??"";
          age =model.data?.age.toString()??'';
          gender =model.data?.gender??"";
          country =model.data?.country??"";
          profession =model.data?.profession??"";
          city =model.data?.city??"";
          state =model.data?.state??"";
          pinCode =model.data?.pincode??"";
          firstNameController.text = name;
          emailController.text = email;
          mobileController.text=phoneNumber;
          problemController.text=problem;
          birthController.text=DOB;
          ageController.text=age;
          countryController.text = country;
          professionController.text = profession;
          cityController.text = city;
          stateController.text = state;
          pinCodeController.text = pinCode;
          print("Name value is $name");
          print("Name value is $age");
        });
      });
    });
  }

  void updateUI() {
    setState(() {});
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   getSharedPreferenceValue();
    userUpdateDetails();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.only(top: 0),
                    child: Stack(
                      children: [
                        Container(
                          color: AppColors.lightSalmonPink,
                          height: 30,
                          width: 380,
                        ),
                        Container(
                          // height: 200,
                          //   width: 200,
                          child: SvgPicture.asset("assets/svgIcon/patientRegisterImage2.svg"),
                          //child: Image.asset("assets/images/patientRegisterImage.png")
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 80),
                          height: 60,
                          //width: 180,
                          child: Center(child: Image.asset("assets/images/tenxLogo.png")),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 150),
                          child: Center(
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                CircleAvatar(
                                  radius: 65,
                                  backgroundColor: Colors.white70,
                                  backgroundImage: _image != null ? FileImage(_image!) : null,
                                  child: _image == null ? Icon(
                                    Icons.person,
                                    size: 60,
                                    color: Colors.grey[600],
                                  ) : null,
                                ),
                                Positioned(
                                  bottom: 10,
                                  right: 5,
                                  child: GestureDetector(
                                    onTap: () async {
                                      var cameraStatus =
                                          await Permission.camera.request();
                                      if (cameraStatus.isGranted) {
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
                                                    _pickImage(ImageSource.camera);
                                                  },
                                                ),
                                                ListTile(
                                                  leading: Icon(Icons.photo_library),
                                                  title: Text('Choose from gallery'),
                                                  onTap: () {
                                                    Navigator.of(context).pop();
                                                    _pickImage(ImageSource.gallery);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      } else {
                                        print("Camera permission denied");
                                      }
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: AppColors.redOrange,
                                      ),
                                      child: Icon(Icons.add,color: AppColors.white,),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                ),
                SizedBox(height: 20,),
                CommonText(text: StringConstant.per,
                  fontSize: 20, fontFamily: 'Poppins', fontWeight: FontWeight.w500,),
                SizedBox(height: 20,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: CommonTextField(
                    hintText: name,
                    text: 'Full Name',
                    controller: firstNameController,
                    inputType: TextInputType.text,
                    readOnly: false,
                    height: 50,
                    width: 380,),
                ),
                SizedBox(height: 10,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: CommonTextField(
                    hintText: 'Example@gmail.com',
                    text: 'Email',
                    controller: emailController,
                    inputType: TextInputType.text,
                    readOnly: false,
                    height: 50,
                    width: 380,),
                ),
                SizedBox(height: 10,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: CommonTextField(
                    hintText: '+91-9876543210',
                    text: 'Mobile Number',
                    controller: mobileController,
                    inputType: TextInputType.text,
                    readOnly: true,
                    height: 50,
                    width: 380,),
                ),
                SizedBox(height: 10,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: CommonTextField(
                    hintText: 'Describe Your Issue',
                    text: 'What problem are you facing?',
                    controller: problemController,
                    inputType: TextInputType.text,
                    readOnly: false,
                    height: 104,
                    width: 380,),
                ),
                SizedBox(height: 10,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: CommonTextField(
                    hintText: formattedDate.isEmpty ?'noDateSelected' : formattedDate.toString(),
                    text: 'Date Of Birth',
                    controller: birthController,
                    inputType: TextInputType.text,
                    readOnly: true,
                    height: 50,
                    width: 380,
                    onTap: ()async {
                      DateTime? pickedDate =
                      await showDatePicker(context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(1900, 8),
                        lastDate: DateTime(2100),);
                      if (pickedDate != null) {
                        print(pickedDate);
                        formattedDate = DateFormat('MM/dd/yyyy').format(pickedDate);
                        int age = DateTime.now().year - pickedDate.year;
                        if (DateTime.now().month < pickedDate.month ||
                            (DateTime.now().month == pickedDate.month && DateTime.now().day < pickedDate.day)) {
                          age--;
                        }
                        print("Date Value is : $formattedDate");
                        setState(() {
                          birthController.text = formattedDate;
                          ageController.text = age.toString();
                        });
                      }
                    },
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(13),
                      child: Icon(Icons.cake_outlined,color: AppColors.redOrange,),
                      //SvgPicture.asset('assets/svgIcon/birthIcon.svg'),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: CommonTextField(
                        hintText: 'Age',
                        text: 'Age',
                        controller: ageController,
                        inputType: TextInputType.text,
                        readOnly: false,
                        height: 50,
                        width: 155,),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "Gender",
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 155,
                            margin: EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: AppColors.redOrange
                                )
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    "Select Gender",
                                    style: TextStyle(
                                      color: AppColors.gray, // Change hint text color
                                      fontSize: 11, // Change font size
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Inter",// Change font weight
                                    ),
                                  ),
                                ),
                                value: selectedValue,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedValue = newValue;
                                  });
                                },
                                items: items.map<DropdownMenuItem<String>>((String item) {
                                  return DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(item),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: CommonTextField(
                        hintText: 'Enter your Country',
                        text: 'Country',
                        controller: countryController,
                        inputType: TextInputType.text,
                        readOnly: false,
                        height: 50,
                        width: 155,),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      margin: EdgeInsets.only(right: 20),
                      child: CommonTextField(
                        hintText: 'Enter Your Profession',
                        text: 'Profession',
                        controller: professionController,
                        inputType: TextInputType.text,
                        readOnly: false,
                        height: 50,
                        width: 155,),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: CommonTextField(
                        hintText: 'Enter your City',
                        text: 'City',
                        controller: cityController,
                        inputType: TextInputType.text,
                        readOnly: false,
                        height: 50,
                        width: 155,),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      margin: EdgeInsets.only(right: 20),
                      child: CommonTextField(
                        hintText: 'Enter your State',
                        text: 'State',
                        controller: stateController,
                        inputType: TextInputType.text,
                        readOnly: false,
                        height: 50,
                        width: 155,),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: CommonTextField(
                        hintText: 'Enter your Pincode',
                        text: 'Pin code',
                        controller: pinCodeController,
                        inputType: TextInputType.text,
                        readOnly: false,
                        height: 50,
                        width: 155,),
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                // SizedBox(height: 30,),
                CommonFirstButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context)=>RegistrationDoneScreen()),
                    // );

                    completePatientRegistration(
                        firstNameController.text.toString().trim(),emailController.text.toString(),mobileController.text.toString().trim(),
                        problemController.text.toString().trim(),formattedDate,ageController.text.toString().trim(),selectedValue.toString(),
                        countryController.text.toString().trim(),stateController.text.toString().trim(),cityController.text.toString().trim(),
                        pinCodeController.text.toString().trim(),professionController.text.toString().trim()
                    );
                  },
                  text: 'Submit',
                  height: 50,
                  width: 328,
                  fontSize: 24,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                ),
                SizedBox(height: 30,)
              ],
            ),
          ),
        ),
      ),
    );
  }

  getAwsUrl() async {
    String fileType = "image/$extensionWithoutDot", folder_name = "Patient-Images";
    print('Image FileType is $fileType');
    print('Image FileType is $folder_name');
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
        uploadPatientProfilePic();
        // updateUI();
      } else {
        print("Failed to upload image. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("An error occurred: $e");
    }
  }

  void uploadPatientProfilePic() async {
    isLoading = true;
      var map = {
        'newprofilePicture': objectUrl,
      };
      print("Uploaded Profile Pic Map value is : $map");
    Upload_Profile_Picture_Response_Model model =
      await CallService().uploadProfilePic(map);
      String message = model.message.toString();
      print("Update Profile Response $message");
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
       updateUI();
    }

  Future<void> getSharedPreferenceValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    print("UserId Value is : $userId");
  }

  Future<void> completePatientRegistration(
      String name, String email,String phoneNumber,String problem,
      String DOB,String age,String gender,String country,
      String state,String city,String pinCode,String profession)
  async {
    var map = Map<String, dynamic>();
    map["fullName"]= name;
    map["email"]= email;
    map["phoneNumber"]= phoneNumber;
    map["currentFacingProb"]= problem;
    map["dateOfBirth"]= DOB;
    map["age"]= age;
    map["gender"]= gender;
    map["country"]= country;
    map["state"]= state;
    map["city"]= city;
    map["pincode"]= pinCode;
    map["profession"]= profession;
    print("Map value is :$map");
    isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      complete_Update_patientDetailsResponseModel model =
      await CallService().completeRegistration(map);
      isLoading = false;
      String message = model.message.toString();
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