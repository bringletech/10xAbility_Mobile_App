import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ten_x_app/common/colors/colors.dart';
import 'package:ten_x_app/common/commonButton/common_button_get_otp.dart';
import 'package:ten_x_app/common/commonText/common_text.dart';
import 'package:ten_x_app/common/commonText/common_text_colors.dart';

import '../patientProfile/patient_view_profile_councellor.dart';
import 'patient_book_appointment.dart';


class BookTherapy extends StatefulWidget {
  const BookTherapy({super.key});

  @override
  State<BookTherapy> createState() => _BookTherapyState();
}

class _BookTherapyState extends State<BookTherapy> {
  bool showAll = false;
  bool showAll1 = false;
  final List<String> items = List.generate(4, (index) => "Item $index");
  final List<String> items1 = List.generate(4, (index) => "Item $index");
  final TextEditingController searchController = TextEditingController();
  final List<Map<String, dynamic>> counselors = [
    {
      'name': "Aditi Mukherjee",
      'role': "DMIT Counsellor",
      'experience': "190+ Hours Of Counselling",
      'languages': "English, Hindi, Gujarati",
      'sessionMode': "Virtual And In-person",
      'image': 'assets/images/counsellor.png'
    },
    {
      'name': "Aditi Mukherjee",
      'role': "DMIT Counsellor",
      'experience': "190+ Hours Of Counselling",
      'languages': "English, Hindi, Gujarati",
      'sessionMode': "Virtual And In-person",
      'image': 'assets/images/counsellor.png'
    },
    {
      'name': "Aditi Mukherjee",
      'role': "DMIT Counsellor",
      'experience': "190+ Hours Of Counselling",
      'languages': "English, Hindi, Gujarati",
      'sessionMode': "Virtual And In-person",
      'image': 'assets/images/counsellor.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.arrow_back, color: AppColors.redOrange),
                                CommonText(
                                  text: "Hello Arjun",
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins',
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 23),
                                  child: Row(
                                    children: [
                                      CommonText(
                                        text: "Meet",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: 'Poppins',
                                      ),
                                      CommonTextColors(
                                        text: " Your ",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: 'Poppins',
                                        color: AppColors.redOrange,
                                      ),
                                      CommonText(
                                        text: "Counsellors",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: 'Poppins',
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        CircleAvatar(
                          radius: 24,
                          backgroundImage: AssetImage('assets/images/patientHomeImage2.png'),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Dash(
                      length: MediaQuery.of(context).size.width * 0.90,
                      dashColor: AppColors.redOrange,
                      dashLength: 10,
                      dashThickness: 1,
                      dashGap: 9,
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/svgIcon/book.svg',
                          height: 30,
                          width: 30,
                        ),
                        SizedBox(width: 10),
                        CommonTextColors(
                          text: "Book Therapy",
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                          color: AppColors.darkGray1,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 40,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search By Name",
                          hintStyle: TextStyle(color: Colors.grey), // Customize hint text color
                          prefixIcon: Icon(Icons.search, color: AppColors.redOrange),
                          contentPadding: EdgeInsets.only(top: 11),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: AppColors.redOrange), // Default border color
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: AppColors.redOrange), // Unfocused border color
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: AppColors.redOrange, width: 2), // Focused border color
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: Icon(Icons.tune, color: AppColors.redOrange),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: showAll ? items.length : 3,
                  itemBuilder: (context, index){
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      padding: EdgeInsets.only(left: 10,top: 8),
                      decoration: BoxDecoration(
                        color: AppColors.lightApricot,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: const Offset(0, -2),
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 0,
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      //color: Colors.deepOrange,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 50, 
                                    height: 50, 
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                        image: AssetImage(counselors[index]['image']),
                                        fit: BoxFit.cover, // Ensures the image covers the container properly
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CommonText(
                                        text: counselors[index]['name'],
                                        fontSize: 17,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                      ),
                                      CommonText(
                                        text: counselors[index]['role'],
                                        fontSize: 13,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      CommonText(text:  "Experience:",
                                        fontSize: 10, fontFamily: 'Poppins', fontWeight: FontWeight.w500,),
                                      SizedBox(width: 3,),
                                      CommonText(text: counselors[index]['experience'],
                                        fontSize: 10, fontFamily: 'Poppins', fontWeight: FontWeight.w300,)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      CommonText(text: "Languages:",
                                        fontSize: 10, fontFamily: 'Poppins', fontWeight: FontWeight.w500,),
                                      SizedBox(width: 3,),
                                      CommonText(text: counselors[index]['languages'],
                                        fontSize: 10, fontFamily: 'Poppins', fontWeight: FontWeight.w300,)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      CommonText(text: "Session Mode:",
                                        fontSize: 10, fontFamily: 'Poppins', fontWeight: FontWeight.w500,),
                                      SizedBox(width: 3,),
                                      CommonText(text: counselors[index]['sessionMode'],
                                        fontSize: 10, fontFamily: 'Poppins', fontWeight: FontWeight.w300,)
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                ],
                              ),
                            ],
                          ),
                          //SizedBox(width: 11,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    bottomLeft:Radius.circular(40),// Radius on top-left only
                                  ),
                                ),
                                padding: EdgeInsets.only(top: 5,bottom: 5),
                                child: CommonFirstButtonGetOtp(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PatientBookAppointment()));
                                  },
                                  text: 'Book Now',
                                  height: 30,
                                  width: 100,
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w300,
                                  color: AppColors.white,
                                  contenerColor: AppColors.redOrange,
                                  borderColor: AppColors.redOrange,
                                ),
                              ),
                              SizedBox(height: 5,),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    bottomLeft:Radius.circular(40),// Radius on top-left only
                                  ),
                                ),
                                padding: EdgeInsets.only(top: 5,bottom: 5),
                                child: CommonFirstButtonGetOtp(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PatientViewProfileCouncellor()));
                                  },
                                  text: 'View Profile',
                                  height: 30,
                                  width: 100,
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w300,
                                  color: AppColors.black,
                                  contenerColor: AppColors.white,
                                  borderColor: AppColors.redOrange,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
