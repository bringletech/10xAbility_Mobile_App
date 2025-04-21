import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/colors/colors.dart';
import '../common/commonButton/common_button.dart';
import '../common/commonText/common_text.dart';
import '../councellor/councellor_otp/councellor_mobile_verify.dart';
import '../patient/patient_introduction/patient_introduction.dart';

class UserTypeScreen extends StatefulWidget {
  const UserTypeScreen({super.key});

  @override
  State<UserTypeScreen> createState() => _UserTypeScreenState();
}

class _UserTypeScreenState extends State<UserTypeScreen> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<Offset> _logoSlide;
  late Animation<double> _logoFade;
  late AnimationController _textController;
  late Animation<double> _textFade;
  late Animation<Offset> _textSlide;
  late AnimationController _buttonController;
  late Animation<Offset> _buttonSlide;
  late Animation<double> _buttonFade;

  double _buttonOpacity = 1.0; // Initially visible

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _logoSlide = Tween<Offset>(begin: const Offset(0, -2), end: Offset.zero).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOut),
    );
    _logoFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeIn),
    );

    _textController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _textFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeIn),
    );
    _textSlide = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOut),
    );

    _buttonController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _buttonSlide = Tween<Offset>(begin: const Offset(0, 1.5), end: Offset.zero).animate(
      CurvedAnimation(parent: _buttonController, curve: Curves.easeOut),
    );
    _buttonFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _buttonController, curve: Curves.easeIn),
    );

    _startAnimations();
  }

  void _startAnimations() async {
    await _logoController.forward();
    await Future.delayed(const Duration(milliseconds: 100));
    await _textController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    _buttonController.forward();
  }

  Future<void> _saveUserType(String userType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userType', userType);
  }

  void _hideAllAndNavigate(VoidCallback onComplete) async {
    await Future.wait([
      _buttonController.reverse(),
      _logoController.reverse(),
      _textController.reverse(),
    ]);
    await Future.delayed(const Duration(milliseconds: 300));
    onComplete();
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SlideTransition(
                  position: _logoSlide,
                  child: FadeTransition(
                    opacity: _logoFade,
                    child: SizedBox(
                      height: 90,
                      width: 266,
                      child: Image.asset("assets/images/tenxLogo.png"),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                SlideTransition(
                  position: _textSlide,
                  child: FadeTransition(
                    opacity: _textFade,
                    child: CommonText(
                      text: 'Log In As',
                      fontSize: 32,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                AnimatedOpacity(
                  opacity: _buttonOpacity,
                  duration: const Duration(milliseconds: 500),
                  child: Column(
                    children: [
                      SlideTransition(
                        position: _buttonSlide,
                        child: FadeTransition(
                          opacity: _buttonFade,
                          child: CommonFirstButton(
                            onPressed: () async {
                              await _saveUserType("patient");
                              _hideAllAndNavigate(() {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => PatientIntroduction()),
                                );
                              });
                            },
                            text: 'User',
                            height: 55,
                            width: 244,
                            imageUrl: "assets/svgIcon/patientIcon.svg",
                            fontSize: 24,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      SlideTransition(
                        position: _buttonSlide,
                        child: FadeTransition(
                          opacity: _buttonFade,
                          child: CommonFirstButton(
                            onPressed: () async {
                              await _saveUserType("therapist");
                              _hideAllAndNavigate(() {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => CounsellorMobileVerifyScreen(

                                  )),
                                );
                              });
                            },
                            text: 'Counsellor',
                            height: 55,
                            width: 244,
                            imageUrl: "assets/svgIcon/counsellorIcon.svg",
                            fontSize: 24,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
