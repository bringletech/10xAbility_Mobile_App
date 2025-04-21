import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../auth/api_services/api_service.dart';
import '../../auth/model/edit_user_profile_response_model.dart';
import '../../auth/model/get_current_user_details_response_model.dart';
import '../../common/colors/colors.dart';
import '../../common/commonButton/common_button.dart';
import '../../common/commonText/common_text.dart';
import '../../common/commonTextField/common_text_field.dart';
import '../../common/string_constant.dart';
class EditProfilePatient extends StatefulWidget {
  const EditProfilePatient({super.key});

  @override
  State<EditProfilePatient> createState() => _EditProfilePatientState();
}

class _EditProfilePatientState extends State<EditProfilePatient> {

  String? selectedValue; // Holds the selected item
  List<String> items = ['MALE', 'FEMALE'];

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
       // fileName = p.basename(photo.path); // Get file name with extension
       // String extension = p.extension(photo.path); // Get extension with dot
       // extensionWithoutDot = extension.substring(1); // Remove dot
        print("File Name: $fileName");
        print("File Extension (with dot): $extension");
        print("File Extension (without dot): $extensionWithoutDot");
      });

      // Auto upload image after selection
     // await getAwsUrl();
    }
  }


  void currentUserDetails() {
    setState(() {
      isLoading = true;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        GetCurrentUserResponseModel model =
        await CallService().getCurrentUserDetails();
        setState(() {
          isLoading = false;
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


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentUserDetails();
  }
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
      child: CircularProgressIndicator(color: AppColors.darkOrange),
    ):Scaffold(
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
                    hintText: 'Enter Your Name',
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
                    readOnly: true,
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
                        print("Date Value is : $formattedDate");
                        setState(() {dueDateController.text = formattedDate;});
                        value:formattedDate;}
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
                    updateUserData();
                  },
                  text: 'Save',
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


  void updateUserData() async {
    name = firstNameController.text.toString();
    email = emailController.text.toString();
    problem = problemController.text.toString();
    DOB = birthController.text.toString();
    age = ageController.text.toString();
    country = countryController.text.toString();
    state = stateController.text.toString();
    city = cityController.text.toString();
    pinCode = pinCodeController.text.toString();
    profession = professionController.text.toString();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userType = prefs.getString('userType');
    print("UserType value is: $userType");
    var map = {
      "fullName": name,
      "email": email,
      "phoneNumber": phoneNumber,
      "currentFacingProb": problem,
      "dateOfBirth": DOB,
      "age": age,
      "gender": gender,
      "country": country,
      "state": state,
      "city": city,
      "pincode": pinCode,
      "profession": profession
    };

    print("Map value is $map");
    setState(() {
      isLoading = true; // Start loading
    });

    try {
      EditUserProfileDetailsResponseModel model =
      await CallService().editUserDetails(map);

      String message = model.message.toString();
      name = model.data!.fullName.toString();
      email = model.data!.email.toString();
      problem = model.data!.currentFacingProb.toString();
      DOB = model.data!.dateOfBirth.toString();
      age = model.data!.age.toString();
      country = model.data!.country.toString();
      state = model.data!.state.toString();
      city = model.data!.city.toString();
      pinCode = model.data!.pincode.toString();
      profession = model.data!.profession.toString();

      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      // Get.back();
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

}
