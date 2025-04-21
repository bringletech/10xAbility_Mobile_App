import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ten_x_app/common/colors/colors.dart';

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

// Main UI
class CounsellorDashboard extends StatefulWidget {
  const CounsellorDashboard({super.key});

  @override
  State<CounsellorDashboard> createState() => _CounsellorDashboardState();
}

class _CounsellorDashboardState extends State<CounsellorDashboard> {
  final CounsellorDashboardController controller = Get.put(
      CounsellorDashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      body: Obx(() => controller.widgetList[controller.myIndex.value]),
      bottomNavigationBar: Container(
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
      ),
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

}

// Widget _buildNavItem(String iconPath, String label, int index) {
  //     return Obx(() {
  //       final isSelected = controller.myIndex.value == index;
  //
  //       return GestureDetector(
  //           onTap: ()
  //       {
  //         controller.onTabTapped(index);
  //         },
  //         child:Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             SvgPicture.asset(
  //               iconPath,
  //               colorFilter: ColorFilter.mode(
  //                 isSelected ? AppColors.redOrange : Colors.black,
  //                 BlendMode.srcIn,
  //               ),
  //               height: 24,
  //               width: 24,
  //             ),
  //             if (isSelected)
  //               Positioned(
  //                 bottom: -8, // Adjust position as needed
  //                 child: Container(
  //                   width: 6,
  //                   height: 6,
  //                   decoration: BoxDecoration(
  //                     color: AppColors.redOrange,
  //                     shape: BoxShape.circle,
  //                   ),
  //                 ),
  //               ),
  //             Text(
  //               label,
  //               style: TextStyle(
  //                 color: isSelected ? AppColors.redOrange : Colors.black,
  //                 fontSize: 12,
  //               ),
  //             ),
  //           ],
  //         )
  //       );
  //     });
  // }
  // }