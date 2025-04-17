import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ten_x_app/common/colors/colors.dart';
import 'package:ten_x_app/common/commonText/common_text.dart';

import '../../auth/api_services/api_service.dart';
import '../../auth/model/get_current_counsellor_details_response_model.dart';
import '../../common/commonText/common_text_colors.dart';

class CounsellorProfile extends StatefulWidget {
  const CounsellorProfile({super.key});

  @override
  State<CounsellorProfile> createState() => _CounsellorProfileState();
}

class _CounsellorProfileState extends State<CounsellorProfile> {
  int selectedTab = 0;
  bool isLoading = false;
  String fullName="",profilePicture="",specialization="",experience="",language="",bio="",email="",
  mobileNo="",dob="",gender="",age="",country="",pincode="",state="",college="",education="",degree="",
  certificate="",aadhaarNumber="",aadhaarBack="",aadhaarFront="",pancardNo="",role="";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentTherapistDetails();
  }



  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
      child: CircularProgressIndicator(color: AppColors.darkOrange),)
        : Scaffold(
            backgroundColor: AppColors.white,
            body: Padding(
              padding: EdgeInsets.all(12),
              child: SingleChildScrollView(
                child: Column(children: [
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 40,),
                    child: Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back,
                                color: AppColors.redOrange)),
                        SizedBox(width: 15,),
                        CommonText(
                          text: 'Profile',
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
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
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          spreadRadius: 1,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(children: [
                          Container(
                            width: 160, // Set width as per your design
                            height: 160, // Set height as per your design
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ), // Rounded corners
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ), // Same as container
                              child: CachedNetworkImage(
                                imageUrl: profilePicture,
                                errorWidget: (context, url, error) =>
                                    Image.network(
                                  'https://dummyimage.com/500x500/aaa/000000.png&text=No+Image',
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 130,
                            left: 135,
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 32,
                              width: 32,
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: SvgPicture.asset(
                                'assets/svgIcon/edit.svg',
                                height: 12,
                                width: 12,
                              ),
                            ),
                          ),
                        ]),

                        SizedBox(height: 5,),
                        CommonText(
                            text: fullName,
                            fontSize: 25,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400),
                        CommonText(
                            text: 'DMIT Counsellor',
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 15),
                          child: CommonText(
                              text: 'Experience',
                              fontSize: 13,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: CommonTextColors(
                            text: experience,
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            color: AppColors.darkOrange,
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 15),
                          child: CommonText(
                              text: 'Specialize',
                              fontSize: 13,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildTag(specialization),
                          ],
                        ),
                        SizedBox(height: 12),
                        // Languages
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 15),
                          child: CommonText(
                              text: 'Language',
                              fontSize: 13,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildTag(language),
                          ],
                        ),
                        SizedBox(height: 12),
                        // Bio Section
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 15),
                          child: CommonText(
                              text: 'Bio',
                              fontSize: 13,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 6),
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: CommonTextColors(
                            text: bio,
                            fontSize: 10,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            color: AppColors.darkOrange,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTab("Personal Info", 0),
                      _buildTab("Qualification", 1),
                      _buildTab("Documents", 2),
                    ],
                  ),
                  _buildSelectedContent(),
                ]),
              ),
            ));
  }

  Widget _buildTag(String text) {
    return Container(
      width:MediaQuery.of(context).size.width*0.85,
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: BoxDecoration(
        color:AppColors.darkOrange,
        borderRadius: BorderRadius.circular(10),
      ),
      child: CommonTextColors(
        text: text, fontSize: 13, fontFamily: 'Poppins',
        fontWeight: FontWeight.w400, color: AppColors.white,
      ),
    );
  }

  Widget _buildTab(String text, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = index;
        });
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color:  Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: CommonTextColors(
              text: text,
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              color:  AppColors.darkOrange,
            ),
          ),
          SizedBox(height: 5), // Add spacing between text and underline
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: selectedTab == index ? 100 : 0, // Show the underline only for selected tab
            height: 2,
            decoration: BoxDecoration(
              color: AppColors.darkOrange,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedContent() {
    if (selectedTab == 0) {
      return _buildPersonalInfo();
    } else if (selectedTab == 1) {
      return _buildQualification();
    } else {
      return _buildDocuments();
    }
  }

  Widget _buildPersonalInfo()  {
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(left: 20),
                child: CommonText(
                  text: 'Personal Information',
                  fontSize: 21,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 8, right: 8),
                height: 19.43,
                width: 51.82,
                decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonTextColors(
                      text: 'Edit',
                      fontSize: 10.46,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      color: AppColors.darkOrange,
                    ),
                    SvgPicture.asset(
                      'assets/svgIcon/edit.svg', height: 9.34, width: 9.34,),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 10,),
          Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width*0.3,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonTextColors(
                      text: "Full Name",
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w300,
                      color: AppColors.lightBlack,),
                    CommonTextColors(text: fullName,
                        fontSize: 11,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        color: AppColors.darkOrange),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width*0.5  ,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonTextColors(text: "Mobile", fontSize: 16,
                        fontFamily: 'Poppins', fontWeight: FontWeight.w300,color:AppColors.lightBlack),
                    CommonTextColors(text: mobileNo, fontSize: 11,
                        fontFamily: 'Poppins', fontWeight: FontWeight.w500,color:AppColors.darkOrange),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width*0.3,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonTextColors(
                      text: "Email",
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w300,
                      color: AppColors.lightBlack,),
                    CommonTextColors(text: email,
                        fontSize: 11,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        color: AppColors.darkOrange),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width*0.5,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonTextColors(text: "Gender", fontSize: 16,
                        fontFamily: 'Poppins', fontWeight: FontWeight.w300,color:AppColors.lightBlack),
                    CommonTextColors(text: gender, fontSize: 11,
                        fontFamily: 'Poppins', fontWeight: FontWeight.w500,color:AppColors.darkOrange),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width*0.3,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonTextColors(text: "Date of birth", fontSize: 16, fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,color:AppColors.lightBlack),
                    CommonTextColors(text:dob, fontSize: 11, fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,color:AppColors.darkOrange),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width*0.5,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonTextColors(text: "Preferred Language", fontSize: 16,
                        fontFamily: 'Poppins', fontWeight: FontWeight.w300,color:AppColors.lightBlack),
                    Text(language,
                      style: TextStyle(fontSize: 11,fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,color:AppColors.darkOrange),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width*0.3,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonTextColors(text: "Age", fontSize: 16, fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,color:AppColors.lightBlack),
                    CommonTextColors(text: age, fontSize: 11, fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,color:AppColors.darkOrange),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width*0.5,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonTextColors(text: "pincode", fontSize: 16,
                        fontFamily: 'Poppins', fontWeight: FontWeight.w300,color:AppColors.lightBlack),
                    CommonTextColors(text: pincode, fontSize: 11,
                        fontFamily: 'Poppins', fontWeight: FontWeight.w500,color:AppColors.darkOrange),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width*0.3,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonTextColors(text: "Country", fontSize: 16, fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,color:AppColors.lightBlack),
                    CommonTextColors(text: country, fontSize: 11, fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,color:AppColors.darkOrange),
                  ],
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width*0.5,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonTextColors(text: "state", fontSize: 16, fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,color:AppColors.lightBlack),
                    CommonTextColors(text: state, fontSize: 11, fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,color:AppColors.darkOrange),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),

        ],
      ),
    );
  }

  Widget _buildQualification() {
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Center(
              child: CommonText(
                text: 'Qualification',
                fontSize: 21,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonTextColors(
                            text: "College/University",
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                            color: AppColors.lightBlack),
                        CommonTextColors(
                            text: college,
                            fontSize: 11,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            color: AppColors.darkOrange),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonTextColors(
                            text: "Degree",
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                            color: AppColors.lightBlack),
                        CommonTextColors(
                            text: degree,
                            fontSize: 11,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            color: AppColors.darkOrange),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonTextColors(
                            text: "Specialization",
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                            color: AppColors.lightBlack),
                        CommonTextColors(
                            text: specialization,
                            fontSize: 11,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            color: AppColors.darkOrange),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10), // Adding spacing to avoid overflow
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonTextColors(
                            text: "Higher Education",
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                            color: AppColors.lightBlack),
                        CommonTextColors(
                            text: education,
                            fontSize: 11,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            color: AppColors.darkOrange),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonTextColors(
                            text: "Experience",
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                            color: AppColors.lightBlack),
                        CommonTextColors(
                            text: experience,
                            fontSize: 11,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            color: AppColors.darkOrange),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonTextColors(
                  text: "Certifications",
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w300,
                  color: AppColors.lightBlack),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    width: 149,
                    decoration: BoxDecoration(
                      color: AppColors.lightWhite,
                      borderRadius: BorderRadius.circular(15)
                    ),

                  ),
                  SizedBox(width: 10), // Add spacing between containers
                  Container(
                    height: 100,
                    width: 149,
                    decoration: BoxDecoration(
                        color: AppColors.lightWhite,
                        borderRadius: BorderRadius.circular(15)
                    ),

                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildDocuments() {
    return Container(
      padding: EdgeInsets.all(3),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Center(
              child: CommonText(
                text: 'Documents',
                fontSize: 21,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 10,),
          Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonTextColors(text: "Aadhaar Card", fontSize: 16,
                fontFamily: 'Poppins', fontWeight: FontWeight.w300,color:AppColors.lightBlack),
              CommonTextColors(text: aadhaarNumber, fontSize: 11,
                fontFamily: 'Poppins', fontWeight: FontWeight.w500,color:AppColors.darkOrange),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonTextColors(text: "Aadhaar card front",
                    fontSize: 16,fontFamily: 'Poppins', fontWeight: FontWeight.w300,color:AppColors.lightBlack),
                  Container(
                    height: 100,
                    width: 149,
                    decoration: BoxDecoration(
                        color: AppColors.lightWhite,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: CachedNetworkImage(
                        imageUrl: aadhaarFront,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 10,),
              Column(crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CommonTextColors(text: "Aadhaar card back",
                      fontSize: 16,fontFamily: 'Poppins', fontWeight: FontWeight.w300,color:AppColors.lightBlack),
                  Container(
                    height: 100,
                    width: 149,
                    decoration: BoxDecoration(
                        color: AppColors.lightWhite,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: CachedNetworkImage(
                      imageUrl: aadhaarBack,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonTextColors(text: "PanCard No",
                fontSize: 16,fontFamily: 'Poppins', fontWeight: FontWeight.w300,color:AppColors.lightBlack),
              // Container(
              //   height: 100,
              //   width: 149,
              //   decoration: BoxDecoration(
              //       color: AppColors.lightWhite,
              //       borderRadius: BorderRadius.circular(15)
              //   ),
              //
              // ),
              CommonTextColors(text: pancardNo, fontSize: 11,
                  fontFamily: 'Poppins', fontWeight: FontWeight.w500,color:AppColors.darkOrange),
            ],
          ),
        ],
      ),
    );
  }

  void currentTherapistDetails() {
    setState(() {
      isLoading = true;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        GetCurrentCounsellorDetailsResponseMODEL model =
        await CallService().getCurrentTherapistDetails();
        setState(() {
          isLoading = false;
          fullName = model.data!.fullName.toString();
          profilePicture=model.data!.profilePicture.toString();
          specialization=model.data!.specialization.toString();
          experience=model.data!.yearsOfExperience.toString();
          language=model.data!.languages.toString();
          bio=model.data!.bio.toString();
          email=model.data!.email.toString();
          mobileNo=model.data!.phoneNumber.toString();
          DateTime parsedDate = DateTime.parse(model.data!.dateOfBirth.toString());
          dob = "${parsedDate.day.toString().padLeft(2, '0')}-${parsedDate.month.toString().padLeft(2, '0')}-${parsedDate.year}";
          gender=model.data!.gender.toString();
          age=model.data!.age.toString();
          country=model.data!.country.toString();
          pincode=model.data!.pincode.toString();
          state=model.data!.state.toString();
          college=model.data!.collegeName.toString();
          education=model.data!.higherEducation.toString();
          degree=model.data!.degree.toString();
          //certificate=model.data!.specialization.toString();
          aadhaarNumber=model.data!.aadharNumber.toString();
          aadhaarBack=model.data!.aadharBack.toString();
          aadhaarFront=model.data!.aadharFront.toString();
          pancardNo=model.data!.pancard.toString();
        });
      });
    });
  }

}
