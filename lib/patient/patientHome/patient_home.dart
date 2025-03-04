import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../common/colors/colors.dart';
import '../../common/commonText/common_text.dart';
import '../../common/commonText/common_text_colors.dart';
import '../../controller/appstream_controller.dart';
import '../patientBooking/patient_book_therapy.dart';
import '../patientSelfAssessment/patient_self_assessment.dart';

class PatientHome extends StatefulWidget {
  const PatientHome({super.key});

  @override
  State<PatientHome> createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideImageAnimation;
  late Animation<Offset> _slideTopAnimation;
  bool _isFirstLoad = true; // Track first-time load
  AppStreamController appStreamController = AppStreamController.instance;


  @override
  void initState() {
    appStreamController.handleBottomTab.add(true);
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _setAnimation(); // Set initial animation based on first load

    Future.delayed(const Duration(milliseconds: 300), () {
      _animationController.forward();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (ModalRoute.of(context)!.isCurrent) {
      setState(() {
        _isFirstLoad = false; // After first load, set this to false
        _setAnimation(); // Change animation to top-slide
      });

      _animationController.reset();
      _animationController.forward();
    }
  }

  void _setAnimation() {
    if (_isFirstLoad) {
      // First time: slide from right
      _slideImageAnimation = Tween<Offset>(
        begin: const Offset(1.5, 0), // Start off-screen to the right
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ));
    } else {
      // Navigation taps: slide from top
      _slideImageAnimation = Tween<Offset>(
        begin: const Offset(0, -1.5), // Start off-screen above
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ));
    }

    // CircleAvatar & Text slide from top (on navigation taps)
    _slideTopAnimation = Tween<Offset>(
      begin: const Offset(0, -1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  // PatientHomeImage Animation
                  SlideTransition(
                    position: _slideImageAnimation,
                    child: Image.asset("assets/images/patientHomeImage.png"),
                  ),

                  // Circle Avatar + Text (Always slides from top on navigation taps)
                  Positioned(
                    top: 20,
                    left: 20,
                    right: 20,
                    child: SlideTransition(
                      position: _slideTopAnimation,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage(
                                    "assets/images/patientHomeImage2.png"),
                              ),
                              SizedBox(width: 10),
                              CommonTextColors(
                                text: 'Hello Arjun',
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                color: AppColors.black,
                                textDecoration: TextDecoration.underline,
                              ),
                            ],
                          ),
                          SvgPicture.asset("assets/svgIcon/bell.svg"),
                        ],
                      ),
                    ),
                  ),

                  // "Choose What's Best For You" (Also slides from top)
                  Positioned(
                    top: 70,
                    left: 25,
                    child: SlideTransition(
                      position: _slideTopAnimation,
                      child: SizedBox(
                        height: 72,
                        width: 190,
                        child: CommonText(
                          text: "Choose What's Best For You",
                          fontSize: 24,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              SelfAssessment(isShown: true),
                        ),
                      ).then((value) =>
                          appStreamController.handleBottomTab.add(true));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: AppColors.redOrange)),
                      //color: Colors.amber,
                      height: 100,
                      width: 80,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                                "assets/svgIcon/patientHomeIcon.svg"),
                            SizedBox(
                              height: 4,
                            ),
                            CommonTextColors(
                              text: 'Self',
                              fontSize: 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              color: AppColors.darkGray1,
                            ),
                            CommonTextColors(
                              text: 'Assessment',
                              fontSize: 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              color: AppColors.darkGray1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (Context)=>BookTherapy()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: AppColors.redOrange)),
                      //color: Colors.amber,
                      height: 100,
                      width: 80,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                                "assets/svgIcon/patientHomeIcon1.svg"),
                            SizedBox(
                              height: 4,
                            ),
                            CommonTextColors(
                              text: 'Book',
                              fontSize: 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              color: AppColors.darkGray1,
                            ),
                            CommonTextColors(
                              text: 'Therapy',
                              fontSize: 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              color: AppColors.darkGray1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: AppColors.redOrange)),
                      //color: Colors.amber,
                      height: 100,
                      width: 80,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                                "assets/svgIcon/patientHomeIcon2.svg"),
                            SizedBox(
                              height: 4,
                            ),
                            CommonTextColors(
                              text: 'Growth',
                              fontSize: 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              color: AppColors.darkGray1,
                            ),
                            CommonTextColors(
                              text: 'Partner',
                              fontSize: 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              color: AppColors.darkGray1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: AppColors.redOrange)),
                      //color: Colors.amber,
                      height: 100,
                      width: 80,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                                "assets/svgIcon/patientHomeIcon3.svg"),
                            SizedBox(
                              height: 4,
                            ),
                            CommonTextColors(
                              text: 'About Us',
                              fontSize: 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              color: AppColors.darkGray1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Image.asset("assets/images/patientHomeImage1.png")),
            ],
          ),
        ),
      ),
    );
  }
}
