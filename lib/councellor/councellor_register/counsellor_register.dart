import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/mult_select_dialog.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ten_x_app/common/colors/colors.dart';
import 'package:ten_x_app/common/commonText/common_text_colors.dart';
import '../../auth/api_services/api_service.dart';
import '../../auth/model/aws_response_model.dart';
import '../../auth/model/upload_profile_picture_response_model.dart';
import '../../common/commonButton/common_button.dart';
import '../../common/commonText/common_text.dart';
import '../../common/commonTextField/common_text_field.dart';
import 'register_next.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

class CounsellorRegister extends StatefulWidget {
  const CounsellorRegister({super.key});

  @override
  State<CounsellorRegister> createState() => _CounsellorRegisterState();
}

class _CounsellorRegisterState extends State<CounsellorRegister> {
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

  final TextEditingController dueDateController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
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

  List<String> _selectedLanguages = [];
  final List<String> _languages = ['English', 'Hindi', 'Marathi', 'Gujarati', 'Punjabi'];

  void _openLanguageDialog() {
    List<String> tempSelected = List.from(_selectedLanguages);

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text("Select Preferred Languages"),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _languages.length,
              itemBuilder: (ctx, index) {
                String lang = _languages[index];
                bool isSelected = tempSelected.contains(lang);

                return ListTile(
                  onTap: () {
                    setState(() {
                      isSelected
                          ? tempSelected.remove(lang)
                          : tempSelected.add(lang);
                    });
                    // To reflect immediate visual feedback
                    (ctx as Element).markNeedsBuild();
                  },
                  contentPadding: EdgeInsets.zero,
                  leading: isSelected
                      ? Icon(Icons.check, color: Colors.red)
                      : SizedBox(width: 24), // Empty space for alignment
                  title: Text(lang),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("CANCEL", style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _selectedLanguages = tempSelected;
                });
                Navigator.of(context).pop();
              },
              child: Text("OK", style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  void _removeLanguage(String lang) {
    setState(() {
      _selectedLanguages.remove(lang);
    });
  }
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

  void updateUI() {
    setState(() {});
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 25, left: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                              onTap: () {},
                              child: Icon(
                                Icons.arrow_back_outlined,
                                color: AppColors.redOrange,
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonText(
                                  text: 'Multi-Step Form',
                                  fontSize: 20,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                                CommonTextColors(
                                    text: 'Step 1 of 3',
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.mediumDarkGray)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 45,right: 15
                      ),
                      child: GestureDetector(
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
                        },
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(20),
                          dashPattern: [6, 3],
                          color: AppColors.darkOrange,
                          strokeWidth: 1,
                          child: Container(
                            width: 102,
                            height: 108,
                            padding: EdgeInsets.all(10),
                            // alignment: Alignment.center,
                            child: _image == null
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CommonText(
                                        text: "Profile Picture",
                                        fontSize: 7,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Poppins',
                                      ),
                                      SizedBox(height: 8),
                                      CommonTextColors(
                                        text:
                                            "Click To Upload Or Drag And Drop",
                                        fontSize: 5.9,
                                        color: AppColors.redOrange,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Poppins',
                                      ),
                                      SizedBox(height: 8),
                                      CommonTextColors(
                                        text:
                                            "Only png and jpg file formats are allowed. Max resolution: 1000x1000.",
                                        fontSize: 5.16,
                                        color: AppColors.mediumDarkGray,
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
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: CommonTextField(
                    hintText: 'Enter your full name',
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
                    readOnly: false,
                    height: 50,
                    width: 380,),
                ),
                SizedBox(height: 10,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Preferred Language",
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 5,),
                      GestureDetector(
                        onTap: _openLanguageDialog,
                        child: Container(
                          width: 380,height: 50,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: AppColors.redOrange
                              )
                          ),
                          child: _selectedLanguages.isEmpty
                              ? Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text("Select Languages",
                                  style: TextStyle(color: Colors.grey[600],fontSize: 12),
                                ),
                              )
                              : Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: _selectedLanguages.map((lang) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: AppColors.redOrange)
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      lang,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(width: 6),
                                    GestureDetector(
                                      onTap: () => _removeLanguage(lang),
                                      child: Icon(
                                        Icons.close,
                                        size: 16,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: CommonTextField(
                        hintText: formattedDate.isEmpty ?'noDateSelected' : formattedDate.toString(),
                        text: 'Date Of Birth',
                        controller: birthController,
                        inputType: TextInputType.text,
                        readOnly: true,
                        height: 50,
                        width: 155,
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
                      ),
                    ),
                    SizedBox(width: 10,),
                    Container(
                     margin: EdgeInsets.only(right: 20),
                      child: CommonTextField(
                        hintText: 'Age',
                        text: 'Age',
                        controller: ageController,
                        inputType: TextInputType.text,
                        readOnly: true,
                        height: 50,
                        width: 155,),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20),
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
                            //margin: EdgeInsets.only(right: 20),
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
                Container(
                  alignment: Alignment.centerLeft,
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
                SizedBox(height: 10,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment. start,
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
                SizedBox(height: 10,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: CommonTextField(
                    hintText: 'Bio',
                    text: 'Bio',
                    controller: bioController,
                    inputType: TextInputType.text,
                    readOnly: false,
                    height: 50,
                    width: 380,),
                ),
                SizedBox(height: 30,),
                CommonFirstButton(
                  onPressed: () {
                   // _saveStepOneData();
                    String fullName = firstNameController.text.toString().trim();
                    String email = emailController.text.toString().trim();
                    String mobile = mobileController.text.toString().trim();
                    String age = ageController.text.toString().trim();
                    String state = stateController.text.toString().trim();
                    String country = countryController.text.toString().trim();
                    String city = cityController.text.toString().trim();
                    String pincode = pinCodeController.text.toString().trim();
                    String bio = bioController.text.toString().trim();
                    String profilePicture = objectUrl;

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=>RegisterNext(fullName:fullName,
                          email:email, mobile:mobile,language:_languages,dob:formattedDate,age:age,
                        gender:selectedValue!,state:state,city: city, country:country,pincode:pincode,bio:bio,
                          profilePicture:objectUrl
                      )
                      ),
                    );
                  },
                  text: 'Next',
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
    String fileType = "image/$extensionWithoutDot", folder_name = "Therapist-Images";
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


  void _saveStepOneData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('fullName', firstNameController.text);
    await prefs.setString('email', emailController.text);
    await prefs.setString('mobile', mobileController.text);
    await prefs.setStringList('languages', _selectedLanguages);
    await prefs.setString('dob', birthController.text);
    await prefs.setString('age', ageController.text);
    await prefs.setString('gender', selectedValue ?? '');
    await prefs.setString('state', stateController.text);
    await prefs.setString('country', countryController.text);
    await prefs.setString('city', cityController.text);
    await prefs.setString('pinCode', pinCodeController.text);
    await prefs.setString('bio', languageController.text);
    await prefs.setString('profileImage', objectUrl); // If you want to save uploaded image URL
  }

}
