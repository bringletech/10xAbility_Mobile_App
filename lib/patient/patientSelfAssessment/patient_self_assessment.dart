// import 'package:flutter/material.dart';
// import 'package:flutter_dash/flutter_dash.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:ten_x_app/common/colors/colors.dart';
// import 'package:ten_x_app/common/commonButton/common_button.dart';
// import 'package:ten_x_app/common/commonText/common_text.dart';
// import 'package:ten_x_app/common/commonText/common_text_colors.dart';
//
// class SelfAssessment extends StatefulWidget {
//   const SelfAssessment({super.key});
//
//   @override
//   State<SelfAssessment> createState() => _SelfAssessmentState();
// }
//
// class _SelfAssessmentState extends State<SelfAssessment> {
//   bool isExpanded = false;
//   int? _expandedIndex;
//   final List<Map<String, dynamic>> assessments = [
//     {
//       'title': "Depression",
//       'icon': 'assets/images/depression.png',
//       'description': "If You're Unsure If You\nAre Depressed, Our 5-\nMinute Test Can Help\nEvaluate Your Mood.",
//       'time': "5 Minutes"
//     },
//     {
//       'title': "Anxiety",
//       'icon': 'assets/images/anxiety.png',
//       'description':  "Find out if your anxiety\ncould be a sign of\nsomething more\nserious.",
//       'time': "4 Minutes"
//     },
//     {
//       'title': "Personality Test",
//       'icon': 'assets/images/personality.png',
//       'description':"Take this free\nPersonality Test and\nfind out more about\nwho you are and your\nstrengths.",
//       'time': "6 Minutes"
//     }
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Stack(
//           children: [
//             Positioned(
//               top: 375, // Adjust top position if needed
//               left: 0,
//               right: 0,
//               child: SvgPicture.asset(
//                 'assets/svgIcon/self.svg',
//                 height: MediaQuery.of(context).size.height * 0.4,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Existing top UI components (Header, User Info, Title)
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               Icon(Icons.arrow_back, color: AppColors.redOrange),
//                               CommonText(
//                                 text: "Hello Arjun",
//                                 fontSize: 17,
//                                 fontWeight: FontWeight.w400,
//                                 fontFamily: 'Poppins',
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Container(
//                                 padding: EdgeInsets.only(left: 23),
//                                 child: Row(
//                                   children: [
//                                     CommonText(
//                                       text: "Take A",
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w300,
//                                       fontFamily: 'Poppins',
//                                     ),
//                                     CommonTextColors(
//                                       text: " Quick ",
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w300,
//                                       fontFamily: 'Poppins',
//                                       color: AppColors.redOrange,
//                                     ),
//                                     CommonText(
//                                       text: "Test",
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w300,
//                                       fontFamily: 'Poppins',
//                                     ),
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//                       CircleAvatar(
//                         radius: 24,
//                         backgroundImage: AssetImage('assets/images/patientHomeImage2.png'),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 15),
//                   Container(
//                     child: Dash(
//                       length: MediaQuery.of(context).size.width * 0.90,
//                       dashColor: AppColors.redOrange,
//                       dashLength: 10,
//                       dashThickness: 1,
//                       dashGap: 9,
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Row(
//                     children: [
//                       SvgPicture.asset(
//                         'assets/svgIcon/assessment.svg',
//                         height: 30,
//                         width: 30,
//                       ),
//                       SizedBox(width: 10),
//                       CommonTextColors(
//                         text: "Self Assessment",
//                         fontSize: 17,
//                         fontWeight: FontWeight.w400,
//                         fontFamily: 'Poppins',
//                         color: AppColors.darkGray1,
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 20),
//                   ListView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     itemCount: assessments.length,
//                     itemBuilder: (context, index) {
//                       return  GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             // Toggle the current container: open if closed, close if opened
//                             if (_expandedIndex == index) {
//                               _expandedIndex = null; // Close if the same container is tapped again
//                             } else {
//                               _expandedIndex = index; // Open the tapped container and close others
//                             }
//                           });
//                         },
//                         child: AnimatedContainer(
//                           duration: Duration(milliseconds: 600),
//                            curve: Curves.bounceIn,
//                           //height: isExpanded ? 250 : 120,
//                           width: 350,
//                           margin: EdgeInsets.symmetric(vertical: 10),
//                           padding: EdgeInsets.all(16),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(45),
//                             border: Border.all(color: Colors.red, width: 1),
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: index.isEven
//                                 ? [
//                               // Image on the left, Text & Description on the right
//                               Image.asset(
//                                 assessments[index]['icon'],
//                                 height: isExpanded ? 200 : 80,
//                                 width: isExpanded ? 80 : 80,
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(left: isExpanded ? 10 : 10.0,),
//                                 child: Column(
//                                   //crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     CommonText(
//                                       text: assessments[index]['title']!,
//                                       fontSize: 24,
//                                       fontFamily: 'Poppins',
//                                       fontWeight: FontWeight.w400,
//                                     ),
//                                    // if (isExpanded)
//                                     if (_expandedIndex == index)
//                                       Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Padding(
//                                             padding: EdgeInsets.only(left: 8),
//                                             child: Column(
//                                               crossAxisAlignment: CrossAxisAlignment.start,
//                                               children: [
//                                                 CommonText(
//                                                   text: assessments[index]['description']!,
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.w400,
//                                                   fontFamily: 'Poppins',
//                                                 ),
//                                                 SizedBox(height: 5),
//                                                 Padding(
//                                                   padding: const EdgeInsets.only(right: 90.0),
//                                                   child: Row(
//                                                     children: [
//                                                       Icon(Icons.update_outlined),
//                                                       SizedBox(width: 5),
//                                                       CommonText(
//                                                         text: "5 Minutes",
//                                                         fontSize: 12,
//                                                         fontWeight: FontWeight.w400,
//                                                         fontFamily: 'Poppins',
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 SizedBox(height: 5),
//                                                 CommonFirstButton(
//                                                   onPressed: () {},
//                                                   text: 'Take Test',
//                                                   height: 30,
//                                                   width: 176,
//                                                   fontSize: 15,
//                                                   fontFamily: 'Poppins',
//                                                   fontWeight: FontWeight.w500,
//                                                   color: Colors.white,
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                   ],
//                                 ),
//                               ),
//                             ]
//                                 : [
//                               // Text & Description on the left, Image on the right
//                               Expanded(
//                                 child: Padding(
//                                   padding: EdgeInsets.only(left: isExpanded ? 10 : 20.0, ),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.only(left:70.0),
//                                         child: CommonText(
//                                           text: assessments[index]['title']!,
//                                           fontSize: 24,
//                                           fontFamily: 'Poppins',
//                                           fontWeight: FontWeight.w400,
//                                         ),
//                                       ),
//                                       if (_expandedIndex == index)
//                                      // if (isExpanded)
//                                         Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             Padding(
//                                               padding: EdgeInsets.only(left: 8),
//                                               child: Column(
//                                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                                 children: [
//                                                   CommonText(
//                                                     text: assessments[index]['description']!,
//                                                     fontSize: 16,
//                                                     fontWeight: FontWeight.w400,
//                                                     fontFamily: 'Poppins',
//                                                   ),
//                                                   SizedBox(height: 5),
//                                                   Padding(
//                                                     padding: const EdgeInsets.only(right: 90.0),
//                                                     child: Row(
//                                                       children: [
//                                                         Icon(Icons.update_outlined),
//                                                         SizedBox(width: 5),
//                                                         CommonText(
//                                                           text: "5 Minutes",
//                                                           fontSize: 12,
//                                                           fontWeight: FontWeight.w400,
//                                                           fontFamily: 'Poppins',
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   SizedBox(height: 5),
//                                                   CommonFirstButton(
//                                                     onPressed: () {},
//                                                     text: 'Take Test',
//                                                     height: 30,
//                                                     width: 176,
//                                                     fontSize: 15,
//                                                     fontFamily: 'Poppins',
//                                                     fontWeight: FontWeight.w500,
//                                                     color: Colors.white,
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Image.asset(
//                                 assessments[index]['icon'],
//                                 height: isExpanded ? 200 : 80,
//                                 width: isExpanded ? 80 : 80,
//                               ),
//                             ],
//                           )
//
//                         ),
//                       );
//                     },
//                   ),
//                   SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(30),
//                   topRight: Radius.circular(30),
//                 ),
//               ),
//               margin: EdgeInsets.only(top: 350),
//               height: MediaQuery.of(context).size.height * 0.60,
//               child: Column(
//                 children: [
//                   Divider(),
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Text(
//                       "Cognitive Assessments",
//                       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   Expanded(
//                     child: ListView(
//                       children: [
//                         assessmentCard(
//                           "DMIT Test",
//                           "Unlock Insights Into Your Innate Qualities And Maximize Growth. Get Started With Your DMIT Test Now",
//                         ),
//                         assessmentCard(
//                           "Psychometric Test",
//                           "Understand Yourself Better With Psychometric Testing. Measure Mental Capabilities And Unlock New Opportunities",
//                         ),
//                         assessmentCard(
//                           "NLP Test",
//                           "Transform Your Mind With NLP Therapy. Break Barriers, Build Confidence, And Achieve Your Goals.",
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           )
//         ]),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ten_x_app/common/colors/colors.dart';
import 'package:ten_x_app/common/commonButton/common_button.dart';
import 'package:ten_x_app/common/commonButton/common_button_get_otp.dart';
import 'package:ten_x_app/common/commonText/common_text.dart';
import 'package:ten_x_app/common/commonText/common_text_colors.dart';

import '../../controller/appstream_controller.dart';

class SelfAssessment extends StatefulWidget {
  final bool? isShown;
  const SelfAssessment({Key? key,this.isShown}): super(key: key);

  @override
  State<SelfAssessment> createState() => _SelfAssessmentState();
}

class _SelfAssessmentState extends State<SelfAssessment> {
  AppStreamController appStreamController = AppStreamController.instance;
  bool isExpanded = false;
  int? _expandedIndex;
  final List<Map<String, dynamic>> assessments = [
    {
      'title': "Depression",
      'icon': 'assets/images/depression.png',
      'description': "If You're Unsure If You\nAre Depressed, Our 5-\nMinute Test Can Help\nEvaluate Your Mood.",
      'time': "5 Minutes"
    },
    {
      'title': "Anxiety",
      'icon': 'assets/images/anxiety.png',
      'description': "Find out if your anxiety\ncould be a sign of\nsomething more\nserious.",
      'time': "4 Minutes"
    },
    {
      'title': "Personality Test",
      'icon': 'assets/images/personality.png',
      'description': "Take this free\nPersonality Test and\nfind out more about\nwho you are and your\nstrengths.",
      'time': "6 Minutes"
    }
  ];

  @override
  void initState() {
    // TODO: implement initState
    appStreamController.handleBottomTab.add(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 375,
              left: 0,
              right: 0,
              child: SvgPicture.asset(
                'assets/svgIcon/self.svg',
                height: MediaQuery.of(context).size.height * 0.4,
                fit: BoxFit.cover,
              ),
            ),
              SingleChildScrollView(
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
                                              text: "Take A",
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300,
                                              fontFamily: 'Poppins',
                                            ),
                                            CommonTextColors(
                                              text: " Quick ",
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300,
                                              fontFamily: 'Poppins',
                                              color: AppColors.redOrange,
                                            ),
                                            CommonText(
                                              text: "Test",
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
                                'assets/svgIcon/assessment.svg',
                                height: 30,
                                width: 30,
                              ),
                              SizedBox(width: 10),
                              CommonTextColors(
                                text: "Self Assessment",
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins',
                                color: AppColors.darkGray1,
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                      ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: assessments.length,
                    itemBuilder: (context, index) {
                      return  GestureDetector(
                        onTap: () {
                          setState(() {
                            // Toggle the current container: open if closed, close if opened
                            if (_expandedIndex == index) {
                              _expandedIndex = null; // Close if the same container is tapped again
                            } else {
                              _expandedIndex = index; // Open the tapped container and close others
                            }
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 600),
                           curve: Curves.bounceIn,
                          //height: isExpanded ? 250 : 120,
                          width: 350,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(45),
                            border: Border.all(color: Colors.red, width: 1),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: index.isEven
                                ? [
                              // Image on the left, Text & Description on the right
                              Image.asset(
                                assessments[index]['icon'],
                                height: isExpanded ? 200 : 80,
                                width: isExpanded ? 80 : 80,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: isExpanded ? 10 : 10.0,),
                                child: Column(
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonText(
                                      text: assessments[index]['title']!,
                                      fontSize: 24,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                   // if (isExpanded)
                                    if (_expandedIndex == index)
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 8),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                CommonText(
                                                  text: assessments[index]['description']!,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'Poppins',
                                                ),
                                                SizedBox(height: 5),
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 90.0),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.update_outlined),
                                                      SizedBox(width: 5),
                                                      CommonText(
                                                        text: "5 Minutes",
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w400,
                                                        fontFamily: 'Poppins',
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                CommonFirstButton(
                                                  onPressed: () {},
                                                  text: 'Take Test',
                                                  height: 30,
                                                  width: 176,
                                                  fontSize: 15,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ]
                                : [
                              // Text & Description on the left, Image on the right
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: isExpanded ? 10 : 20.0, ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left:70.0),
                                        child: CommonText(
                                          text: assessments[index]['title']!,
                                          fontSize: 24,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      if (_expandedIndex == index)
                                     // if (isExpanded)
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left: 8),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  CommonText(
                                                    text: assessments[index]['description']!,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'Poppins',
                                                  ),
                                                  SizedBox(height: 5),
                                                  Padding(
                                                    padding: const EdgeInsets.only(right: 90.0),
                                                    child: Row(
                                                      children: [
                                                        Icon(Icons.update_outlined),
                                                        SizedBox(width: 5),
                                                        CommonText(
                                                          text: "5 Minutes",
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w400,
                                                          fontFamily: 'Poppins',
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  CommonFirstButton(
                                                    onPressed: () {},
                                                    text: 'Take Test',
                                                    height: 30,
                                                    width: 176,
                                                    fontSize: 15,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              Image.asset(
                                assessments[index]['icon'],
                                height: isExpanded ? 200 : 80,
                                width: isExpanded ? 80 : 80,
                              ),
                            ],
                          )

                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2), // Shadow color with opacity
                              blurRadius: 10, // Soften the shadow
                              spreadRadius: 3, // Extend the shadow
                              offset: Offset(0, 5), // Move the shadow down
                            ),
                          ],
                        ),
                        // margin: EdgeInsets.only(
                        //     top: 550, bottom: 0, left: 0, right: 0),
                        height: MediaQuery.of(context).size.height * 0.60,
                        child: Column(
                          children: [
                            Container(height: 25,
                              width: 152,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40),
                                ),),
                              child: Divider(color: AppColors.grey,
                                thickness: 5,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                "Cognitive Assessments",
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              child: ListView(
                                children: [
                                  assessmentCard("DMIT Test", "Unlock Insights Into\nYour Innate Qualities\nAnd Maximize Growth.","Get Started with your\nDMIT test Now",Image.asset('assets/images/dmit.png',height: 150,width: 150,)),
                                  assessmentCard("Psychometric Test", "Understand Yourself\nBetter With\nPsychometric Testing.","Measure mental\ncapabilities and unlock\nnew opportunities",Image.asset('assets/images/psychometric.png',height: 150,width: 150,)),
                                  assessmentCard("NLP Test", "Transform Your Mind \nWith NLP Therapy.","Break barriers, build\nconfidence, and achieve\nyour goals.",Image.asset('assets/images/nlp.png',height: 150,width: 150,)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
           // ),
          ],
        ),
      ),
    );
  }
}


Widget assessmentCard(String title, String description, String content,ImagePath) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    ),
    margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ImagePath,
              SizedBox(width: 15,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    text: title,
                    fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Poppins',),
                  SizedBox(height: 4),
                  CommonText(
                    text:
                    description,
                    fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w400,),
                  CommonText(
                    text:
                    content,
                   fontSize: 13, fontFamily: 'Poppins', fontWeight: FontWeight.w300,),
                ],
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonFirstButtonGetOtp(
                onPressed: () {},
               text:  "View More",
                height: 40, width: 145,
                fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w500,
                 contenerColor: AppColors.white, borderColor: AppColors.redOrange, color: AppColors.black,

              ),
              CommonFirstButton(
                onPressed: () {},
                text: "Book Now",
                height: 40, width: 145,
                fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w500,
                  color: AppColors.white
              ),
            ],
          ),
        ],
      ),
    ),
  );
}