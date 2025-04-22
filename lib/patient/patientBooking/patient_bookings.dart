import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../auth/api_services/api_service.dart';
import '../../auth/model/upcoming_appointmet_response_model.dart';
import '../../common/colors/colors.dart';
import '../../common/commonButton/common_button_get_otp.dart';
import '../../common/commonText/common_text.dart';
import '../../common/commonText/common_text_colors.dart';

class PatientBookings extends StatefulWidget {
  const PatientBookings({super.key});

  @override
  State<PatientBookings> createState() => _PatientBookingsState();
}

class _PatientBookingsState extends State<PatientBookings> {
  bool showAll = false;
  bool showAll1 = false;
  bool isLoading=false;
  final List<String> items = List.generate(4, (index) => "Item $index");
  final List<String> items1 = List.generate(4, (index) => "Item $index");

  List<UpcomingAppointment>? upcomingData=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUpcomingAppointmentList();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading?Center(
        child: CircularProgressIndicator(color: AppColors.darkOrange,),
      ):Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                //color: Colors.deepOrange,
                margin: EdgeInsets.only(top: 40,left: 15),
                child: CommonText(
                  text: 'Bookings',
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 20,),
              Container(
                child: Dash(
                  length: MediaQuery.of(context).size.width*0.90,
                  dashColor: AppColors.redOrange,
                  dashLength: 10,
                  dashThickness: 1,
                  dashGap: 9,
                ),
              ),
              SizedBox(height: 20,),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 15),
                child: CommonTextColors(
                  text: 'Upcoming Session',
                  fontSize: 30,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  color: AppColors.redOrange,
                ),
              ),
              SizedBox(height: 10,),
              ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: upcomingData!.length,
                  itemBuilder: (context, index){
                    final item = upcomingData![index];
                    return upcomingData == null || upcomingData!.isEmpty
                        ? Container(
                        padding: EdgeInsets.only(top: 100),
                        child: Center(
                            child: Text(
                              "No Upcoming Appointment",
                              style: TextStyle(
                                fontSize: 16,color: AppColors.gray,
                                fontWeight: FontWeight.w500,
                              ),
                            )))
                        : Container(
                      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
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
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              //color: Colors.deepOrange,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: EdgeInsets.all(5),
                            //margin: EdgeInsets.all(5),
                            height: 85,
                            width: 85,
                            child: CachedNetworkImage(
                                imageUrl: item.therapistPicture.toString())
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10,),
                              CommonText(
                                text: item.therapistName.toString(),
                                fontSize: 17,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                              Row(
                                children: [
                                  CommonText(text: 'Date:', fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w500,),
                                  SizedBox(width: 3,),
                                  CommonText(text: item.day.toString(), fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w400,)
                                ],
                              ),
                              Row(
                                children: [
                                  CommonText(text: 'Time:', fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w500,),
                                  SizedBox(width: 3,),
                                  CommonText(text: item.timeSlot.toString(), fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w400,)
                                ],
                              ),
                              Row(
                                children: [
                                  CommonText(text: 'Status:', fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w500,),
                                  SizedBox(width: 3,),
                                  CommonText(text: item.appointmentStatus.toString(), fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w400,)
                                ],
                              ),
                              SizedBox(height: 10,),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      bottomLeft:Radius.circular(30),// Radius on top-left only
                                    ),
                                  ),
                                  padding: EdgeInsets.only(top: 4,bottom: 4),
                                  child: CommonFirstButtonGetOtp(
                                    onPressed: () {  },
                                    text: 'Chat Now',
                                    height: 30,
                                    width: 100,
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
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
                                      topLeft: Radius.circular(30),
                                      bottomLeft:Radius.circular(30),// Radius on top-left only
                                    ),
                                  ),
                                  padding: EdgeInsets.only(top: 4,bottom: 4),
                                  child: CommonFirstButtonGetOtp(
                                    onPressed: () {  },
                                    text: 'View Profile',
                                    height: 30,
                                    width: 100,
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
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
              SizedBox(height: 10,),
              GestureDetector(
                onTap: (){
                  setState(() {
                    showAll = !showAll;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonText(text: 'More', fontSize: 17, fontFamily: 'Poppins', fontWeight: FontWeight.w400,),
                    SvgPicture.asset("assets/svgIcon/moreIcon.svg"),
                  ],
                ),
              ),
              // SizedBox(height: 20,),
              // Container(
              //   width: double.infinity,
              //   margin: EdgeInsets.only(left: 15),
              //   child: CommonTextColors(
              //     text: 'Session Completed',
              //     fontSize: 30,
              //     fontFamily: 'Poppins',
              //     fontWeight: FontWeight.w700,
              //     color: AppColors.redOrange,
              //   ),
              // ),
              // SizedBox(height: 10,),
              // ListView.builder(
              //     shrinkWrap: true,
              //     physics: NeverScrollableScrollPhysics(),
              //     itemCount: showAll1 ? items1.length : 2,
              //     itemBuilder: (context, index){
              //       return Container(
              //         margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              //         decoration: BoxDecoration(
              //           color: AppColors.lightApricot,
              //           borderRadius: BorderRadius.circular(15),
              //           boxShadow: [
              //             BoxShadow(
              //               color: Colors.black.withOpacity(0.1),
              //               spreadRadius: 0,
              //               blurRadius: 4,
              //               offset: const Offset(0, -2),
              //             ),
              //             BoxShadow(
              //               color: Colors.black.withOpacity(0.2),
              //               spreadRadius: 0,
              //               blurRadius: 6,
              //               offset: const Offset(0, 2),
              //             ),
              //           ],
              //         ),
              //         //color: Colors.deepOrange,
              //         child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Container(
              //               decoration: BoxDecoration(
              //                 //color: Colors.deepOrange,
              //                 borderRadius: BorderRadius.circular(15),
              //               ),
              //               padding: EdgeInsets.all(5),
              //               //margin: EdgeInsets.all(5),
              //               height: 85,
              //               width: 85,
              //               child: Image.asset("assets/images/aditiImage.png"),
              //             ),
              //             Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 SizedBox(height: 10,),
              //                 CommonText(
              //                   text: 'Aditi Mukherjee',
              //                   fontSize: 17,
              //                   fontFamily: 'Poppins',
              //                   fontWeight: FontWeight.w400,
              //                 ),
              //                 Row(
              //                   children: [
              //                     CommonText(text: 'Date:', fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w500,),
              //                     SizedBox(width: 3,),
              //                     CommonText(text: '15 Nov 2024', fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w400,)
              //                   ],
              //                 ),
              //                 Row(
              //                   children: [
              //                     CommonText(text: 'Time:', fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w500,),
              //                     SizedBox(width: 3,),
              //                     CommonText(text: '5:30 PM', fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w400,)
              //                   ],
              //                 ),
              //                 Row(
              //                   children: [
              //                     CommonText(text: 'Mode:', fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w500,),
              //                     SizedBox(width: 3,),
              //                     CommonText(text: 'Online', fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w400,)
              //                   ],
              //                 ),
              //                 SizedBox(height: 10,),
              //               ],
              //             ),
              //             Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Container(
              //                     decoration: BoxDecoration(
              //                       color: AppColors.white,
              //                       borderRadius: BorderRadius.only(
              //                         topLeft: Radius.circular(30),
              //                         bottomLeft:Radius.circular(30),// Radius on top-left only
              //                       ),
              //                     ),
              //                     padding: EdgeInsets.only(top: 4,bottom: 4),
              //                     child: CommonFirstButtonGetOtp(
              //                       onPressed: () {  },
              //                       text: 'Chat Now',
              //                       height: 30,
              //                       width: 100,
              //                       fontSize: 12,
              //                       fontFamily: 'Poppins',
              //                       fontWeight: FontWeight.w400,
              //                       color: AppColors.white,
              //                       contenerColor: AppColors.redOrange,
              //                       borderColor: AppColors.redOrange,
              //                     ),
              //                   ),
              //                   SizedBox(height: 5,),
              //                   Container(
              //                     decoration: BoxDecoration(
              //                       color: AppColors.white,
              //                       borderRadius: BorderRadius.only(
              //                         topLeft: Radius.circular(30),
              //                         bottomLeft:Radius.circular(30),// Radius on top-left only
              //                       ),
              //                     ),
              //                     padding: EdgeInsets.only(top: 4,bottom: 4),
              //                     child: CommonFirstButtonGetOtp(
              //                       onPressed: () {  },
              //                       text: 'View Profile',
              //                       height: 30,
              //                       width: 100,
              //                       fontSize: 12,
              //                       fontFamily: 'Poppins',
              //                       fontWeight: FontWeight.w400,
              //                       color: AppColors.black,
              //                       contenerColor: AppColors.white,
              //                       borderColor: AppColors.redOrange,
              //                     ),
              //                   ),
              //                 ],
              //             ),
              //           ],
              //         ),
              //       );
              //     }
              // ),
              // SizedBox(height: 10,),
              // GestureDetector(
              //   onTap: (){
              //     setState(() {
              //       showAll1 = !showAll1;
              //     });
              //   },
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       CommonText(text: 'More', fontSize: 17, fontFamily: 'Poppins', fontWeight: FontWeight.w400,),
              //       SvgPicture.asset("assets/svgIcon/moreIcon.svg"),
              //     ],
              //   ),
              // ),

            ],

          ),
        ),
      ),
    );
  }

  getUpcomingAppointmentList() {
    setState(() {
      isLoading = true;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        GetPatientUpcomingAppointmentsResponseModel model =
        await CallService().getUpcomingAppointmentList();
        setState(() {
          isLoading = false;
          upcomingData=model.data;
          print("upcoming Appointment list Value is: $upcomingData");
        });
      });
    });
  }


}
