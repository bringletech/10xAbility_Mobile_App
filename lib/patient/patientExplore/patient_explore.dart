import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../common/colors/colors.dart';
import '../../../common/commonButton/common_button.dart';
import '../../../common/commonText/common_text.dart';
import '../../../common/commonText/common_text_colors.dart';

class PatientExplore extends StatefulWidget {
  const PatientExplore({super.key});

  @override
  State<PatientExplore> createState() => _PatientExploreState();
}

class _PatientExploreState extends State<PatientExplore> {
  final CarouselSliderController carouselController = CarouselSliderController();
  int _currentIndex = 0;
  final List<Map<String, String>> carouselItems = [
    {
      'image': 'assets/images/carouselImage.png',
      'text': 'You are not alone on this journey—hope and support are with you every step of the way.'
    },
    {
      'image': 'assets/images/carouselImage.png',
      'text': 'You are not alone on this journey—hope and support are with you every step of the way.'
    },
    {
      'image': 'assets/images/carouselImage.png',
      'text': 'You are not alone on this journey—hope and support are with you every step of the way.'


    },
  ];
  int _selectedIndex = 0;
  final List<Map<String, String>> resources1 = const [
    {
      "image": "assets/images/aditiImage.png",
      "title": "Brain Energy: A Revolutionary...",
      "buttonText": "View More",
    },
    {
      "videoThumbnail": "assets/images/aditiImage.png",
      "title": "Why You Should Try Therapy Yesterday | Dr. Emily Anhalt | TEDxBoulder",
      "buttonText": "Watch Video",
    },
    // {
    //   "image": "assets/images/aditiImage.png",
    //   "title": "Brain Energy: A Revolutionary...",
    //   "buttonText": "View More",
    // },
  ];
  final List<Map<String, String>> resources = const [
    {
      "image": "assets/images/aditiImage.png",
      "title": "Brain Energy: A Revolutionary...",
      "buttonText": "View More",
    },
    {
      "videoThumbnail": "assets/images/aditiImage.png",
      "title": "Why You Should Try Therapy Yesterday | Dr. Emily Anhalt | TEDxBoulder",
      "buttonText": "Watch Video",
    },
    {
      "image": "assets/images/aditiImage.png",
      "title": "Brain Energy: A Revolutionary...",
      "buttonText": "View More",
    },
  ];
  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index on button tap
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                //color: Colors.deepOrange,
                margin: EdgeInsets.only(top: 40,left: 15),
                child: CommonText(
                  text: 'Community',
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 20,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
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
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => _onTabTapped(0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          border: Border.all(color: _selectedIndex == 0
                              ? AppColors.redOrange
                              : AppColors.lightGray, width: 1.5),
                          borderRadius: BorderRadius.circular(30),
                          color: _selectedIndex == 0
                              ? AppColors.redOrange
                              : Colors.white,
                        ),
                        child: CommonTextColors(
                          text: "My Feed",
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          color: _selectedIndex == 0
                              ? Colors.white
                              : AppColors.mediumGray1,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _onTabTapped(1),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                          border: Border.all(color: _selectedIndex == 1
                              ? AppColors.redOrange
                              : AppColors.lightGray, width: 1.5),
                          borderRadius: BorderRadius.circular(30),
                          color: _selectedIndex == 1
                              ? AppColors.redOrange
                              : Colors.white,
                        ),
                        child: CommonTextColors(
                          text: "Recommended By counselor",
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          color: _selectedIndex == 1
                              ? Colors.white
                              : AppColors.mediumGray1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Display content based on selected index
              _selectedIndex == 0
                  ? Column(
                children: List.generate(1, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Column(
                      children: [
                        ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: resources1.length,
                            itemBuilder: (context, index){
                              final resource1 = resources1[index];
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
                                    if (resource1.containsKey("image"))
                                      Container(
                                        decoration: BoxDecoration(
                                          //color: Colors.deepOrange,
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        padding: EdgeInsets.all(5),
                                        //margin: EdgeInsets.all(5),
                                        height: 174,
                                        width: 155,
                                        child: Image.asset(resource1["image"]!,),
                                      ),
                                    if (resource1.containsKey("videoThumbnail"))
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              //color: Colors.deepOrange,
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                            padding: EdgeInsets.all(5),
                                            //margin: EdgeInsets.all(5),
                                            height: 174,
                                            width: 155,
                                            child: Image.asset(resource1["videoThumbnail"]!,),
                                          ),
                                          Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              //color: Colors.black54,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(Icons.play_circle_fill, size: 30, color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    //SizedBox(width: 10,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        //SizedBox(height: 15,),
                                        Container(
                                          //color: Colors.pink,
                                          width:MediaQuery.of(context).size.width*0.48,
                                          child: CommonText(
                                            text: resource1["title"]!,
                                            fontSize: 13,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                        CommonFirstButton(
                                          onPressed: () {  },
                                          text: resource1["buttonText"]!,
                                          height: 24,
                                          width: 116,
                                          fontSize: 13,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w300,
                                          color: AppColors.white,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            }
                        ),
                        Stack(

                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  // border: Border.all(
                                  //     color: AppColors.redOrange
                                  // )
                              ),
                              //color: Colors.yellow,
                              // height: 300,
                              // width: 360,
                              child: CarouselSlider.builder(
                                itemCount: carouselItems.length,
                                itemBuilder: (context, index, realIndex) {
                                  final item = carouselItems[index];
                                  return Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        //color: Colors.black,
                                        child: Image.asset(
                                          item["image"]!,
                                          //height: MediaQuery.of(context).size.height*1,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Container(
                                        width: 272,
                                        child: CommonText(
                                          text: item["text"]!,
                                          fontSize: 20,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                options: CarouselOptions(
                                  height: MediaQuery.of(context).size.height*0.422,
                                    viewportFraction: 1,
                                    enlargeCenterPage: true,
                                    enableInfiniteScroll: true,
                                    autoPlay: false,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _currentIndex = index;
                                      });
                                    }),
                                carouselController: carouselController,
                              ),
                            ),
                            Positioned(
                              top: 40,
                              left: 0,
                              right: 0,
                              child: Align(
                                alignment: Alignment.center,
                                child: AnimatedSmoothIndicator(
                                  activeIndex: _currentIndex,
                                  count: carouselItems.length,
                                  effect: ExpandingDotsEffect( // Smooth animation effect
                                    dotWidth: 8,
                                    dotHeight: 8,
                                    activeDotColor: AppColors.redOrange,
                                    dotColor: Colors.grey.shade400,
                                  ),
                                  onDotClicked: (index) {
                                    carouselController.animateToPage(index); // Clickable dots
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  );
                }),
              )
                  : Column(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: resources.length,
                        itemBuilder: (context, index){
                          final resource = resources[index];
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
                                if (resource.containsKey("image"))
                                Container(
                                  decoration: BoxDecoration(
                                    //color: Colors.deepOrange,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  padding: EdgeInsets.all(5),
                                  //margin: EdgeInsets.all(5),
                                  height: 174,
                                  width: 155,
                                  child: Image.asset(resource["image"]!,),
                                ),
                                if (resource.containsKey("videoThumbnail"))
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          //color: Colors.deepOrange,
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        padding: EdgeInsets.all(5),
                                        //margin: EdgeInsets.all(5),
                                        height: 174,
                                        width: 155,
                                        child: Image.asset(resource["videoThumbnail"]!,),
                                      ),
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          //color: Colors.black54,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(Icons.play_circle_fill, size: 30, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                //SizedBox(width: 10,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    //SizedBox(height: 15,),
                                    Container(
                                      //color: Colors.pink,
                                      width:MediaQuery.of(context).size.width*0.5,
                                      child: CommonText(
                                        text: resource["title"]!,
                                        fontSize: 13,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    CommonFirstButton(
                                      onPressed: () {  },
                                      text: resource["buttonText"]!,
                                      height: 24,
                                      width: 116,
                                      fontSize: 13,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w300,
                                      color: AppColors.white,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        }
                    ),
                  ]
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
