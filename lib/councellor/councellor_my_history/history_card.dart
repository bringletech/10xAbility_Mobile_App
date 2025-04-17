import 'package:flutter/material.dart';

import '../../common/colors/colors.dart';
import '../../common/commonText/common_text.dart';
import '../../common/commonText/common_text_colors.dart';
import '../councellor_chat/councellor_chat_online.dart';
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
                SizedBox(
                  width: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                        text: widget.item['name']!,
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
                    CommonTextColors(
                        text: 'Name:',
                        fontSize: 9,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        color: Colors.black54),
                    CommonTextColors(
                        text: widget.item['name1']!,
                        fontSize: 9,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        color: AppColors.redOrange),
                  ],
                ),
                Row(
                  children: [
                    CommonTextColors(
                        text: 'Age:',
                        fontSize: 9,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        color: Colors.black54),
                    CommonTextColors(
                        text: widget.item['age']!,
                        fontSize: 9,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        color: AppColors.redOrange),
                  ],
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                CommonTextColors(
                    text: 'Email:',
                    fontSize: 9,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    color: Colors.black54),
                Container(
                  //color: Colors.black,
                  width: MediaQuery.of(context).size.width * 0.32,
                  height: 12,
                  child: CommonTextColors(
                      text: widget.item['email']!,
                      fontSize: 9,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      color: AppColors.redOrange),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                CommonTextColors(
                    text: 'Mobile number:',
                    fontSize: 9,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    color: Colors.black54),
                Container(
                  //color: Colors.black,
                  width: MediaQuery.of(context).size.width * 0.185,
                  height: 12,
                  child: CommonTextColors(
                      text: widget.item['mobile']!,
                      fontSize: 9,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      color: AppColors.redOrange),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                CommonTextColors(
                    text: 'session time:',
                    fontSize: 9,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    color: Colors.black54),
                Container(
                  //color: Colors.black,
                  width: MediaQuery.of(context).size.width * 0.22,
                  height: 12,
                  child: CommonTextColors(
                      text: widget.item['time']!,
                      fontSize: 9,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      color: AppColors.redOrange),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Message Button
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CouncellorChatOnline()),
                    );
                  },
                  child: Container(
                    width: 80,
                    height: 24,
                    decoration: BoxDecoration(
                      color: AppColors.redOrange, // Custom orange color
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Message",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),


                // View More Button
                GestureDetector(
                  onTap: () {
                    print("View More Button Clicked");
                  },
                  child: Container(
                    width: 80,
                    height: 25,
                    decoration: BoxDecoration(
                      color:AppColors.melonPink1, // Light pink background
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "View More",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontFamily: 'Inter', fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                // CommonFirstButton(onPressed: (){}, text: 'View More',
                //     height: 15, width: 43, fontSize: 8,
                //     fontFamily: 'Inter', fontWeight: FontWeight.w400, color: AppColors.white),
              ],
            )
          ],
        ),
      ),
    );
  }
}