// import 'package:flutter/material.dart';
// import '../common/colors/colors.dart';
// import '../common/commonButton/common_button.dart';
// import '../common/commonText/common_text.dart';
// import '../common/commonText/common_text_colors.dart';
// import '../common/string_constant.dart';
// import 'patient_register_screen.dart';
//
// class PatientOtpScreen extends StatefulWidget {
//   const PatientOtpScreen({super.key});
//
//   @override
//   State<PatientOtpScreen> createState() => _PatientOtpScreenState();
// }
//
// class _PatientOtpScreenState extends State<PatientOtpScreen>
//     with SingleTickerProviderStateMixin {
//   final TextEditingController otpController = TextEditingController();
//   late AnimationController _animationController;
//   late Animation<double> _bgFadeAnimation;
//   late Animation<Offset> _bgSlideAnimation;
//   late Animation<Offset> _containerSlideAnimation;
//   late Animation<double> _containerFadeAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 500),
//       vsync: this,
//     );
//
//     /// **Background Image Animation (Slide Up & Fade)**
//     _bgFadeAnimation = Tween<double>(
//       begin: 1.0,
//       end: 0.0,
//     ).animate(_animationController);
//
//     _bgSlideAnimation = Tween<Offset>(
//       begin: Offset.zero,
//       end: const Offset(0.0, -1.0),
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeInOut,
//     ));
//
//     /// **Bottom Sheet Animation (Slide Down & Fade)**
//     _containerSlideAnimation = Tween<Offset>(
//       begin: Offset.zero,
//       end: const Offset(0.0, 1.2),
//     ).animate(_animationController);
//
//     _containerFadeAnimation = Tween<double>(
//       begin: 1.0,
//       end: 0.0,
//     ).animate(_animationController);
//   }
//
//   void _startAnimations() {
//     _animationController.forward().then((_) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const PatientRegisterScreen()),
//       );
//     });
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           /// **Background Image (Slide Up & Fade Out)**
//           Positioned.fill(
//             child: AnimatedBuilder(
//               animation: _animationController,
//               builder: (context, child) {
//                 return FadeTransition(
//                   opacity: _bgFadeAnimation,
//                   child: SlideTransition(
//                     position: _bgSlideAnimation,
//                     child: Image.asset(
//                       "assets/images/patientRegImage.png",
//                       fit: BoxFit.cover,
//                       alignment: Alignment.center,
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//
//           /// **OTP Bottom Sheet (Slide Down & Fade Out)**
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: AnimatedBuilder(
//               animation: _animationController,
//               builder: (context, child) {
//                 return FadeTransition(
//                   opacity: _containerFadeAnimation,
//                   child: SlideTransition(
//                     position: _containerSlideAnimation,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: AppColors.white,
//                         borderRadius: const BorderRadius.only(
//                           topLeft: Radius.circular(30),
//                           topRight: Radius.circular(30),
//                         ),
//                       ),
//                       height: MediaQuery.of(context).size.height * 0.50,
//                       padding: const EdgeInsets.symmetric(horizontal: 20),
//                       child: Column(
//                         children: [
//                           const SizedBox(height: 40),
//                           CommonText(
//                             text: StringConstant.otp,
//                             fontSize: 36,
//                             fontFamily: 'Poppins',
//                             fontWeight: FontWeight.w500,
//                           ),
//                           const SizedBox(height: 20),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               CommonTextColors(
//                                 text: 'You will get an OTP via',
//                                 fontSize: 14,
//                                 fontFamily: 'Poppins',
//                                 fontWeight: FontWeight.w300,
//                                 color: AppColors.darkGray,
//                               ),
//                               CommonTextColors(
//                                 text: ' SMS ',
//                                 fontSize: 14,
//                                 fontFamily: 'Poppins',
//                                 fontWeight: FontWeight.w500,
//                                 color: AppColors.darkGray,
//                               ),
//                               CommonTextColors(
//                                 text: 'on',
//                                 fontSize: 14,
//                                 fontFamily: 'Poppins',
//                                 fontWeight: FontWeight.w300,
//                                 color: AppColors.darkGray,
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 20),
//                           CommonTextColors(
//                             text: '+91-9876543210 Edit',
//                             fontSize: 14,
//                             fontFamily: 'Poppins',
//                             fontWeight: FontWeight.w500,
//                             color: AppColors.redOrange,
//                           ),
//                           const SizedBox(height: 30),
//
//                           /// **OTP Input Fields**
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: List.generate(4, (index) {
//                               return Container(
//                                 width: 50,
//                                 height: 50,
//                                 margin: const EdgeInsets.symmetric(horizontal: 5),
//                                 decoration: BoxDecoration(
//                                   border: Border.all(color: AppColors.redOrange),
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 child: TextField(
//                                   controller: otpController,
//                                   textAlign: TextAlign.center,
//                                   maxLength: 1,
//                                   keyboardType: TextInputType.number,
//                                   decoration: const InputDecoration(
//                                     border: InputBorder.none,
//                                     counterText: '',
//                                   ),
//                                 ),
//                               );
//                             }),
//                           ),
//                           const SizedBox(height: 40),
//
//                           /// **Resend OTP**
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               CommonTextColors(
//                                 text: "Didn't Receive OTP?",
//                                 fontSize: 14,
//                                 fontFamily: 'Poppins',
//                                 fontWeight: FontWeight.w300,
//                                 color: AppColors.black,
//                               ),
//                               CommonTextColors(
//                                 text: ' Resend OTP ',
//                                 fontSize: 14,
//                                 fontFamily: 'Poppins',
//                                 fontWeight: FontWeight.w500,
//                                 color: AppColors.redOrange,
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 40),
//
//                           /// **Verify & Continue Button**
//                           CommonFirstButton(
//                             onPressed: _startAnimations,
//                             text: 'Verify & Continue',
//                             height: 46,
//                             width: 256,
//                             fontSize: 20,
//                             fontFamily: 'Poppins',
//                             fontWeight: FontWeight.w500,
//                             color: AppColors.white,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../common/colors/colors.dart';
import '../common/commonButton/common_button.dart';
import '../common/commonText/common_text.dart';
import '../common/commonText/common_text_colors.dart';
import '../common/string_constant.dart';
import 'patient_register_screen.dart';

class PatientOtpScreen extends StatefulWidget {
  const PatientOtpScreen({super.key});

  @override
  State<PatientOtpScreen> createState() => _PatientOtpScreenState();
}

class _PatientOtpScreenState extends State<PatientOtpScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController otpController = TextEditingController();
  late AnimationController _animationController;
  late Animation<Offset> _logoSlideAnimation;
  late Animation<double> _logoFadeAnimation;
  late Animation<Offset> _containerSlideAnimation;
  late Animation<double> _containerFadeAnimation;
  bool _startAnimation = false;

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
    _animationController.forward().then((_) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PatientRegisterScreen()),
      );
    });
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
          // Back Button and Doctor's Image
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
                    child: Center(
                      /// 👈 Center में रखने के लिए
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
                            margin: EdgeInsets.only(
                                top: 350, bottom: 0, left: 0, right: 0),
                            height: MediaQuery.of(context).size.height * 0.60,
                            // height: 500,
                            // width: 360,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 40,
                                  width: 360,
                                ),
                                CommonText(
                                  text: StringConstant.otp,
                                  fontSize: 36,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                                SizedBox(height: 20),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CommonTextColors(
                                      text: 'You will get a OTP via',
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w300,
                                      color: AppColors.darkGray,
                                    ),
                                    CommonTextColors(
                                      text: ' SMS ',
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.darkGray,
                                    ),
                                    CommonTextColors(
                                      text: 'on',
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w300,
                                      color: AppColors.darkGray,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CommonTextColors(
                                      text: '+91-9876543210',
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.redOrange,
                                    ),
                                    CommonTextColors(
                                      text: ' Edit ',
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w300,
                                      color: AppColors.black,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 30),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(4, (index) {
                                    return Container(
                                      width: 50,
                                      height: 50,
                                      margin:
                                      EdgeInsets.symmetric(horizontal: 5),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.redOrange),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: TextField(
                                        controller: otpController,
                                        textAlign: TextAlign.center,
                                        maxLength: 1,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          counterText: '',
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
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
                                SizedBox(
                                  height: 40,
                                ),
                                CommonFirstButton(
                                  onPressed: _startAnimations,
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
                          ),
                        ));
                  })),
        ],
      ),
    );
  }
}