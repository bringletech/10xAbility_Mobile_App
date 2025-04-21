import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';

import '../../common/colors/colors.dart';
import '../../common/commonText/common_text.dart';
import '../../common/commonText/common_text_colors.dart';

class CounsellorMyHistory extends StatefulWidget {
  const CounsellorMyHistory({super.key});

  @override
  State<CounsellorMyHistory> createState() => _CounsellorMyHistoryState();
}

class _CounsellorMyHistoryState extends State<CounsellorMyHistory> {
  final List<Map<String, String>> historyData1 = List.generate(
    8,
        (index) => {
      'mode':'Online',
      'name': 'individual',
      'age':'25',
      'name1': 'Arjun Sharma',
      'email': 'arjunsharma123@gmail.com',
      'mobile': '+9109876543214',
      'time': '10:30 AM-11:30 AM',
    },
  );
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
                child: Row(
                  children: [
                    GestureDetector(
                      onTap:(){
                        Navigator.pop(context);
                      },
                        child: Icon(
                          Icons.arrow_back_outlined,
                          color: AppColors.redOrange,
                        )
                    ),
                    SizedBox(width: 10,),
                    CommonText(
                      text: 'My History',
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ],
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
              //SizedBox(height: 20,),
              Container(
                //color: Colors.black,
                padding: EdgeInsets.all(8),
                //height: MediaQuery.of(context).size.height * 0.58, // Set a fixed height for 2 items
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: historyData1.length,  // Show only 2 initially
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.9,
                  ),
                  itemBuilder: (context, index) {
                    final item1 = historyData1[index];
                    return HistoryCard(item: item1);
                  },
                ),
              ),
              SizedBox(height: 20,),

            ],

          ),
        ),
      ),
    );
  }
}
class HistoryCard extends StatefulWidget {
  final Map<String, String> item;

  HistoryCard({required this.item});

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Card background color
        borderRadius: BorderRadius.circular(20), // Rounded corners
        border: Border.all(
          color: AppColors.redOrange, // Border color
          width: 1, // Border width
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2), // Light shadow
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/Aditi.png'),
                  // Replace with a real image
                  radius: 20,
                ),
                SizedBox(width: 5,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(text: widget.item['name']!,
                        fontSize: 13,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400),
                    // CommonText(text: widget.item['role']!,
                    //     fontSize: 10,
                    //     fontFamily: "Inter",
                    //     fontWeight: FontWeight.w400),
                  ],
                )
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CommonTextColors(text: 'Name:',
                        fontSize: 9,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        color: Colors.black54),
                    CommonTextColors(text: widget.item['name1']!,
                        fontSize: 9,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        color:AppColors.redOrange),
                  ],
                ),
                Row(
                  children: [
                    CommonTextColors(text: 'Age:',
                        fontSize: 9,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        color: Colors.black54),
                    CommonTextColors(text: widget.item['age']!,
                        fontSize: 9,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        color:AppColors.redOrange),
                  ],
                ),
              ],
            ) , SizedBox(height: 5),
            Row(
              children: [
                CommonTextColors(text: 'Email:',
                    fontSize: 9,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    color: Colors.black54),
                Container(
                  //color: Colors.black,
                  width: MediaQuery.of(context).size.width*0.32,
                  height: 12,
                  child: CommonTextColors(text: widget.item['email']!,
                      fontSize: 9,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      color:AppColors.redOrange),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                CommonTextColors(text: 'Mobile Number:',
                    fontSize: 9,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    color: Colors.black54),
                Container(
                  //color: Colors.black,
                  width: MediaQuery.of(context).size.width*0.185,
                  height: 12,
                  child: CommonTextColors(text: widget.item['mobile']!,
                      fontSize: 9,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      color:AppColors.redOrange),
                ),
              ],
            ) ,
            SizedBox(height: 5),
            Row(
              children: [
                CommonTextColors(text: 'Session Time:',
                    fontSize: 9,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    color: Colors.black54),
                Container(
                  //color: Colors.black,
                  width: MediaQuery.of(context).size.width*0.22,
                  height: 12,
                  child: CommonTextColors(text: widget.item['time']!,
                      fontSize: 9,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      color:AppColors.redOrange),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                CommonTextColors(text: 'Session Mode:',
                    fontSize: 9,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    color: Colors.black54),
                Container(
                  //color: Colors.black,
                  width: MediaQuery.of(context).size.width*0.2,
                  height: 12,
                  child: CommonTextColors(text: widget.item['mode']??"",
                      fontSize: 9,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      color:AppColors.redOrange),
                ),
              ],
            ),
            // Row(
            //   //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     CommonFirstButton(onPressed: (){}, text: 'Message',
            //         height: 15, width: 60, fontSize: 10,
            //         fontFamily: 'Inter', fontWeight: FontWeight.w400, color: AppColors.white),
            //     CommonFirstButton(onPressed: (){}, text: 'View More',
            //         height: 15, width: 43, fontSize: 8,
            //         fontFamily: 'Inter', fontWeight: FontWeight.w400, color: AppColors.white),
            //     // CommonFirstButtonGetOtp(
            //     //   onPressed: () {  },
            //     //   text: 'View',
            //     //   height: 15,
            //     //   width: 43,
            //     //   fontSize: 8,
            //     //   fontFamily: 'Inter',
            //     //   fontWeight: FontWeight.w400,
            //     //   color: AppColors.white,
            //     //   contenerColor: AppColors.peachPink,
            //     // ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
