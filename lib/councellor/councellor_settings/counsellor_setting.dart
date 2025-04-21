import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:ten_x_app/common/colors/colors.dart';
import 'package:ten_x_app/common/commonText/common_text.dart';
import 'package:ten_x_app/common/commonText/common_text_colors.dart';

class CounsellorSetting extends StatefulWidget {
  const CounsellorSetting({super.key});

  @override
  State<CounsellorSetting> createState() => _CounsellorSettingState();
}


class _CounsellorSettingState extends State<CounsellorSetting> {
  int _selectedIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index on button tap
    });
  }
  Map<String, bool> switches = {
    "Web Notifications": true,
    "Upcoming Appointment": true,
    "Session Cancelled/Rescheduled": true,
    "Exercise Alerts": false,
    "Email Notifications": true,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 40, left: 10, right: 10),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back, color: AppColors.redOrange)),
                    SizedBox(
                      width: 15,
                    ),
                    CommonText(
                      text: 'Settings',
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Dash(
                length: MediaQuery.of(context).size.width * 0.90,
                dashColor: AppColors.redOrange,
                dashLength: 10,
                dashThickness: 1,
                dashGap: 9,
              ),
              SizedBox(height: 30),
              Container(
                height: 48,
                width: double.infinity,
                padding: EdgeInsets.all(8),
                margin:  EdgeInsets.only( left: 10, right: 10),
                decoration: BoxDecoration(
                  color: AppColors.lightWhite,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => _onTabTapped(0),
                      child: Container(
                        height: 40,
                        width: 175,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: _selectedIndex == 0
                              ? AppColors.white
                              : AppColors.lightWhite,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset('assets/svgIcon/notification.svg'),
                            CommonText(
                              text: "Notification Preferences",
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _onTabTapped(1),
                      child: Container(
                        height: 40,
                        width: 145,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: _selectedIndex == 1
                              ? AppColors.white
                              : AppColors.lightWhite,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset(
                              'assets/svgIcon/transaction.svg',
                              height: 11,
                            ),
                            CommonText(
                              text: "Transaction History",
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Display content based on selected index
              _selectedIndex == 0
                  ? Column(
                      children: List.generate(1, (index) {
                        return Container(
                          child: buildNotificationPreferences(),
                        );
                      }),
                    )
                  : Container(
                      child: buildTransactionHistory(),
                    ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNotificationPreferences() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                text: "Notification Preferences",
                fontSize: 16,
                fontWeight: FontWeight.w400, fontFamily: 'Poppins',
              ),
              CommonTextColors(
                text: "Stay in control of what matters—tailor your notifications your way",
                fontSize: 11,
                fontWeight: FontWeight.w300, fontFamily: 'Poppins', color: AppColors.greyBlack,),
            ],
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 5,
                  spreadRadius: 1,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                buildCustomSwitchTile(
                  title: "Web Notifications",
                  subtitle: "These are notifications delivered directly through your browser."
                ),

                buildCustomSwitchTile(
                  title: "Upcoming Appointment",
                  subtitle:
                      "Get notified of your upcoming appointment 10 mins before it starts.",
                ),
                buildCustomSwitchTile(
                  title: "Session Cancelled/Rescheduled",
                  subtitle:
                      "Get notified when a session gets cancelled or rescheduled.",
                ),
                buildCustomSwitchTile(
                  title: "Exercise Alerts",
                  subtitle: "Get notified when new exercise Suggested",
                ),
              ],
            ),
          ) ,
          SizedBox(height: 50),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  spreadRadius: 1,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              children: [
                buildCustomSwitchTile(
                  title: "Email Notifications",
                  subtitle: " These are the notifications that will be delivered straight to your email inbox."
                ),
                buildCustomSwitchTile(
                  title: "Upcoming Appointment",
                  subtitle:
                      "Get notified of your upcoming appointment 10 mins before it starts.",
                ),
                buildCustomSwitchTile(
                  title: "Session Cancelled/Rescheduled",
                  subtitle:
                      "Get notified when a session gets cancelled or rescheduled.",
                ),
                buildCustomSwitchTile(
                  title: "Exercise Alerts",
                  subtitle: "Get notified when new exercise Suggested",
                ),
              ],
            ),
          )
        ]
      )
    );
  }

  Widget buildCustomSwitchTile({required String title, required String subtitle}) {
    return ListTile(
        title: CommonText(
          text: title,
          fontSize: 16,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
        ),
        subtitle: CommonTextColors(
          text: subtitle,
          fontSize: 12,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w300,
          color: AppColors.greyBlack,
        ),
        trailing: SizedBox(
            width: 50, // Limit width of trailing widget
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              FlutterSwitch(
                width: 45.0,
                height: 18.0,
                toggleSize: 15.0,
                value: switches[title] ?? false,
                borderRadius: 21.0,
                padding: 2.0,
                activeColor: AppColors.redOrange,
                inactiveColor: Colors.grey[300]!,
                onToggle: (val) {
                  setState(() {
                    switches[title] = val;
                  });
                },
              )
            ])));
  }

  Widget buildTransactionHistory() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            text: "Transaction History",
            fontSize: 16,
            fontWeight: FontWeight.w400, fontFamily: 'Poppins',
          ),
            SizedBox(height: 30),
          Container(height: 300,
            padding: EdgeInsets.all(15 ),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 5,
                  spreadRadius: 1,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: "Transaction History",
                  fontSize: 16,
                  fontWeight: FontWeight.w400, fontFamily: 'Poppins',
                ),
                SizedBox(height: 5),
                CommonTextColors(text: "Keep track of your activity—review your transaction history anytime.",
                    fontSize: 13,
                    fontFamily: 'Poppins', fontWeight: FontWeight.w300, color: AppColors.greyBlack),
                SizedBox(height: 50,),
                Center(
                  child: Container(
                    height: 66,
                    width: 66,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFFFDBD1),
                    ),
                    child: Center(
                      child: SvgPicture.asset('assets/svgIcon/transaction.svg',height: 21,),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}