import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ten_x_app/common/colors/colors.dart';
import '../common/commonButton/common_button.dart';
import '../common/commonText/common_text.dart';
import '../common/commonTextField/common_text_field.dart';
import '../common/string_constant.dart';
import 'registeration_done_screen.dart';

class PatientRegisterScreen extends StatefulWidget {
  const PatientRegisterScreen({super.key});

  @override
  State<PatientRegisterScreen> createState() => _PatientRegisterScreenState();
}

class _PatientRegisterScreenState extends State<PatientRegisterScreen> {
  String? selectedValue; // Holds the selected item
  List<String> items = ['Male', 'Female'];
  String formattedDate = "";
  DateTime selectedDate = DateTime.now();
  File? _image;
  final ImagePicker _picker = ImagePicker();

  final TextEditingController dueDateController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
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
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
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
                                  backgroundImage: _image != null
                                      ? FileImage(_image!)
                                      : null,
                                  child: _image == null
                                      ? Icon(
                                          Icons.person,
                                          size: 60,
                                          color: Colors.grey[600],
                                        )
                                      : null,
                                ),
                                Positioned(
                                  bottom: 10,
                                  right: 5,
                                  child: GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) => SafeArea(
                                          child: Wrap(
                                            children: <Widget>[
                                              ListTile(
                                                leading:
                                                    Icon(Icons.photo_camera),
                                                title: Text('Take a picture'),
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                  _pickImage(
                                                      ImageSource.camera);
                                                },
                                              ),
                                              ListTile(
                                                leading:
                                                    Icon(Icons.photo_library),
                                                title:
                                                    Text('Choose from gallery'),
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                  _pickImage(
                                                      ImageSource.gallery);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
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
                CommonText(text: StringConstant.per, fontSize: 20, fontFamily: 'Poppins', fontWeight: FontWeight.w500,),
                SizedBox(height: 20,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: CommonTextField(
                    hintText: 'Enter your first name',
                    text: 'First Name',
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
                    hintText: 'Enter your Last name',
                    text: 'last Name',
                    controller: lastNameController,
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
                    readOnly: false,
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
                        formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: CommonTextField(
                        hintText: 'Enter your Preferred Language',
                        text: 'Preferred Language',
                        controller: languageController,
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
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
                  mainAxisAlignment: MainAxisAlignment.center,
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
                CommonText(
                  text: StringConstant.eme,
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 20,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: CommonTextField(
                    hintText: 'Emergency Contact Name',
                    text: 'Emergency Contact Name',
                    controller: emergencyNameController,
                    inputType: TextInputType.text,
                    readOnly: false,
                    height: 50,
                    width: 380,),
                ),
                SizedBox(height: 10,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: CommonTextField(
                    hintText: 'Emergency Contact Number',
                    text: 'Emergency Contact Number',
                    controller: emergencyNumberController,
                    inputType: TextInputType.text,
                    readOnly: false,
                    height: 50,
                    width: 380,),
                ),
                SizedBox(height: 10,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: CommonTextField(
                    hintText: 'Emergency Relation',
                    text: 'Emergency Contact Relation',
                    controller: emergencyRelationController,
                    inputType: TextInputType.text,
                    readOnly: false,
                    height: 50,
                    width: 380,),
                ),
                SizedBox(height: 30,),
                CommonFirstButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=>RegistrationDoneScreen()),
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
}
