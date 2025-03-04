import 'package:flutter/material.dart';
import '../common/colors/colors.dart';
import '../common/commonButton/common_button.dart';
import '../common/commonText/common_text.dart';
import '../common/string_constant.dart';
import 'patient_login_screen.dart';

class PatientIntroduction extends StatefulWidget {
  const PatientIntroduction({super.key});

  @override
  State<PatientIntroduction> createState() => _PatientIntroductionState();
}

class _PatientIntroductionState extends State<PatientIntroduction> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<Offset> _logoSlide;
  late Animation<double> _logoFade;

  late AnimationController _contentController;
  late Animation<Offset> _contentSlide;
  late Animation<double> _contentFade;
  late Animation<double> _contentScale;

  late AnimationController _exitController;
  late Animation<double> _exitScale;
  late Animation<Offset> _exitSlide;

  @override
  void initState() {
    super.initState();

    // Logo Animation (Top to Center)
    _logoController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _logoSlide = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOut),
    );
    _logoFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeIn),
    );

    // Content Animation (Bottom to Center with Shrink Effect)
    _contentController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _contentSlide = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
      CurvedAnimation(parent: _contentController, curve: Curves.easeOut),
    );
    _contentFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _contentController, curve: Curves.easeIn),
    );
    _contentScale = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _contentController, curve: Curves.easeOut),
    );

    // Exit Animation (Shrink and Move Up)
    _exitController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _exitScale = Tween<double>(begin: 1.0, end: 0.5).animate(
      CurvedAnimation(parent: _exitController, curve: Curves.fastOutSlowIn),
    );
    _exitSlide = Tween<Offset>(begin: Offset.zero, end: const Offset(0, -1)).animate(
      CurvedAnimation(parent: _exitController, curve: Curves.fastOutSlowIn),
    );

    _startAnimations();
  }

  void _startAnimations() async {
    await _logoController.forward();
    await Future.delayed(const Duration(milliseconds: 300));
    _contentController.forward();
  }

  void _onContinuePressed() async {
    await _exitController.forward();
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const PatientLoginScreen(),
        transitionDuration: Duration.zero,  // Instant transition, no white screen
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  @override
  void dispose() {
    _logoController.dispose();
    _contentController.dispose();
    _exitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Center(
          child: SlideTransition(
            position: _exitSlide,
            child: ScaleTransition(
              scale: _exitScale,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Logo Animation (Top to Center)
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
                    const SizedBox(height: 30),
                    // Image + Texts + Button (Shrink & Slide from Bottom)
                    SlideTransition(
                      position: _contentSlide,
                      child: FadeTransition(
                        opacity: _contentFade,
                        child: ScaleTransition(
                          scale: _contentScale,
                          child: Column(
                            children: [
                              Image.asset("assets/images/patientIntroductionImage.png"),
                              const SizedBox(height: 30),
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 25),
                                child: CommonText(
                                  text: StringConstant.start,
                                  fontSize: 24,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 30),
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 25),
                                child: CommonText(
                                  text: StringConstant.expand,
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const SizedBox(height: 30),
                              CommonFirstButton(
                                onPressed: _onContinuePressed,
                                text: StringConstant.cont,
                                height: 58,
                                width: 274,
                                fontSize: 24,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                color: AppColors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

