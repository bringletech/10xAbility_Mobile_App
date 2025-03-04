import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../common/colors/colors.dart';
import '../../common/commonText/common_text.dart';

class PatientChatOnline extends StatefulWidget {
  const PatientChatOnline({super.key});

  @override
  State<PatientChatOnline> createState() => _PatientChatOnlineState();
}

class _PatientChatOnlineState extends State<PatientChatOnline> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> messages = [
    {
      "text": "Hi Arjun, just checking in—how has your week been? Let me know if there's anything specific you'd like to discuss or work on.",
      "isSent": false,
      "time": "9:18 AM"
    },
    {
      "text": "Hi! Thanks for checking in. This week has been a bit challenging, but I'm managing. There are a few things I'd like to go over when we can.",
      "isSent": true,
      "time": "9:22 AM"
    },
  ];

  void sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        messages.add({
          "text": _controller.text,
          "isSent": true,
          "time": TimeOfDay.now().format(context),
        });
        _controller.clear(); // Clear input field
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset("assets/svgIcon/backDirectionIcon.svg"),
                        SizedBox(width: 5),
                        CircleAvatar(
                          radius: 30,
                          //backgroundColor: Colors.deepOrange,
                          backgroundImage: AssetImage("assets/images/patientHomeImage2.png"),
                        ),
                        SizedBox(width: 5),
                        Column(
                          children: [
                            CommonText(
                              text: 'Aarhie Kaushik',
                              fontSize: 17,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                            CommonText(
                              text: "Online",
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w300,
                            )
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                            onTap: (){
                              launchUrlString("tel:9758886219");
                            },
                            child: SvgPicture.asset("assets/svgIcon/callIcon.svg")),
                        SizedBox(width: 25,),
                        SvgPicture.asset("assets/svgIcon/moreVertIcon.svg"),
                        SizedBox(width: 15,),
                      ],
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
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return chatBubble(
                      text: messages[index]["text"],
                      isSent: messages[index]["isSent"],
                      time: messages[index]["time"],
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: chatInputField(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget chatBubble({required String text, required bool isSent, required String time}) {
    return Align(
      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.all(12),
            constraints: const BoxConstraints(maxWidth: 250),
            decoration: BoxDecoration(
                color: isSent ? AppColors.lightSalmonPink : AppColors.platinum,
                borderRadius: isSent ? BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomLeft:Radius.circular(30),
                ) : BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomLeft:Radius.circular(30),
                  bottomRight:Radius.circular(30),
                )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(text, style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    time,
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget chatInputField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        //border: Border(top: BorderSide(color: Colors.grey.shade300)),
        color: AppColors.white,
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
      child: Row(
        children: [
          GestureDetector(
              onTap: (){},
              child: SvgPicture.asset("assets/svgIcon/emojiIcon.svg")
          ),
          SizedBox(width: 10,),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration:  InputDecoration(
                hintStyle: TextStyle(
                  color: AppColors.neutralGray1,
                ),
                hintText: "Message",
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: AppColors.redOrange),
            onPressed: sendMessage, // Send message function call
          ),
          SizedBox(width: 10,),
          GestureDetector(
              onTap: (){},
              child: SvgPicture.asset("assets/svgIcon/recordingIcon.svg")
          ),
          SizedBox(width: 5,),
        ],
      ),
    );
  }
}