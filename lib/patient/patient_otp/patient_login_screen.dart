import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../auth/api_services/api_service.dart';
import '../../auth/model/mobile_verify_response_model.dart';
import '../../common/colors/colors.dart';
import '../../common/commonButton/common_button_get_otp.dart';
import '../../common/commonText/common_text.dart';
import '../../common/commonText/common_text_colors.dart';
import '../../common/string_constant.dart';
import 'patient_otp_screen.dart';

class PatientLoginScreen extends StatefulWidget {
  const PatientLoginScreen({super.key});

  @override
  State<PatientLoginScreen> createState() => _PatientLoginScreenState();
}

class _PatientLoginScreenState extends State<PatientLoginScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController mobileController = TextEditingController();

  late AnimationController _animationController;
  late Animation<Offset> _logoSlideAnimation;
  late Animation<double> _logoFadeAnimation;
  late Animation<Offset> _containerSlideAnimation;
  late Animation<double> _containerFadeAnimation;
  bool _startAnimation = false;
  bool isLoading = false;


  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );

    _logoSlideAnimation = Tween<Offset>(
      begin: Offset(0.0, 0.0),
      end: Offset(0.0, -0.5),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _logoFadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _containerSlideAnimation = Tween<Offset>(
      begin: Offset(0.0, 0.0),
      end: Offset(0.0, 1.2),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _containerFadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  void _startAnimations() {
    setState(() {
      _startAnimation = true;
    });
    String mobile = mobileController.text.toString();
    if(mobile.length<10){
      Fluttertoast.showToast(
          msg: "Please Enter 10 Digits of your Mobile Number",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }else {
      getOtp(mobile);
    }

  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/patientRegImage.png",
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
          /// 👇 **Logo को Positioned से ऊपर दिखने के लिए सेट किया गया है**
          Positioned(
            top: MediaQuery.of(context).size.height * 0.3, // Initially Center
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _logoFadeAnimation,
                  child: SlideTransition(
                    position: _logoSlideAnimation,
                    child: Center( /// 👈 Center में रखने के लिए
                      child: Container(
                        height: 114,
                        width: 293,
                        child: Image.asset("assets/images/patientRegImg.png"),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _containerFadeAnimation,
                  child: SlideTransition(
                    position: _containerSlideAnimation,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                      ),
                      height: MediaQuery.of(context).size.height * 0.55,
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          CommonText(
                            text: StringConstant.therapy,
                            fontSize: 24,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(height: 10),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 35),
                            child: CommonText(
                              text: StringConstant.find,
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                width: 20,
                              ),
                              Flexible(
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    return Row(
                                      children: List.generate(
                                        8, // Adjust number of dashes
                                            (index) => Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 2),
                                            child: Text(
                                              '-',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: AppColors.gray,
                                                fontSize:
                                                18, // Adjust size for dashes
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              CommonTextColors(
                                text: StringConstant.log,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w300,
                                color: Colors.grey.shade600,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Flexible(
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    return Row(
                                      children: List.generate(
                                        8, // Adjust number of dashes
                                            (index) => Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 2),
                                            child: Text(
                                              '-',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: AppColors.gray,
                                                fontSize:
                                                18, // Adjust size for dashes
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: TextField(
                                controller: mobileController,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text(
                                      '+91',
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                  prefixIconConstraints:
                                  BoxConstraints(minWidth: 50),
                                  hintText: 'Mobile Number',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 17,
                                    color: AppColors.gray,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                    BorderSide(color: Colors.orange),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          CommonFirstButtonGetOtp(
                            onPressed: _startAnimations,
                            text: 'Get OTP',
                            height: 46,
                            width: 210,
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            color: AppColors.black1,
                            contenerColor: AppColors.melonPink,
                            borderColor: AppColors.melonPink,
                          ),
                          SizedBox(height: 10),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 25),
                            child: CommonText(
                              text: StringConstant.proceeding,
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(height: 10),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     CommonText(
                          //       text: StringConstant.already,
                          //       fontSize: 16,
                          //       fontFamily: 'Poppins',
                          //       fontWeight: FontWeight.w300,
                          //     ),
                          //     SizedBox(width: 5),
                          //     CommonTextColors(
                          //       text: StringConstant.logIn,
                          //       fontSize: 16,
                          //       fontFamily: 'Poppins',
                          //       fontWeight: FontWeight.w300,
                          //       color: AppColors.redOrange,
                          //       textDecoration: TextDecoration.underline,
                          //       decorationColor: AppColors.redOrange,
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getOtp(String mobileNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userType = prefs.getString('userType');
    print("User Access Token Value is : $userType");
    var map = Map<String, dynamic>();
    map['phoneNo'] = mobileNumber;
    map['userType'] = userType;
    print("User Access Token Value is : $map");
    isLoading = true;
    WidgetsBinding.instance
        .addPostFrameCallback((_) async {
      Mobile_Verify_Response_Model model =
      await CallService()
          .userLogin(map);
      isLoading = false;
      String message = model.message.toString();
      String otp = model.otpdata.toString();
      print("Otp Value is : $otp");
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      // Navigator.pop(context);
      _animationController.forward().then((_) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PatientOtpScreen(mobileNumber)),
        );
      });
    });
  }
}
