// import 'package:flutter/material.dart';
// import 'package:flutter_dash/flutter_dash.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:url_launcher/url_launcher_string.dart';
//
// import '../../common/colors/colors.dart';
// import '../../common/commonText/common_text.dart';
//
// class CouncellorChatOnline extends StatefulWidget {
//   const CouncellorChatOnline({super.key});
//
//   @override
//   State<CouncellorChatOnline> createState() => _CouncellorChatOnlineState();
// }
//
// class _CouncellorChatOnlineState extends State<CouncellorChatOnline> {
//   final TextEditingController _controller = TextEditingController();
//   List<Map<String, dynamic>> messages = [
//     {
//       "text": "Hi Arjun, just checking in—how has your week been? Let me know if there's anything specific you'd like to discuss or work on.",
//       "isSent": false,
//       "time": "9:18 AM"
//     },
//     {
//       "text": "Hi! Thanks for checking in. This week has been a bit challenging, but I'm managing. There are a few things I'd like to go over when we can.",
//       "isSent": true,
//       "time": "9:22 AM"
//     },
//   ];
//
//   void sendMessage() {
//     if (_controller.text.isNotEmpty) {
//       setState(() {
//         messages.add({
//           "text": _controller.text,
//           "isSent": true,
//           "time": TimeOfDay.now().format(context),
//         });
//         _controller.clear(); // Clear input field
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: Column(
//             children: [
//               Container(
//                 margin: const EdgeInsets.only(top: 10, left: 15),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         SvgPicture.asset("assets/svgIcon/backDirectionIcon.svg"),
//                         SizedBox(width: 5),
//                         CircleAvatar(
//                           radius: 30,
//                           //backgroundColor: Colors.deepOrange,
//                           backgroundImage: AssetImage("assets/images/patientHomeImage2.png"),
//                         ),
//                         SizedBox(width: 5),
//                         Column(
//                           children: [
//                             CommonText(
//                               text: 'Aarhie Kaushik',
//                               fontSize: 17,
//                               fontFamily: 'Poppins',
//                               fontWeight: FontWeight.w400,
//                             ),
//                             CommonText(
//                               text: "Online",
//                               fontSize: 15,
//                               fontFamily: 'Poppins',
//                               fontWeight: FontWeight.w300,
//                             )
//                           ],
//                         ),
//                       ],
//                     ),
//                     // Row(
//                     //   children: [
//                     //     GestureDetector(
//                     //         onTap: (){
//                     //           launchUrlString("tel:9758886219");
//                     //         },
//                     //         child: SvgPicture.asset("assets/svgIcon/callIcon.svg")),
//                     //     SizedBox(width: 25,),
//                     //     SvgPicture.asset("assets/svgIcon/moreVertIcon.svg"),
//                     //     SizedBox(width: 15,),
//                     //   ],
//                     // ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 10),
//               Dash(
//                 length: MediaQuery.of(context).size.width * 0.90,
//                 dashColor: AppColors.redOrange,
//                 dashLength: 10,
//                 dashThickness: 1,
//                 dashGap: 9,
//               ),
//               SizedBox(height: 10),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: messages.length,
//                   itemBuilder: (context, index) {
//                     return chatBubble(
//                       text: messages[index]["text"],
//                       isSent: messages[index]["isSent"],
//                       time: messages[index]["time"],
//                     );
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(bottom: 10),
//                 child: chatInputField(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget chatBubble({required String text, required bool isSent, required String time}) {
//     return Align(
//       alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
//       child: Column(
//         crossAxisAlignment: isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//         children: [
//           Container(
//             margin: const EdgeInsets.symmetric(vertical: 5),
//             padding: const EdgeInsets.all(12),
//             constraints: const BoxConstraints(maxWidth: 250),
//             decoration: BoxDecoration(
//                 color: isSent ? AppColors.lightSalmonPink : AppColors.platinum,
//                 borderRadius: isSent ? BorderRadius.only(
//                   topLeft: Radius.circular(30),
//                   topRight: Radius.circular(30),
//                   bottomLeft:Radius.circular(30),
//                 ) : BorderRadius.only(
//                   topRight: Radius.circular(30),
//                   bottomLeft:Radius.circular(30),
//                   bottomRight:Radius.circular(30),
//                 )
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(text, style: const TextStyle(fontSize: 16)),
//                 const SizedBox(height: 5),
//                 Align(
//                   alignment: Alignment.bottomRight,
//                   child: Text(
//                     time,
//                     style: const TextStyle(fontSize: 12, color: Colors.black54),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget chatInputField() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//       decoration: BoxDecoration(
//         //border: Border(top: BorderSide(color: Colors.grey.shade300)),
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             spreadRadius: 0,
//             blurRadius: 4,
//             offset: const Offset(0, -2),
//           ),
//           BoxShadow(
//             color: Colors.black.withOpacity(0.2),
//             spreadRadius: 0,
//             blurRadius: 6,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           GestureDetector(
//               onTap: (){},
//               child: SvgPicture.asset("assets/svgIcon/emojiIcon.svg")
//           ),
//           SizedBox(width: 10,),
//           Expanded(
//             child: TextField(
//               controller: _controller,
//               decoration:  InputDecoration(
//                 hintStyle: TextStyle(
//                   color: AppColors.neutralGray1,
//                 ),
//                 hintText: "Message",
//                 border: InputBorder.none,
//               ),
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.send, color: AppColors.redOrange),
//             onPressed: sendMessage, // Send message function call
//           ),
//           SizedBox(width: 10,),
//           GestureDetector(
//               onTap: (){},
//               child: SvgPicture.asset("assets/svgIcon/recordingIcon.svg")
//           ),
//           SizedBox(width: 5,),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/svg.dart';

import '../../common/colors/colors.dart';

class CouncellorChatOnline extends StatefulWidget {
  @override
  _CouncellorChatOnlineState createState() => _CouncellorChatOnlineState();
}

class _CouncellorChatOnlineState extends State<CouncellorChatOnline> {
  final TextEditingController _controller = TextEditingController();
  bool isTyping = false;
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


  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        isTyping = _controller.text.trim().isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.redOrange,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage:
                  NetworkImage('https://randomuser.me/api/portraits/men/1.jpg'),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Arjun Sharma',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Online',
                  style: TextStyle(color: Colors.green, fontSize: 14),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Dash(
            length: MediaQuery.of(context).size.width * 0.90,
            dashColor: AppColors.redOrange,
            dashLength: 10,
            dashThickness: 1,
            dashGap: 9,
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(10),
              children: [
                buildZoomMessage(),
                SizedBox(height: 10),
                buildPdfMessage(),
              ],
            ),
          ),
          chatInputField(),
        ],
      ),
    );
  }

  Widget buildZoomMessage() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(maxWidth: 350),
        decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomLeft:Radius.circular(30),
            )
        ),
        child: Row(
          children: [
            Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                ),
                child: Image.asset("assets/images/zoom_icon.png")
                // Row(
                //   children: [
                //     Text("zoom",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 16,color: AppColors.zoomColor),),
                //     SizedBox(width: 5,),
                //     SvgPicture.asset('assets/svgIcon/zoom.svg', width: 40),
                //   ],
                // )
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'https://app.zoom.us/wc/89346315118/start?fromPWA=1&pwd=wnVpq2fwLQBGhk0RbtX945jgcKkwxb.1',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPdfMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(maxWidth: 350),
        decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomLeft:Radius.circular(30),
            )
        ),
        child: Row(
          children: [
            Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                ),
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                ),
                child: Image.asset('assets/images/pdf.png', width: 40)),
            SizedBox(width: 5,),
            Expanded(
              child: Text(
                'ArjunReport.pdf',
                style:
                    TextStyle(
                      fontFamily: 'Roboto',
                        color: Colors.black, fontWeight: FontWeight.w400,fontSize: 16),
              ),
            ),
            // Icon(Icons.download, color: AppColors.redOrange),
            SvgPicture.asset("assets/svgIcon/download.svg"),
            SizedBox(width: 5),
            Text('9:30 AM', style: TextStyle(fontSize: 12)),
          ],
        ),
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

          isTyping
              ? GestureDetector(
            onTap: sendMessage,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: AppColors.redOrange, // Orange circle background
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send, color: Colors.white), // White send icon
            ),
          )
              : Row(
            children: [
              IconButton(
                icon: const Icon(Icons.attach_file, color: AppColors.black),
                onPressed: sendMessage, // Send message function call
              ),
              SizedBox(width: 5,),
              GestureDetector(
                  onTap: (){

                  },
                  child: SvgPicture.asset("assets/svgIcon/recordingIcon.svg")
              ),
              SizedBox(width: 5,),
            ],
          ),

        ],
      ),
    );
  }

  Widget chatBubble({required String text, required String time}) {
    return Align(
      alignment:Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.all(12),
            constraints: const BoxConstraints(maxWidth: 250),
            decoration: BoxDecoration(
                color: AppColors.lightSalmonPink,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomLeft:Radius.circular(30),
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
}
