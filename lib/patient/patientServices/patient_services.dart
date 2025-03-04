import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';

import '../../common/colors/colors.dart';
import '../../common/commonText/common_text.dart';
import '../../common/commonText/common_text_colors.dart';

class PatientServices extends StatefulWidget {
  const PatientServices({super.key});

  @override
  State<PatientServices> createState() => _PatientServicesState();
}

class _PatientServicesState extends State<PatientServices> {
  final List<String> items = List.generate(4, (index) => "Item $index");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  text: 'Live Services',
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
                  text: 'Need support?',
                  fontSize: 40,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  color: AppColors.redOrange,
                ),
              ),
              SizedBox(height: 10,),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 15),
                child: CommonText(
                  text: 'Connect with a live expert.',
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 10,),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  itemBuilder: (context, index){
                    return Container(
                        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: AppColors.redOrange
                          )
                      ),
                        //color: Colors.deepOrange,
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                Container(
                                decoration: BoxDecoration(
                                  //color: Colors.deepOrange,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                padding: EdgeInsets.all(5),
                                //margin: EdgeInsets.all(5),
                                height: 134,
                                width: 120,
                                  child: Image.asset("assets/images/aditiImage.png"),
                              ),
                                Positioned(
                                  top: 13,
                                  right: 13,
                                  child: CircleAvatar(
                                    backgroundColor: AppColors.brightGreen,
                                    radius: 8,
                                  ),
                                ),
                            ],
                            ),
                            //SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 15,),
                                CommonText(
                                  text: 'Aarhie Kaushik',
                                  fontSize: 17,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                                //SizedBox(height:5,),
                                CommonText(
                                  text: 'Consultant Psychologist',
                                  fontSize: 13,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w300,
                                ),
                                SizedBox(height:5,),
                                Row(
                                  children: [
                                    CommonText(
                                      text: 'Experience:',
                                      fontSize: 11,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                    ),
                                    SizedBox(width: 2,),
                                    Container(
                                      //color: Colors.amber,
                                      //width:147,
                                      child: CommonText(
                                        text: '100+ Hours Of counseling',
                                        fontSize: 11,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height:5,),
                                Row(
                                  children: [
                                    CommonText(
                                      text: 'Languages:',
                                      fontSize: 11,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                    ),
                                    SizedBox(width: 2,),
                                    CommonText(
                                      text: 'English, Hindi',
                                      fontSize: 11,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ],
                                ),
                                SizedBox(height:10,),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap:(){},
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: AppColors.redOrange,
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                                            border: Border.all(
                                                color: AppColors.redOrange
                                            )
                                        ),
                                        height: 39,
                                        width: 94,
                                        child: Center(child: CommonTextColors(text: 'Book Now', fontSize: 12, fontFamily: 'Poppins', fontWeight: FontWeight.w400, color: AppColors.white,)),
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    GestureDetector(
                                      onTap:(){},
                                      child: Container(
                                        decoration: BoxDecoration(
                                            //color: Colors.amber,
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                                            border: Border.all(
                                                color: AppColors.redOrange
                                            )
                                        ),
                                        height: 39,
                                        width: 94,
                                        child: Center(child: CommonTextColors(text: 'Chat Now', fontSize: 12, fontFamily: 'Poppins', fontWeight: FontWeight.w400, color: AppColors.black,)),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                    );
                  }
              ),
              SizedBox(height: 20,),

            ],

          ),
        ),
      ),
    );
  }
  }
