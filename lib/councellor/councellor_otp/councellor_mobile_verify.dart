// import 'package:flutter/material.dart';
// import 'package:flutter_dash/flutter_dash.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../auth/api_services/api_service.dart';
// import '../../auth/model/mobile_verify_response_model.dart';
// import '../../common/colors/colors.dart';
// import '../../common/commonButton/common_button_get_otp.dart';
// import '../../common/commonText/common_text.dart';
// import '../../common/commonText/common_text_colors.dart';
// import 'councellor_otp_verify.dart';
//
// class CounsellorMobileVerifyScreen extends StatefulWidget {
//   const CounsellorMobileVerifyScreen({super.key});
//
//   @override
//   State<CounsellorMobileVerifyScreen> createState() => _CounsellorMobileVerifyScreenState();
// }
//
// class _CounsellorMobileVerifyScreenState extends State<CounsellorMobileVerifyScreen> {
//   TextEditingController mobileController = TextEditingController();
//   bool isLoading = false;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 0),
//         child: SingleChildScrollView(
//           child: Column(
//             //mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Logo Animation (Top to Center)
//               Container(
//                 margin: EdgeInsets.only(top: 47,left: 20),
//                 width: double.infinity,
//                 alignment: Alignment.centerLeft,
//                 //color: Colors.red,
//                 child: Image.asset("assets/images/tenxLogo.png",height: 52,width: 144,),
//               ),
//               const SizedBox(height: 30),
//               // Image + Texts + Button (Shrink & Slide from Bottom)
//               Center(child: Image.asset("assets/images/counsellorLoginImage.png")),
//               const SizedBox(height: 30),
//               Container(
//                 height: MediaQuery.of(context).size.height*0.48,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: AppColors.white,
//                   borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       spreadRadius: 0,
//                       blurRadius: 4,
//                       offset: const Offset(0, -2),
//                     ),
//                   ],
//                 ),
//                 margin: const EdgeInsets.symmetric(horizontal: 0),
//                 child: Column(
//                   children: [
//                     SizedBox(height: 10,),
//                     CommonText(
//                       text: 'Therapy And Care',
//                       fontSize: 24,
//                       fontFamily: 'Poppins',
//                       fontWeight: FontWeight.w500,
//                     ),
//                     SizedBox(height: 5,),
//                     Container(
//                       //height: 42,
//                       width: MediaQuery.of(context).size.width*.7,
//                       child: CommonText(
//                           textAlign: TextAlign.center,
//                           text: "Seamless Appointments in Just Three Clicks.",
//                           fontSize: 14,
//                           fontFamily: "Poppins",
//                           fontWeight: FontWeight.w300
//                       ),
//                     ),
//                     SizedBox(height: 10,),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Dash(
//                           length: MediaQuery.of(context).size.width * 0.3,
//                           dashColor: AppColors.mediumGray1,
//                           dashLength: 10,
//                           dashThickness: 1,
//                           dashGap: 9,
//                         ),
//                         CommonTextColors(
//                           text: 'Log in or Sign up',
//                           fontSize: 14,
//                           fontFamily: 'Poppins',
//                           fontWeight: FontWeight.w300,
//                           color: AppColors.mediumGray1,
//                         ),
//                         Dash(
//                           length: MediaQuery.of(context).size.width * 0.3,
//                           dashColor: AppColors.mediumGray1,
//                           dashLength: 10,
//                           dashThickness: 1,
//                           dashGap: 9,
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20,),
//                     Center(
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 30),
//                         child: TextField(
//                           controller: mobileController,
//                           keyboardType: TextInputType.phone,
//                           decoration: InputDecoration(
//                             prefixIcon: Padding(
//                               padding:
//                               EdgeInsets.symmetric(horizontal: 8.0),
//                               child: Text(
//                                 '+91',
//                                 style: TextStyle(
//                                   fontSize: 17,
//                                   fontWeight: FontWeight.w500,
//                                   fontFamily: 'Poppins',
//                                 ),
//                               ),
//                             ),
//                             prefixIconConstraints:
//                             BoxConstraints(minWidth: 50),
//                             hintText: 'Mobile Number',
//                             hintStyle: TextStyle(
//                               fontFamily: 'Poppins',
//                               fontSize: 17,
//                               color: AppColors.gray,
//                               fontWeight: FontWeight.w300,
//                             ),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10.0),
//                               borderSide:
//                               BorderSide(color: Colors.orange),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 30,),
//                     CommonFirstButtonGetOtp(
//                       onPressed: (){
//                         String mobile = mobileController.text.toString();
//                         if(mobile.length<10){
//                           Fluttertoast.showToast(
//                               msg: "Please Enter 10 Digits of your Mobile Number",
//                               toastLength: Toast.LENGTH_LONG,
//                               gravity: ToastGravity.CENTER,
//                               timeInSecForIosWeb: 1,
//                               backgroundColor: Colors.black,
//                               textColor: Colors.white,
//                               fontSize: 16.0);
//                         }else {
//                           getOtp(mobile);
//                         }
//
//                       },
//                       text: 'Get OTP',
//                       height: 46,
//                       width: 210,
//                       fontSize: 20,
//                       fontFamily: 'Poppins',
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.black1,
//                       contenerColor: AppColors.melonPink,
//                       borderColor: AppColors.melonPink,
//                     ),
//                     SizedBox(height: 30,),
//                     CommonTextColors(
//                       text: 'By proceeding, you consent to share your information with 10X Ability and agree to our Privacy Policy and Terms of Service.',
//                       fontSize: 14,
//                       fontFamily: 'Poppins',
//                       textAlign: TextAlign.center,
//                       fontWeight: FontWeight.w300,
//                       color: AppColors.almostBlackishGray,
//                     ),
//                     SizedBox(height: 10,),
//                     // Row(
//                     //   mainAxisAlignment: MainAxisAlignment.center,
//                     //   children: [
//                     //     CommonTextColors(
//                     //         text: "Already have Account?",
//                     //         fontSize: 16,
//                     //         fontFamily: "Poppins",
//                     //         fontWeight: FontWeight.w300,
//                     //         color: AppColors.almostBlackishGray
//                     //     ),
//                     //     CommonTextColors(
//                     //         text: "Log In Here",
//                     //         fontSize: 16,
//                     //         fontFamily: "Poppins",
//                     //         fontWeight: FontWeight.w300,
//                     //         color: AppColors.redOrange
//                     //     ),
//                     //   ],
//                     // )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> getOtp(String mobileNumber) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? userType = prefs.getString('userType');
//     print("User Access Token Value is : $userType");
//     var map = Map<String, dynamic>();
//     map['phoneNo'] = mobileNumber;
//     map['userType'] = userType;
//     print("User Access Token Value is : $map");
//     isLoading = true;
//     WidgetsBinding.instance
//         .addPostFrameCallback((_) async {
//       Mobile_Verify_Response_Model model =
//       await CallService()
//           .userLogin(map);
//       isLoading = false;
//       String message = model.message.toString();
//       String otp = model.otpdata.toString();
//       print("Otp Value is : $otp");
//       Fluttertoast.showToast(
//           msg: message,
//           toastLength: Toast.LENGTH_LONG,
//           gravity: ToastGravity.CENTER,
//           timeInSecForIosWeb: 1,
//           backgroundColor: Colors.black,
//           textColor: Colors.white,
//           fontSize: 16.0);
//       Navigator.pop(context);
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => CounsellorOtpScreen(mobileNumber)),
//       );
//       // _animationController.forward().then((_) {
//       //   Navigator.push(
//       //     context,
//       //     MaterialPageRoute(builder: (context) => PatientOtpScreen(mobileNumber)),
//       //   );
//       // });
//     });
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../auth/api_services/api_service.dart';
import '../../auth/model/counsellor_otp_verify_response_model.dart';
import '../../auth/model/mobile_verify_response_model.dart';
import '../../common/colors/colors.dart';
import '../../common/commonButton/common_button.dart';
import '../../common/commonButton/common_button_get_otp.dart';
import '../../common/commonText/common_text.dart';
import '../../common/commonText/common_text_colors.dart';
import '../councellor_Home/counsellor_dashboard.dart';
import '../councellor_Home/counsellor_status_scrren.dart';
import '../councellor_register/counsellor_register.dart';

class CounsellorMobileVerifyScreen extends StatefulWidget {
  const CounsellorMobileVerifyScreen({super.key});

  @override
  State<CounsellorMobileVerifyScreen> createState() =>
      _CounsellorMobileVerifyScreenState();
}

class _CounsellorMobileVerifyScreenState
    extends State<CounsellorMobileVerifyScreen> {
  TextEditingController mobileController = TextEditingController();
  List<TextEditingController> otpController =
      List.generate(6, (index) => TextEditingController());
  String otp = "", mobilePhone = "",_otpValue = "";
  bool isLoading = false;
  bool showOtpScreen = false; // Track which screen to show

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo
              Container(
                margin: EdgeInsets.only(top: 47, left: 20),
                width: double.infinity,
                alignment: Alignment.centerLeft,
                child: Image.asset("assets/images/tenxLogo.png",
                    height: 52, width: 144),
              ),
              const SizedBox(height: 30),

              Center(
                  child: Image.asset("assets/images/counsellorLoginImage.png")),
              const SizedBox(height: 20),

              // Animated Switcher for Smooth Transition
              AnimatedSwitcher(
                duration:
                    Duration(milliseconds: 500), // Smooth transition duration
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset(0, 1), // Start from bottom
                      end: Offset(0, 0), // Move to center
                    ).animate(animation),
                    child: child,
                  );
                },
                child: showOtpScreen ? otpContainer(_otpValue) : mobileNumberContainer(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Mobile Number Input Container
  Widget mobileNumberContainer() {
    return Container(
      key: ValueKey(1), // Unique key for AnimatedSwitcher
      height: MediaQuery.of(context).size.height * 0.48,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(0, -2)),
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        children: [
          SizedBox(height: 20),
          CommonText(
              text: 'Therapy And Care',
              fontSize: 24,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500),
          SizedBox(height: 5),
          Container(
            width: MediaQuery.of(context).size.width * .7,
            child: CommonText(
              textAlign: TextAlign.center,
              text: "Seamless Appointments in Just Three Clicks.",
              fontSize: 14,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Dash(
                length: MediaQuery.of(context).size.width * 0.3,
                dashColor: AppColors.mediumGray1,
                dashLength: 10,
                dashThickness: 1,
                dashGap: 9,
              ),
              CommonTextColors(
                text: 'Log in or Sign up',
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w300,
                color: AppColors.mediumGray1,
              ),
              Dash(
                length: MediaQuery.of(context).size.width * 0.3,
                dashColor: AppColors.mediumGray1,
                dashLength: 10,
                dashThickness: 1,
                dashGap: 9,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: mobileController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('+91',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins')),
                ),
                prefixIconConstraints: BoxConstraints(minWidth: 50),
                hintText: 'Mobile Number',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.orange)),
              ),
            ),
          ),
          SizedBox(height: 20),
          CommonFirstButtonGetOtp(
            onPressed: () {
              mobilePhone = mobileController.text.toString();
              if (mobilePhone.length < 10) {
                Fluttertoast.showToast(
                  msg: "Please Enter 10 Digits of your Mobile Number",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              } else {
                getOtp(mobilePhone);
              }
            },
            text: 'Get OTP',
            height: 45,
            width: 210,
            fontSize: 20,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            color: AppColors.black1,
            contenerColor: AppColors.melonPink,
            borderColor: AppColors.melonPink,
          ),
          SizedBox(
            height: 20,
          ),
          CommonTextColors(
            text:
                'By proceeding, you consent to share your information with 10X Ability and agree to our Privacy Policy and Terms of Service.',
            fontSize: 14,
            fontFamily: 'Poppins',
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w300,
            color: AppColors.almostBlackishGray,
          ),
        ],
      ),
    );
  }

  // OTP Verification Container
  Widget otpContainer(String otpValue) {
    return Container(
      key: ValueKey(2), // Unique key for AnimatedSwitcher
      height: MediaQuery.of(context).size.height * 0.48,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(0, -2)),
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        children: [
          SizedBox(height: 30),
          CommonText(
              text: 'OTP Verification',
              fontSize: 36,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500),
          SizedBox(height: 5),
          CommonTextColors(
              text: 'You will get a OTP via SMS on',
              fontSize: 14,
              fontWeight: FontWeight.w300,
              fontFamily: 'Poppins',
              color: AppColors.darkGray),
          SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonTextColors(
                  text: '+91-${mobilePhone}',
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.redOrange),
              CommonTextColors(
                text: ' Edit ',
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w300,
                textDecoration: TextDecoration.underline,
                decorationColor: AppColors.black,
                color: AppColors.black,
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                6, (index) => otpInputField(TextEditingController(), index,otpValue)),
          ),
          SizedBox(height: 30),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonTextColors(
                text: "Didn't Received OTP?",
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w300,
                color: AppColors.black,
              ),
              CommonTextColors(
                text: ' Resend OTP ',
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                color: AppColors.redOrange,
              ),
            ],
          ),
          SizedBox(height: 30,),
          CommonFirstButton(
            onPressed: () {
              if (otpValue.length == 6) {
                submitOTP(mobilePhone);
              } else {
                Fluttertoast.showToast(
                    msg: "Enter 6 Digits of Otp",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            },
            text: 'Verify & Continue',
            height: 46,
            width: 256,
            fontSize: 20,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            color: AppColors.white,
          ),
        ],
      ),
    );
  }

  // Function to handle OTP request
  Future<void> getOtp(String mobileNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userType = prefs.getString('userType');
    var map = {"phoneNo": mobileNumber, "userType": userType};
    print("Map value is $map");
    Mobile_Verify_Response_Model model = await CallService().userLogin(map);
    String message = model.message.toString();
    otp = model.otpdata.toString();
    print("Otp value is $otp");
    setState(() {
      _otpValue = otp; // OTP ko store karna
      showOtpScreen = true; // Show OTP container when OTP is requested
    });
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
  }

  Widget otpInputField(TextEditingController controller1, int index, String otpValue) {
    return Expanded(
        child: Container(
      width: 50,
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.redOrange),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller1,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1, // Restrict input to a single digit
        decoration: const InputDecoration(
          border: InputBorder.none,
          counterText: '', // Hides the character count below the box
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            if (index < otpController.length - 1) {
              FocusScope.of(context).nextFocus();
            } else {
              otpValue = otpController.map((c) => c.text).join();
              print("New Otp value is $otpValue");
            }
          } else if (value.isEmpty) {
            if (index > 0) {
              FocusScope.of(context).previousFocus();
            }
          }
        },
      ),
    ));
  }

  Future<void> submitOTP(String mobileNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userType = prefs.getString('userType');
    print("User Type Value is : $userType");
    var map = Map<String, dynamic>();
    map['phoneNo'] = mobileNumber;
    map['otp'] = _otpValue;
    map['userType'] = userType;
    print("Otp Verify Value is : $map");
    isLoading = true;
    WidgetsBinding.instance
        .addPostFrameCallback((_) async {
      CounsellorOtpVerifyResponseModel model =
      await CallService().verifyOtp(map);
      isLoading = false;
      String message = model.message.toString();
      String id = model.data!.id.toString();
      String status = model.data!.profileStatus.toString();
      String mobileNo = model.data!.phoneNumber.toString();
      String userType = model.data!.userType.toString();
      String accessToken = model.data!.accessToken.toString();
      print("Counsellor's userProfileStatus $status");
      print("Counsellor's Details $message");
      print("Counsellor's Id $id");
      print("Counsellor's mobileNo $mobileNo");
      print("Counsellor's accessToken $accessToken");
      print("Counsellor's userType $userType");

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("userId", id);
      await prefs.setString('userMobileNumber', mobileNo);
      await prefs.setString("userToken", accessToken);
      await prefs.setString("userType", userType);
      await prefs.setString("profileStatus", status);
      //profileStatus = profileStatus.toUpperCase(); // normalize string just in case
      print("Verified profile status: '$status'");
      if (status == "PENDING_REGISTRATION") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CounsellorRegister()),
        );
      } else if (status == "APPROVED") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CounsellorDashboard()),
        );
      } else if (["PENDING_APPROVAL", "REJECTED", "SUSPENDED"].contains(
          status)) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CounsellorStatusScreen()),
        );
      } else {
        // Fallback for unexpected status
        Fluttertoast.showToast(
          msg: "Unknown profile status. Please contact support.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    });
  }
}
