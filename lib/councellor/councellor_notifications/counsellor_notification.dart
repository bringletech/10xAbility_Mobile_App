import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';

import '../../common/colors/colors.dart';
import '../../common/commonText/common_text.dart';

class CounsellorNotification extends StatefulWidget {
  const CounsellorNotification({super.key});

  @override
  State<CounsellorNotification> createState() => _CounsellorNotificationState();
}

class _CounsellorNotificationState extends State<CounsellorNotification> {
  final List<Map<String, dynamic>> notifications = [
    {
      'message':
      "You've completed 3 mindfulness exercises this week. Keep up the great work",
      'isUnread': true
    },
    {
      'message':
      "You've completed 3 mindfulness exercises this week. Keep up the great work",
      'isUnread': true
    },
    {
      'message': "New guided meditation available: 10 minutes to help you unwind.",
      'isUnread': false
    },
    {
      'message': "New guided meditation available: 10 minutes to help you unwind.",
      'isUnread': false
    },
    {
      'message': "New guided meditation available: 10 minutes to help you unwind.",
      'isUnread': false
    },
    {
      'message': "New guided meditation available: 10 minutes to help you unwind.",
      'isUnread': false
    },
    {
      'message': "New guided meditation available: 10 minutes to help you unwind.",
      'isUnread': false
    },
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(children: [
                Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 40, left: 10, right: 10),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back, color: AppColors.redOrange),
                    SizedBox(
                      width: 15,
                    ),
                    CommonText(
                      text: 'Notifications',
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Dash(
                length: MediaQuery
                    .of(context)
                    .size
                    .width * 0.90,
                dashColor: AppColors.redOrange,
                dashLength: 10,
                dashThickness: 1,
                dashGap: 9,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 6),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: notification['isUnread']
                          ? AppColors.lightRed
                          :AppColors.lightGrey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CommonText(
                            text:  notification['message'],

                              fontSize: 13, fontFamily: 'Poppins', fontWeight: FontWeight.w400,
                          ),
                        ),
                        if (notification['isUnread']) // Show unread dot
                          Container(
                            margin: EdgeInsets.only(left: 8, top: 5),
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: AppColors.redOrange,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                  );
                }
              )
              ]
                      ),
            )
    ));
  }
}
