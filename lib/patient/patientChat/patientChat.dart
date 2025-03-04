import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:ten_x_app/patient/patientChat/patient_chat_online.dart';

import '../../common/colors/colors.dart';
import '../../common/commonText/common_text.dart';
import '../../common/commonText/common_text_colors.dart';

class Patientchat extends StatefulWidget {
  const Patientchat({super.key});

  @override
  State<Patientchat> createState() => _PatientchatState();
}

class _PatientchatState extends State<Patientchat> with SingleTickerProviderStateMixin {
  final List<String> items = List.generate(15, (index) => "Item $index");
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0)).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _controller.forward();
        _scrollController.animateTo(
          _scrollController.position.minScrollExtent,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: CommonText(
                text: 'Messages',
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
              backgroundColor: Colors.white,
              elevation: 0,
              floating: true, // ✅ Scroll hone par hide/show hoga
              snap: true, // ✅ Scroll end hone par smooth effect aayega
              pinned: false, // ✅ Pinned false hone se scroll hone par hide ho jayega
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Dash(
                    length: MediaQuery.of(context).size.width * 0.90,
                    dashColor: AppColors.redOrange,
                    dashLength: 10,
                    dashThickness: 1,
                    dashGap: 9,
                  ),
                ],
              ),
            ),
          ];
        },
        body: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(), // ✅ Always scrollable
          itemCount: items.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PatientChatOnline()),
                );
              },
              child: Container(
                key: ValueKey(index),
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        index == 0
                            ? AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            return FadeTransition(
                              opacity: _fadeAnimation,
                              child: SlideTransition(
                                position: _slideAnimation,
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: AssetImage("assets/images/pic.png"),
                                ),
                              ),
                            );
                          },
                        )
                            : CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage("assets/images/pic.png"),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 215,
                              child: CommonText(
                                text: 'Aarhie Kaushik',
                                fontSize: 17,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              width: 215,
                              child: CommonTextColors(
                                text: 'Hi Arjun, just checking in—how has yo...',
                                fontSize: 13,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                color: AppColors.mediumDarkGray,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CommonTextColors(
                          text: 'Just Now',
                          fontSize: 10,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          color: AppColors.neutralGray,
                        ),
                        SizedBox(height: 2),
                        Container(
                          padding: EdgeInsets.only(left: 10, top: 4),
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            color: AppColors.redOrange,
                            shape: BoxShape.circle,
                          ),
                          child: CommonTextColors(
                            text: '1',
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

