import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../common/colors/colors.dart';
import '../../common/commonText/common_text.dart';
import '../../common/commonText/common_text_colors.dart';
import '../../controller/appstream_controller.dart';
import '../../user_type/user_type_screen.dart';
import '../patient EditProfile/edit_profile.dart';
import '../patientBooking/patient_book_therapy.dart';
import '../patientSelfAssessment/patient_self_assessment.dart';
import '../patient_my_history/patient_my_history.dart';
import '../patient_register/patient_register_screen.dart';

class PatientHome extends StatefulWidget {
  const PatientHome({super.key});

  @override
  State<PatientHome> createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  late Timer _timer;
  late AnimationController _animationController;
  late Animation<Offset> _slideImageAnimation;
  late Animation<Offset> _slideTopAnimation;
  bool _isFirstLoad = true; // Track first-time load
  AppStreamController appStreamController = AppStreamController.instance;
  int _currentIndex = 0;
  bool isDrawerOpen = false;
  void toggleDrawer() {
    setState(() {
      isDrawerOpen = !isDrawerOpen;
    });
  }
  void closeDrawer() {
    if (isDrawerOpen) {
      setState(() {
        isDrawerOpen = false;
      });
    }
  }

  final List<String> imgList = [
    'assets/images/image_1.png',
    'assets/images/image_2.png',
    'assets/images/image_3.png',
    'assets/images/image_4.png',
  ];


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

    _startAutoPlay();
  }

  void _startAutoPlay() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (_currentIndex < imgList.length - 1) {
        _currentIndex++;
        _pageController.animateToPage(
          _currentIndex,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        // First image pe jump karega bina reverse effect ke
        _currentIndex = 0;
        _pageController.jumpToPage(0);
      }
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
    _timer.cancel(); // Timer stop karna zaroori hai jab screen band ho
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        children:[
          GestureDetector(
            onTap: closeDrawer,
            child: Scaffold(
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
                                      IconButton(
                                        icon: Icon(Icons.menu, size: 30, color: AppColors.black,),
                                        onPressed: toggleDrawer,
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
                                  borderRadius: BorderRadius.circular(30),
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
                                  borderRadius: BorderRadius.circular(30),
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
                                  borderRadius: BorderRadius.circular(30),
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
                                  borderRadius: BorderRadius.circular(30),
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
                      Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10),
                        child: Container(
                          constraints: const BoxConstraints(maxHeight: 180), // Image ki height fix karega
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: imgList.length,
                            onPageChanged: (index) {
                              setState(() {
                                _currentIndex = index;
                              });
                            },
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: Image.asset(
                                    imgList[index],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      // Indicator (Right Side, Image ke neeche)
                      Padding(
                        padding: const EdgeInsets.only(right: 40),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: SmoothPageIndicator(
                            controller: _pageController,
                            count: imgList.length,
                            effect: const ExpandingDotsEffect(
                              dotHeight: 8,
                              dotWidth: 8,
                              activeDotColor: Colors.grey,
                              dotColor: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            left: isDrawerOpen ? 0 : -250, // Slide drawer only
            top: 0,
            bottom: 0,
            child: IgnorePointer(
              ignoring: !isDrawerOpen, // Ignore taps when closed
              child: Container(
                width: 250,
                color: AppColors.redOrange,
                child: Stack(children: [
                  Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Image.asset('assets/images/drawerDesign.png')),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50, left: 10),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              child: Icon(
                                Icons.person,
                                size: 30,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              children: [
                                CommonTextColors(
                                  text: 'Hello User',
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.white,
                                ),
                                CommonTextColors(
                                  text: 'Exam@gmail.com',
                                  fontSize: 9,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.white,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        leading: Icon(Icons.edit_outlined, color: Colors.white),
                        title: CommonTextColors(
                          text: 'Edit profile',
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          color: AppColors.white,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProfilePatient()),
                          );
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        leading: Icon(Icons.history, color: Colors.white),
                        title: CommonTextColors(
                          text: 'My History',
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          color: AppColors.white,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PatientMyHistory()),
                          );
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        leading: Icon(Icons.settings, color: Colors.white),
                        title: CommonTextColors(
                          text: 'Setting',
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          color: AppColors.white,
                        ),
                        onTap: toggleDrawer,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        leading: Icon(Icons.logout_rounded, color: Colors.white),
                        title: CommonTextColors(
                          text: 'Log out',
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                        ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  backgroundColor: Colors.transparent,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.8,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Stack(
                                      children: [
                                        // Wave Background Top
                                        Positioned(
                                          right: 0,
                                          top: 0,
                                          child: Image.asset(
                                            'assets/images/popUp1.png',
                                            // Your wave image
                                            fit: BoxFit.cover,
                                            height: 60,
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          left: 0,
                                          //right: 0,
                                          child: Image.asset(
                                            'assets/images/popUp2.png',
                                            fit: BoxFit.cover,
                                            height: 60,
                                          ),
                                        ),
                                        Positioned(
                                          //left: 0,
                                          right: 0,
                                          bottom: 0,
                                          child: Image.asset(
                                            'assets/images/popUp3.png',
                                            height: 80,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 40),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text("Are You Sure You Want to",
                                                  style: TextStyle(
                                                    fontSize: 12,fontFamily: "Inter",
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black,
                                                  )),
                                              SizedBox(height: 5),
                                              Text("Log Out?",
                                                  style: TextStyle(
                                                    fontSize: 30,fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  )),
                                              SizedBox(height: 30),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor:AppColors.redOrange,
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(15)),
                                                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                                                    ),
                                                    onPressed: () async {
                                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                                      await prefs.remove("userId");
                                                      await prefs.remove('accessToken');
                                                      await prefs.remove('userType');
                                                      await prefs.remove("email");
                                                      await prefs.clear();
                                                      await prefs.remove("languageCode");
                                                      // print("SharedPreference value are $prefs");
                                                      await Future.delayed(const Duration(seconds: 1));
                                                      await prefs.clear();
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder: (context)=>UserTypeScreen()),
                                                      );
                                                    },
                                                    child: Text("Yes",style: TextStyle(color: Colors.white,
                                                        fontWeight: FontWeight.w400,fontSize:17,fontFamily: 'Poppins'
                                                    ),),
                                                  ),
                                                  SizedBox(width: 20),
                                                  OutlinedButton(
                                                    style: OutlinedButton.styleFrom(
                                                      side: BorderSide(
                                                          color: AppColors.darkOrange),
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(15)),
                                                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),),
                                                    onPressed: () => Navigator.of(context).pop(),
                                                    child: Text("Cancel",
                                                        style: TextStyle(color: Colors.black)),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 60),
                                              // Space for the bottom illustration
                                            ],
                                          ),
                                        ),

                                        // Bottom wave and illustration

                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                    ],
                  ),
                ]),
              ),
            ),
          ),
        ]);
  }

}