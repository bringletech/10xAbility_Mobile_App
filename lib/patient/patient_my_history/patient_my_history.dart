import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:ten_x_app/common/colors/colors.dart';
import 'package:ten_x_app/common/commonButton/common_button.dart';

import '../../common/commonText/common_text.dart';
import '../../common/commonText/common_text_colors.dart';

class PatientMyHistory extends StatefulWidget {
  const PatientMyHistory({super.key});

  @override
  State<PatientMyHistory> createState() => _PatientMyHistoryState();
}

class _PatientMyHistoryState extends State<PatientMyHistory> {
  final List<String> items = List.generate(10, (index) => "Item $index");
  final List<Map<String, String>> historyData = List.generate(
    8,
        (index) => {
      'name': 'Aditi Mukherjee',
      'role': 'DMIT Counselor',
      'date': '26th February 2024',
      'time': '10:00 AM',
      'duration': '60 Minutes',
      'mode': 'Online',
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
                margin: EdgeInsets.only(top: 40, left: 20, right: 20),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back, color: AppColors.redOrange),
                    SizedBox(width: 15,),
                    CommonText(
                      text: 'My History',
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
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
              //SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(8),
                height: MediaQuery.of(context).size.height * 0.81, // Set a fixed height
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: historyData.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.9,
                  ),
                  itemBuilder: (context, index) {
                    final item = historyData[index];
                    return HistoryCard(item: item);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// SizedBox(height: 10,),
// ListView.builder(
//     shrinkWrap: true,
//     physics: NeverScrollableScrollPhysics(),
//     itemCount: items.length,
//     itemBuilder: (context, index){
//       return Container(
//         margin: EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 10),
//         decoration: BoxDecoration(
//           color: AppColors.white,
//           borderRadius: BorderRadius.circular(30),
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
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 Container(
//                   margin: EdgeInsets.all(5),
//                   child: CircleAvatar(
//                     radius: 30,
//                     backgroundImage: AssetImage("assets/images/Aditi.png"),
//                     //child: Icon(Icons.person,size: 30,),
//                   ),
//                 ),
//                 Column(
//                   children: [
//                     CommonText(text: '_Aditya Sharma', fontSize: 16, fontFamily: 'Inter', fontWeight: FontWeight.w500,),
//                     Row(
//                       children: [
//                         CommonText(text: '21, Dec ,2024', fontSize: 9, fontFamily: 'Inter', fontWeight: FontWeight.w500,),
//                         SizedBox(width: 10,),
//                         CommonText(text: '4:00pm', fontSize: 9, fontFamily: 'Inter', fontWeight: FontWeight.w500,)
//                       ],
//                     )
//                   ],
//                 )
//               ],
//             ),
//             Container(
//               margin:EdgeInsets.only(right: 20),
//                 child: CommonTextColors(text: 'Zoom Meeting', fontSize: 9, fontFamily: 'Inter', fontWeight: FontWeight.w500, color: AppColors.red,)),
//           ],
//         ),
//       );
//     }
// ),
// SizedBox(height: 20,),
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
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(text: widget.item['name']!,
                        fontSize: 13,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400),
                    CommonText(text: widget.item['role']!,
                        fontSize: 10,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400),
                  ],
                )
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                CommonTextColors(text: 'Date:',
                    fontSize: 10,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    color: Colors.black54),
                CommonTextColors(text: widget.item['date']!,
                    fontSize: 10,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    color:AppColors.redOrange),
              ],
            ) , SizedBox(height: 5),
            Row(
              children: [
                CommonTextColors(text: 'Time:',
                    fontSize: 10,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    color: Colors.black54),
                CommonTextColors(text: widget.item['time']!,
                    fontSize: 10,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    color:AppColors.redOrange),
              ],
            ), SizedBox(height: 5),
            Row(
              children: [
                CommonTextColors(text: 'Session Duration:',
                    fontSize: 10,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    color: Colors.black54),
                CommonTextColors(text: widget.item['duration']!,
                    fontSize: 10,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    color:AppColors.redOrange),
              ],
            ) , SizedBox(height: 5),
            Row(
              children: [
                CommonTextColors(text: 'Session Mode:',
                    fontSize: 10,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    color: Colors.black54),
                CommonTextColors(text: widget.item['mode']!,
                    fontSize: 10,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    color:AppColors.redOrange),
              ],
            ),
            SizedBox(height: 10),
            CommonFirstButton(onPressed: (){}, text: 'Chat History',
                height: 24, width: 128, fontSize: 10,
                fontFamily: 'Inter', fontWeight: FontWeight.w400, color: AppColors.white)
          ],
        ),
      ),
    );
  }
}
