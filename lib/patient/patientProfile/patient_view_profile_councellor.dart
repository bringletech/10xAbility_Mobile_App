import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ten_x_app/common/colors/colors.dart';
import 'package:ten_x_app/common/commonButton/common_button.dart';
import 'package:ten_x_app/common/commonText/common_text.dart';
import 'package:ten_x_app/common/commonText/common_text_colors.dart';


class PatientViewProfileCouncellor extends StatefulWidget {
  const PatientViewProfileCouncellor({super.key});

  @override
  State<PatientViewProfileCouncellor> createState() => _PatientViewProfileCouncellorState();
}

class _PatientViewProfileCouncellorState extends State<PatientViewProfileCouncellor> {

  final List<Map<String, String>> review = [
    {
      'text': "I liked the vigilance in asking questions and ensuring all information are understood. I like how I was provided all the necessary information about what to expect prior to the start of the session, and the reassurance provided throughout the session.",
      'author': "Surbhi Mishra",
      'image': "assets/images/reviewImage.png" // Replace with actual image URL
    },
    {
      'text': "The support and guidance provided were amazing. I felt comfortable and confident throughout the process.",
      'author': "John Doe",
      'image': "assets/images/reviewImage.png"
    },
    // Add more testimonials here
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
        child: SingleChildScrollView(
        child: Column(
            children: [
            Padding(padding: const EdgeInsets.all(10.0),
                child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                  backgroundImage:
                      AssetImage('assets/images/patientHomeImage2.png'),
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
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 130,
                  width: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  // Ensures the image stays inside the border
                  child: Image.asset(
                    'assets/images/Aditi.png',
                    height: 130,
                    width: 110,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 9,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: "Aditi Mukherjee",
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CommonText(
                      text: "DMIT Counsellor",
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Poppins',
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        CommonText(
                          text: "4.2",
                          fontSize: 11,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Poppins',
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Row(
                          children: List.generate(5, (index) {
                            if (index < 4) {
                              return Icon(Icons.star,
                                  color: AppColors.redOrange, size: 14);
                            } else {
                              return Icon(Icons.star_half,
                                  color: AppColors.redOrange, size: 14);
                            }
                          }),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        CommonText(
                          text: "(100+ Reviews)",
                          fontSize: 11,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Poppins',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        CommonText(
                          text: "Experience:",
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(
                          width: 2.5,
                        ),
                        CommonText(
                          text: '190+ Hours Of counselling',
                          fontSize: 11,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w300,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        CommonText(
                          text: "Languages:",
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(
                          width: 2.5,
                        ),
                        CommonText(
                          text: 'English, Hindi, Gujarati',
                          fontSize: 11,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w300,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        CommonText(
                          text: "Session Mode:",
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(
                          width: 2.5,
                        ),
                        CommonText(
                          text: 'Virtual And In-person',
                          fontSize: 11,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w300,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 20,),
            CommonText(
              text:
                  "Aditi Mukherjee has completed over\n190 hours of counseling, building strong connections with more than 70 clients.",
              fontSize: 17,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
                SizedBox(height: 10,),
            CommonText(
              text:
                  "Aditi Mukherjee is a highly accomplished counsellor, celebrated for her gentle demeanor and empathetic approach to client care. With expertise in navigating complex emotional challenges, she approaches each interaction with unwavering dedication and compassion. Her genuine passion for helping others is evident in every aspect of her work, making her a reliable and trusted guide for those she supports.",
              fontSize: 15,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w300,
            ),
               SizedBox(height: 20,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   CommonText(
                     text:"I",
                     fontSize: 22,
                     fontFamily: 'Poppins',
                     fontWeight: FontWeight.w600,
                   ),
                   SizedBox(width: 5,),
                   ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    colors: [AppColors.special, AppColors.pink], // Gradient colors
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ).createShader(bounds);
                },
                child: Text(
                  "Specialize",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.white, // Required, but overridden by shader
                  ),
                ),
              ),
                   SizedBox(width: 5,),
                   CommonText(
                     text:
                     "In",
                     fontSize: 17,
                     fontFamily: 'Poppins',
                     fontWeight: FontWeight.w600,
                   ),
                 ],
               ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 170,
                      width: 160,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xffF7EDBA), Color(0xffFDCED4)], // Define gradient colors
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(0), // No rounding on bottom right
                        ), // Rounded corners
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1), // Light shadow
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: Offset(2, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            SvgPicture.asset('assets/svgIcon/special.svg'),
                            SizedBox(height: 10,),
                            CommonText(
                                text: 'Career Counselling',
                                fontSize: 13, fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400)
                          ]),
                    ),
                   // SizedBox(width: 10,),
                    Container(
                      height: 170,
                      width: 160,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xffFDCDD5), Color(0xffC9F6FC)], // Define gradient colors
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(0), // No rounding on bottom right
                        ), // Rounded corners
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1), // Light shadow
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: Offset(2, 5),
                          ),
                        ],
                      ),
                      child:  Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            SvgPicture.asset('assets/svgIcon/special.svg'),
                            SizedBox(height: 10,),
                            CommonText(
                                text: 'Mindfulness Practices',
                                fontSize: 13, fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400)
                          ]),
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Center(
                  child: CommonFirstButton(
                      onPressed: (){},
                      text: 'Book Session', height: 40, width: 181,
                      fontSize: 17, fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400, color: AppColors.white),
                ),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 5,
                      width: 100,
                      decoration: BoxDecoration(
                       color: AppColors.redOrange,
                        borderRadius: BorderRadius.circular(2), // Rounded corners
                      ),
                      child: Divider(
                        color: AppColors.redOrange,
                      ),
                    ),
                    CommonText(text: 'Stories that shaped \n    our connection',
                        fontSize: 13,
                        fontFamily: 'Poppins', fontWeight: FontWeight.w300),
                    Container(
                      height: 5,
                      width: 100,
                      decoration: BoxDecoration(
                        color: AppColors.redOrange,
                        borderRadius: BorderRadius.circular(2), // Rounded corners
                      ),
                      child: Divider(
                        color: AppColors.redOrange,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15,),
                SizedBox(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: review.length,
                    itemBuilder: (context, index) {
                      return reviewCard(review: review[index]);
                    },
                  ),
                ),
          ])),
    ])
    )));
  }
}


class reviewCard extends StatelessWidget {
  final Map<String, String> review;

  const reviewCard({required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250, // Adjust width as per design
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                "assets/svgIcon/quote.svg",
                width: 30,  // Adjust size
                height: 30,
                colorFilter: ColorFilter.mode(AppColors.lightOrange, BlendMode.srcIn),
              ),
              CircleAvatar(
                //backgroundImage: NetworkImage(review['image']!),
                backgroundImage: AssetImage(review['image']!),
              ),
            ],
          ),
          SizedBox(height: 5),
          CommonText(
           text:  review['text']!,
           fontSize: 8,
            fontFamily: 'Inter', fontWeight: FontWeight.w300,),
            //overflow: TextOverflow.ellipsis,
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: List.generate(5,
                        (index) => Icon(Icons.star, color: AppColors.lightOrange, size: 15)),
              ),
              SizedBox(height: 5),
              CommonText(
               text:  "~ ${review['author']!}",
                fontSize: 12, fontFamily: 'Inter', fontWeight: FontWeight.w400,
              ),
            ],
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}