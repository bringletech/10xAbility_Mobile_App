import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ten_x_app/common/colors/colors.dart';
import 'package:ten_x_app/common/commonText/common_text.dart';
import 'package:ten_x_app/common/commonText/common_text_colors.dart';

import '../../auth/api_services/api_service.dart';
import '../../auth/model/get_appointment_remainder_response_model.dart';
import '../../auth/model/get_current_counsellor_details_response_model.dart';
import '../../auth/model/get_therapist_payment_stats_response_model.dart';
import '../../auth/model/get_upcoming_appointment_therapist_response_model.dart';
import '../../user_type/user_type_screen.dart';
import '../councellor_appointment/bookings_counsellor.dart';
import '../councellor_my_history/counsellor_my_history.dart';
import '../councellor_notifications/counsellor_notification.dart';
import '../councellor_profile/counsellor_profile.dart';
import '../councellor_settings/counsellor_setting.dart';

class CounsellorHome extends StatefulWidget {
  const CounsellorHome({super.key});

  @override
  State<CounsellorHome> createState() => _CounsellorHomeState();
}

class _CounsellorHomeState extends State<CounsellorHome> {
  List<Map<String, String>> upcomingAppointments = [];
  List<Map<String, String>> reminders = [];
  bool isDrawerOpen = false;
  bool isLoading = false;
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

  String fullName="",profilePicture="",todayEarning='',
      monthlyEarning='',totalEarning='',monthlyDate = '',todayDate='',patientName='',timeSlot='';

  @override
  void initState() {
    super.initState();
    fetchUpcomingAppointments();
    fetchReminders();
    currentTherapistDetails();
    therapistPaymentDetails();
    appointmentReminder();
    upcomingAppointment();
  }

  List<TherapistPaymentData>? paymentData=[];
  List<reminderData>? appointmentReminderData=[];
  List<UpcomingAppointmentData>? upcomingData=[];

  void fetchUpcomingAppointments() {
    // Simulating API fetch or Database fetch with Future.delayed
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        upcomingAppointments = [
          {
            "name": "Ibrahim Kadri",
            "date": "12th March",
            "time": "10:00 AM - 11:00 AM",
            "type": "In-Person"
          },
          {
            "name": "Ali Khan",
            "date": "14th March",
            "time": "2:00 PM - 3:00 PM",
            "type": "Video Call"
          },
          {
            "name": "Sara Sheikh",
            "date": "16th March",
            "time": "4:00 PM - 5:00 PM",
            "type": "In-Person"
          },
        ];
      });
    });
  }

  void fetchReminders() {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        reminders = [
          {"name": "Ibrahim Kadri", "time": "10:00 AM - 11:00 AM", "age": "32"},
          {"name": "Ali Khan", "time": "2:00 PM - 3:00 PM", "age": "28"},
          {"name": "Sara Sheikh", "time": "4:00 PM - 5:00 PM", "age": "35"},
        ];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
      child: CircularProgressIndicator(color: AppColors.darkOrange),
    ): Stack(children: [
      GestureDetector(
        onTap: closeDrawer,
        child: Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 40,),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.menu,
                                  size: 25,
                                  color: AppColors.black,
                                ),
                                onPressed: toggleDrawer,
                              ),
                              Row(
                                children: [
                                  CommonText(
                                      text: 'Hi,',
                                      fontSize: 15,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w500),
                                  SizedBox(width: 5,),
                                  CommonText(
                                      text: fullName,
                                      fontSize: 15,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w500),
                                ],
                              ),
                              SizedBox(width: 45,),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      // Soft shadow
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.all(8),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CounsellorNotification()),
                                        );
                                      },
                                      child: SvgPicture.asset(
                                        'assets/svgIcon/bell2.svg',
                                        color: AppColors.redOrange,
                                        height: 16,
                                        width: 14,
                                      ),
                                    ),
                                    // Bell Icon
                                    Positioned(
                                      top: -5,
                                      right: -7,
                                      child: Container(
                                        width: 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          color: AppColors.redOrange, // Badge Color
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // SizedBox(
                              //   width: 15,
                              // ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CounsellorProfile()),
                                  );
                                },
                                child: CircleAvatar(
                                  radius: 26,
                                  child:  ClipOval(
                                    child: CachedNetworkImage(
                                        imageUrl: profilePicture,
                                      errorWidget: (context, url, error) => Image.network(
                                        'https://dummyimage.com/500x500/aaa/000000.png&text=No+Image',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15,),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                left: 10,
                              ),
                              height: 59,
                              width: 71,
                              decoration: BoxDecoration(
                                color: AppColors.redorange2,
                                // Card background color
                                borderRadius:
                                BorderRadius.circular(12), // Rounded corners
                              ),
                              child: Center(
                                child: Container(
                                  height: 27,
                                  width: 27,
                                  child: SvgPicture.asset(
                                    'assets/svgIcon/appointment.svg',
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonText(
                                    text: "Today’s Appointments",
                                    fontSize: 17,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500),
                                CommonTextColors(
                                    text: '5',
                                    fontSize: 20,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.redOrange)
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => BookingsCounsellor()),
                                );
                              },
                              child: Container(
                                width: 160, // Adjust card width
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 5,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Image.asset('assets/images/video.png',
                                        height: 70),
                                    // Replace with actual image
                                    SizedBox(height: 10),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 12),
                                      decoration: BoxDecoration(
                                        color: AppColors.redorange2,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        ),
                                      ),
                                      child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: CommonText(
                                                text: "Video Calls\nAppointment",
                                                fontSize: 10,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            CommonTextColors(
                                              text: "4",
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.redOrange,
                                              fontSize: 20,
                                            ),
                                          ]),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 160, // Adjust card width
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Image.asset('assets/images/person.png',
                                      height: 70),
                                  // Replace with actual image
                                  SizedBox(height: 10),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 12),
                                    decoration: BoxDecoration(
                                      color: AppColors.greyWhite,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: CommonText(
                                            text: "In-Person Appointments",
                                            fontSize: 10,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        CommonTextColors(
                                          text: "2",
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.redOrange,
                                          fontSize: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 160, // Adjust card width
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Column(
                                  children: [
                                    CommonText(
                                        text: "Today's Earnings",
                                        fontSize: 13,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400),
                                    CommonText(
                                        text:todayDate,
                                        fontSize: 13,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400),
                                    CommonTextColors(
                                        text: todayEarning,
                                        fontSize: 17,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.redOrange)
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 160, // Adjust card width
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Column(
                                  children: [
                                    CommonText(
                                        text: "Monthly Earnings",
                                        fontSize: 13,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400),
                                    CommonText(
                                        text: monthlyDate,
                                        fontSize: 13,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400),
                                    CommonTextColors(
                                        text: monthlyEarning,
                                        fontSize: 17,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.redOrange)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width:double.infinity,
                          height: 87,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 5,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CommonText(
                                  text: 'Total earning',
                                  fontSize: 20,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500),
                              CommonTextColors(
                                  text: totalEarning,
                                  fontSize: 20,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.redOrange)
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min, // Extra space remove karega
                          children: [
                            CommonText(
                              text: 'Upcoming Appointments',
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                            SizedBox(height: 0), // Ensure no extra space
                            ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: 3,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(), // Internal scrolling disable
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 5),
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: AppColors.redorange2,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 20,
                                            backgroundImage: AssetImage('assets/images/profile.png'),
                                          ),
                                          SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              CommonText(
                                                text: "Ibrahim Kadri",
                                                fontSize: 13,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w400,
                                              ),
                                              CommonText(
                                                text: "12th March 10:00 AM - 11:00 AM",
                                                fontSize: 10,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/svgIcon/inPerson.svg',
                                            height: 20,
                                          ),
                                          CommonText(
                                            text: "In-Person",
                                            fontSize: 12,
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height*0.35,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 5,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonText(
                                    text: 'Reminders',
                                    fontSize: 22,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500),
                                appointmentReminderData == null || appointmentReminderData!.isEmpty
                                    ? Container(
                                  padding: EdgeInsets.only(top: 100),
                                      child: Center(
                                        child: Text(
                                      "No Reminders yet",
                                      style: TextStyle(
                                        fontSize: 16,color: AppColors.gray,
                                        fontWeight: FontWeight.w500,
                                      ),
                                                                        ),
                                                                      ),
                                    ) :ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: appointmentReminderData!.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return
                                        Container(
                                          margin: EdgeInsets.symmetric(vertical: 5),
                                          padding: EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: AppColors.redorange2,
                                            borderRadius: BorderRadius.circular(17),
                                          ),
                                          child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.notifications_active,
                                                      color: AppColors.redOrange,
                                                      size: 30,
                                                    ),
                                                    SizedBox(width: 10),
                                                    Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        CommonText(
                                                          text: patientName,
                                                         // text: "Ibrahim Kadri",
                                                          fontSize: 13,
                                                          fontFamily: "Poppins",
                                                          fontWeight:
                                                          FontWeight.w400,
                                                        ),
                                                        CommonText(
                                                          text:timeSlot,
                                                          fontSize: 10,
                                                          fontFamily: "Poppins",
                                                          fontWeight:
                                                          FontWeight.w400,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                // CommonText(
                                                //   text: "Age-32",
                                                //   fontSize: 13,
                                                //   fontFamily: "Poppins",
                                                //   fontWeight: FontWeight.w400,
                                                // ),
                                              ]));
                                    }),
                              ],
                            )),
                      ])),
            )),
      ),
      AnimatedPositioned(
        duration: Duration(milliseconds: 300),
        left: isDrawerOpen ? 0 : -250, // Slide drawer only
        top: 0,
        bottom: 0,
        child: IgnorePointer(
          ignoring: !isDrawerOpen, // Ignore taps when closed
          child: Container(
            width: 249,
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
                        MaterialPageRoute(builder: (context)=>CounsellorProfile()),
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
                        MaterialPageRoute(builder: (context)=> CounsellorMyHistory()),
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CounsellorSetting()),
                      );
                    },
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

  void currentTherapistDetails() {
    setState(() {
      isLoading = true;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        GetCurrentCounsellorDetailsResponseMODEL model =
        await CallService().getCurrentTherapistDetails();
        setState(() {
          isLoading = false;
          fullName = model.data!.fullName.toString();
          profilePicture=model.data!.profilePicture.toString();
        });
      });
    });
  }

  void therapistPaymentDetails() {
    setState(() {
      isLoading = true;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        GetTherapistPaymentStatusResponseModel model =
        await CallService().getTherapistPaymentStats();
        setState(() {
          isLoading = false;
          paymentData=model.data!;
          todayEarning = paymentData![0].amount.toString();     // Today's earning
          monthlyEarning = paymentData![1].amount.toString();   // Monthly earning
          totalEarning = paymentData![3].amount.toString();
          monthlyDate = paymentData![1].date.toString();
          todayDate = paymentData![0].date.toString();
          print('therapist Payment value is $paymentData');
          print('therapist Payment value is $todayEarning');
          print('therapist Payment value is $monthlyEarning');
          print('therapist Payment value is $totalEarning');
          print('therapist Payment value is $monthlyDate');
        });
      });
    });
  }

  void appointmentReminder() {
    setState(() {
      isLoading = true;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        GetUpcomingAppointmentRemainderResponseModel model =
        await CallService().getAppointmentReminder();
        setState(() {
          isLoading = false;
          appointmentReminderData =model.data;
          patientName = appointmentReminderData![0].patientName.toString();
           timeSlot = appointmentReminderData![0].timeSlot.toString();
          print('Appointment Remainder List Value IS $appointmentReminderData');
        });
      });
    });
  }

  void upcomingAppointment() {
    setState(() {
      isLoading = true;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        String formattedDate = DateTime.now().toIso8601String().split('T')[0];
        GetUpcomingAppointmentTherapistResponseModel model =
        await CallService().getUpcomingAppointment(date: formattedDate);
        setState(() {
          isLoading = false;
          upcomingData=model.data;
          print('Upcoming Appointment List Value IS $upcomingData');
        });
      });
    });
  }
}