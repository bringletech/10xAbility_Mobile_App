/*
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:ten_x_app/patient/patientChat/patient_chat_online.dart';

import '../../common/colors/colors.dart';
import '../../common/commonText/common_text.dart';
import '../../common/commonText/common_text_colors.dart';
import 'councellor_chat_online.dart';

class CounsellorChat extends StatefulWidget {
  const CounsellorChat({super.key});

  @override
  State<CounsellorChat> createState() => _CounsellorChatState();
}

class _CounsellorChatState extends State<CounsellorChat> with SingleTickerProviderStateMixin {
  final List<String> items = List.generate(2, (index) => "Item $index");
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
              automaticallyImplyLeading: false,
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
        body: Column(
          children: [
            ListView.builder(
              physics: AlwaysScrollableScrollPhysics(), // ✅ Always scrollable
              itemCount: items.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CouncellorChatOnline()),
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
                                      backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/1.jpg'),
                                    ),
                                  ),
                                );
                              },
                            )
                                : CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/1.jpg'),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 215,
                                  child: CommonText(
                                    text: 'Arjun Sharma',
                                    fontSize: 17,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  width: 215,
                                  child: CommonTextColors(
                                    text: 'Sent 2m Ago',
                                    fontSize: 13,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.timeColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

*/

import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';

import '../../common/colors/colors.dart';
import '../../common/commonText/common_text.dart';
import '../../common/commonText/common_text_colors.dart';
import 'councellor_chat_online.dart';
class CounsellorChat extends StatefulWidget {
  const CounsellorChat({super.key});

  @override
  State<CounsellorChat> createState() => _CounsellorChatState();
}

class _CounsellorChatState extends State<CounsellorChat> {
  final List<String> items = List.generate(2, (index) => "Item $index");
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
                child: CommonText(
                  text: 'Messages',
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
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
              SizedBox(height: 30,),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  itemBuilder: (context, index){
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CouncellorChatOnline()),
                        );
                      },
                      child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          //color: Colors.deepOrange,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    //backgroundColor: Colors.deepOrange,
                                    backgroundImage: AssetImage("assets/images/patientHomeImage2.png"),
                                  ),
                                  SizedBox(width: 10,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 215,
                                        child: CommonText(
                                          text: 'Arjun Sharma',
                                          fontSize: 17,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 215,
                                        child: CommonTextColors(
                                          text: 'Sent 2m Ago',
                                          fontSize: 13,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.timeColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          )
                      ),
                    );
                  }
              ),
              SizedBox(height: 20,),
              Image.asset("assets/images/patientChat.png"),
              CommonTextColors(
                text: 'Nothing More to Show',
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                color: AppColors.mediumGray,
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}

