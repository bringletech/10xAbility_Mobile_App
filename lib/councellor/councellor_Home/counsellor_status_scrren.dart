import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../common/colors/colors.dart';
import '../councellor_appointment/bookings_counsellor.dart';
import '../councellor_chat/councellorChat.dart';
import 'counsellor_home.dart';

// Controller to manage the state
class CounsellorDashboardController extends GetxController {
  var myIndex = 0.obs;

  void onTabTapped(int index) {
    myIndex.value = index;
  }

  final List<Widget> widgetList = [
    CounsellorHome(),
    CounsellorChat(),
    BookingsCounsellor(),
  ];
}

class CounsellorStatusScreen extends StatefulWidget {
  const CounsellorStatusScreen({super.key});

  @override
  State<CounsellorStatusScreen> createState() => _CounsellorStatusScrrenState();
}

class _CounsellorStatusScrrenState extends State<CounsellorStatusScreen> {
  final CounsellorDashboardController controller = Get.put(
      CounsellorDashboardController());

  bool _isDialogShown = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showPopupDialog();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
      exit(0); // App close
    },
        child: Scaffold(
      //backgroundColor: Colors.white,
      body: _isDialogShown
          ? Obx(() => controller.widgetList[controller.myIndex.value])
          : Center(
        child: CircularProgressIndicator(
          color: AppColors.redOrange,
        ),
      ),
      bottomNavigationBar: _isDialogShown
          ? Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem("assets/svgIcon/homeIcon.svg", 'Home', 0),
            _buildNavItem("assets/svgIcon/chatIcon.svg", "Chat", 1),
            _buildNavItem("assets/svgIcon/bookingsIcon.svg", "Appointments", 2),
          ],
        ),
      ):null,
    )
    );
  }

  Widget _buildNavItem(String iconPath, String label, int index) {
    return Obx(() {
      final isSelected = controller.myIndex.value == index;

      return GestureDetector(
        onTap: () {
          controller.onTabTapped(index);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              colorFilter: ColorFilter.mode(
                isSelected ? AppColors.redOrange : Colors.black,
                BlendMode.srcIn,
              ),
              // colorFilter: ColorFilter.mode(
              //   Colors.black,
              //   BlendMode.srcIn,
              // ),
              height: 24,
              width: 24,
            ),
            SizedBox(height: 4), // Space between icon and label
            Text(
              label,
              style: TextStyle(
                //color: isSelected ? AppColors.redOrange : Colors.black,
                color: Colors.black,
                fontSize: 12,
              ),
            ),
            SizedBox(height: 4), // Space between label and dot
            if (isSelected) // Only show dot for selected item
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: AppColors.redOrange,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      );
    });
  }

  Future<void> showPopupDialog() async {
    setState(() {
      _isDialogShown = true;
    });
    await showDialog(
      context: context,
      barrierDismissible: false, // User can't dismiss by tapping outside
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async => false, // back button se dialog band nahi hoga
        child:Dialog(
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
                  right: -2,
                  top: -1.5,
                  child: Image.asset(
                    'assets/images/popUp1.png',
                    // Your wave image
                    fit: BoxFit.cover,
                    height: 80,
                  ),
                ),
                Positioned(
                  bottom: -1,
                  left: -2,
                  //right: 0,
                  child: Image.asset(
                    'assets/images/popUp2.png',
                    fit: BoxFit.cover,
                    height: 80,
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Image.asset(
                    'assets/images/oops.png',
                    height: 200,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 40),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Oops!",
                          style: TextStyle(
                            fontSize: 40,fontFamily: "Poppins",
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          )),
                      SizedBox(height: 5),
                      Text("You Are Not Verified Yet",
                          style: TextStyle(
                            fontSize: 20,fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          )),
                      Text("Please Try Again Later",
                          style: TextStyle(
                            fontSize: 15,fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
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
                              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 9),
                            ),
                            onPressed: () async {
                              exit(0);
                            },
                            child: Text("Okay",style: TextStyle(color: Colors.white,
                                fontWeight: FontWeight.w500,fontSize:17,fontFamily: 'Poppins'
                            ),),
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
        )
        );
      },
    );
  }
}
