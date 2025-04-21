import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ten_x_app/common/colors/colors.dart';
import 'package:ten_x_app/common/commonText/common_text.dart';
import 'package:ten_x_app/common/commonText/common_text_colors.dart';

class PatientBookAppointment extends StatefulWidget {
  final String Id;
  final String profilePicture;
  final String fullName;
  final String degree;
  final String experience;
  final String languages;
  final String specialization;
  const PatientBookAppointment(this.Id,this.profilePicture,this.fullName,this.degree,this.experience,this.languages,this.specialization,{super.key});

  @override
  State<PatientBookAppointment> createState() => _PatientBookAppointmentState();
}

class _PatientBookAppointmentState extends State<PatientBookAppointment> {
  bool isBookingForSomeoneElse = false;
  String? selectedValue; // Holds the selected item
  List<String> items = ['Male', 'Female'];
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  bool isLoading= false;

  // void _showSnackbar() {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text("Please select 'Booking For Someone Else' to fill the form."),
  //       backgroundColor: Colors.red,
  //       duration: Duration(seconds: 2),
  //     ),
  //   );
  // }


  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
      child: CircularProgressIndicator(color: AppColors.darkOrange),)
        :Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
      Padding(
          padding: const EdgeInsets.all(10.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start,
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
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      clipBehavior: Clip.antiAlias, // Ensures the image stays inside the border
                      child: CachedNetworkImage(
                          imageUrl: widget.profilePicture,
                      errorWidget:(context, url, error) =>
                          Image.network(
                            'https://dummyimage.com/500x500/aaa/000000.png&text=No+Image',
                          ))
                    ),
                    SizedBox(width: 9,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          text: widget.fullName,
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                        ),
                        SizedBox(height: 5,),
                        CommonText(
                          text: widget.degree,
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Poppins',
                        ),
                        // SizedBox(height: 3,),
                        // Row(
                        //   children: [
                        //     CommonText(
                        //       text: "4.2",
                        //       fontSize: 11,
                        //       fontWeight: FontWeight.w300,
                        //       fontFamily: 'Poppins',
                        //     ), SizedBox(width: 2,),
                        //     Row(
                        //       children: List.generate(5, (index) {
                        //         if (index < 4) {
                        //           return Icon(Icons.star, color:AppColors.redOrange, size: 14);
                        //         } else {
                        //           return Icon(Icons.star_half, color:AppColors.redOrange, size: 14);
                        //         }
                        //       }),
                        //     ), SizedBox(width: 2,),
                        //     CommonText(
                        //       text: "(100+ Reviews)",
                        //       fontSize: 11,
                        //       fontWeight: FontWeight.w300,
                        //       fontFamily: 'Poppins',
                        //     ),
                        //   ],
                        // ),
                        SizedBox(height: 3,),
                        Row(
                          children: [
                            CommonText(text:  "Experience:",
                              fontSize: 12, fontFamily: 'Poppins', fontWeight: FontWeight.w500,),
                            SizedBox(width: 2.5,),
                            CommonText(text: widget.experience,
                              fontSize: 11, fontFamily: 'Poppins', fontWeight: FontWeight.w300,)
                          ],
                        ),
                        SizedBox(height: 3,),
                        Row(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(text: "Languages:",
                              fontSize: 12, fontFamily: 'Poppins', fontWeight: FontWeight.w500,),
                            SizedBox(width: 2.5,),
                            Container(
                              width: MediaQuery.of(context).size.width*0.4,
                              child: CommonText(text:widget.languages,
                                fontSize: 11, fontFamily: 'Poppins', fontWeight: FontWeight.w300,),
                            )
                          ],
                        ),
                        SizedBox(height: 3,),
                        Row(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(text: "Specialization:",
                              fontSize: 12, fontFamily: 'Poppins', fontWeight: FontWeight.w500,),
                            SizedBox(width: 2.5,),
                            Container(
                              width:  MediaQuery.of(context).size.width*0.35,
                              child: CommonText(text: widget.specialization,
                                fontSize: 11, fontFamily: 'Poppins', fontWeight: FontWeight.w300,),
                            )
                          ],
                        ),
                        SizedBox(height: 10,),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 30,),
                CommonText(
                  text: "Select Appointment Date",
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonTextColors(text: 'January 2025', fontSize: 15,
                        fontFamily: 'Poppins', fontWeight: FontWeight.w400, color: AppColors.redOrange),
                    SvgPicture.asset('assets/svgIcon/editIcon.svg')
                  ],
                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(45),
                          border: Border.all(
                              color: AppColors.redOrange
                          )
                      ),
                      //color: Colors.amber,
                      height: 80,
                      width: 50,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CommonTextColors(
                              text: 'WED',
                              fontSize: 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              color: AppColors.darkGray1,
                            ),
                            CommonText(
                              text: '24',
                              fontSize: 24,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w300,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(45),
                          border: Border.all(
                              color: AppColors.redOrange
                          )
                      ),
                      //color: Colors.amber,
                      height: 80,
                      width: 50,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            CommonText(
                              text: 'THU',
                              fontSize: 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,

                            ),
                            CommonText(
                              text: '25',
                              fontSize: 24,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w300,

                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(45),
                          border: Border.all(
                              color: AppColors.redOrange
                          )
                      ),
                      //color: Colors.amber,
                      height: 80,
                      width: 50,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            CommonText(
                              text: 'FRI',
                              fontSize: 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                            CommonText(
                              text: '26',
                              fontSize: 24,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w300,

                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(45),
                          border: Border.all(
                              color: AppColors.redOrange
                          )
                      ),
                      //color: Colors.amber,
                      height: 80,
                      width: 50,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            CommonText(
                              text: 'SAT',
                              fontSize: 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                            CommonText(
                              text: '27',
                              fontSize: 24,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w300,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(45),
                          border: Border.all(
                              color: AppColors.redOrange
                          )
                      ),
                      //color: Colors.amber,
                      height: 80,
                      width: 50,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            CommonText(
                              text: 'SUN',
                              fontSize: 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,

                            ),
                            CommonText(
                              text: '28',
                              fontSize: 24,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w300,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(45),
                          border: Border.all(
                              color: AppColors.redOrange
                          )
                      ),
                      //color: Colors.amber,
                      height: 80,
                      width: 50,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            CommonText(
                              text: 'MON',
                              fontSize: 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                            CommonText(
                              text: '29',
                              fontSize: 24,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w300,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15,),
                CommonText(
                  text: "Available Time Slots",
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(45),
                          border: Border.all(
                              color: AppColors.redOrange
                          )
                      ),
                      //color: Colors.amber,
                      height: 65,
                      width: 110,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CommonText(
                              text: '9:00',
                              fontSize: 24,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                            SizedBox(width: 5,),
                            CommonText(
                              text: 'AM',
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w300,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(45),
                          border: Border.all(
                              color: AppColors.redOrange
                          )
                      ),
                      //color: Colors.amber,
                      height: 65,
                      width: 110,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CommonTextColors(
                            text: '12:00',
                            fontSize: 24,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            color: AppColors.darkGray1,
                          ), SizedBox(width: 5,),
                          CommonText(
                            text: 'PM',
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(45),
                          border: Border.all(
                              color: AppColors.redOrange
                          )
                      ),
                      //color: Colors.amber,
                      height: 65,
                      width: 110,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CommonTextColors(
                            text: '3:15',
                            fontSize: 24,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            color: AppColors.darkGray1,
                          ), SizedBox(width: 5,),
                          CommonText(
                            text: 'PM',
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15,),
                CommonText(
                  text: "Session Mode",
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(45),
                          border: Border.all(
                              color: AppColors.redOrange
                          )
                      ),
                      //color: Colors.amber,
                      height: 50,
                      width: 170,
                      child: Center(
                        child: CommonText(
                              text: 'In-Person',
                              fontSize: 17,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(45),
                          border: Border.all(
                              color: AppColors.redOrange
                          )
                      ),
                      //color: Colors.amber,
                      height: 50,
                      width: 170,
                      child:  Center(
                        child: CommonText(
                          text: 'Online',
                          fontSize: 17,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                Row(
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.redOrange, width: 2), // Orange border
                        borderRadius: BorderRadius.circular(4), // Rounded corners
                      ),
                      child: Transform.scale(
                        scale: 1.5, // Adjust checkbox size
                        child: Checkbox(
                          value: isBookingForSomeoneElse,
                          activeColor: AppColors.redOrange, // Change checkbox color
                          checkColor: Colors.white, // Tick color
                          side: BorderSide.none, // Remove default border
                          onChanged: (bool? value) {
                            setState(() {
                              isBookingForSomeoneElse = value ?? false;
                              print("Selected value is $isBookingForSomeoneElse");
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    CommonText(
                      text: "Booking For Someone Else",
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Container(
              margin: EdgeInsets.only(left: 5),
              child: CommonTextColors(
                text: "Fill in Their Information",
                fontSize: 17,
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins',
                color: isBookingForSomeoneElse?AppColors.black:AppColors.lightGrey,
              ),
            ),
                SizedBox(height: 20,),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: CommonTextColors(
                          text: "First Name",
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                          color: isBookingForSomeoneElse?AppColors.black:AppColors.lightGrey,
                        ),
                      ),
                      SizedBox(height: 5,),
                      Container(
                        height: 50,
                        width: 380,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color:isBookingForSomeoneElse?AppColors.redOrange:AppColors.lightGrey,)),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.text,
                          readOnly: isBookingForSomeoneElse?false:true,
                          controller: firstNameController,
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintText: 'Enter your first name',
                            hintStyle: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 13,
                              color: AppColors.lightGrey,
                              fontWeight: FontWeight.w300,
                            ),
                            contentPadding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: CommonTextColors(
                          text: "Last Name",
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                          color: isBookingForSomeoneElse?AppColors.black:AppColors.lightGrey,
                        ),
                      ),
                      SizedBox(height: 5,),
                      Container(
                        height: 50,
                        width: 380,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color:
                            isBookingForSomeoneElse?AppColors.redOrange:AppColors.lightGrey,)),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.text,
                          readOnly: isBookingForSomeoneElse?false:true,
                          controller: lastNameController,
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintText: 'Enter your Last name',
                            hintStyle: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 13,
                              color: AppColors.lightGrey,
                              fontWeight: FontWeight.w300,
                            ),
                            contentPadding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: CommonTextColors(
                          text: "Email",
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                          color: isBookingForSomeoneElse?AppColors.black:AppColors.lightGrey,
                        ),
                      ),
                      SizedBox(height: 5,),
                      Container(
                        height: 50,
                        width: 380,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color:
                            isBookingForSomeoneElse?AppColors.redOrange:AppColors.lightGrey,)),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.text,
                          readOnly: isBookingForSomeoneElse?false:true,
                          controller: emailController,
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintText: 'Example@gmail.com',
                            hintStyle: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 13,
                              color: AppColors.lightGrey,
                              fontWeight: FontWeight.w300,
                            ),
                            contentPadding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: CommonTextColors(
                          text: "Mobile Number",
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                          color: isBookingForSomeoneElse?AppColors.black:AppColors.lightGrey,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 50,
                        width: 380,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color:
                            isBookingForSomeoneElse?AppColors.redOrange:AppColors.lightGrey,)),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.number,
                          controller: mobileController,
                          readOnly: isBookingForSomeoneElse?false:true,
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintText: '+91  9876543210',
                            hintStyle: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 13,
                              color: AppColors.lightGrey,
                              fontWeight: FontWeight.w300,
                            ),
                            contentPadding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 15),
                                child: CommonTextColors(
                                  text: "Age",
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins',
                                  color: isBookingForSomeoneElse?AppColors.black:AppColors.lightGrey,
                                ),
                              ),
                              SizedBox(height: 5,),
                              Container(
                                height: 50,
                                width: 160,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color:
                                    isBookingForSomeoneElse?AppColors.redOrange:AppColors.lightGrey,)),
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: TextField(
                                  textAlignVertical: TextAlignVertical.center,
                                  keyboardType: TextInputType.number,
                                  controller: ageController,
                                  readOnly: isBookingForSomeoneElse?false:true,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    border: InputBorder.none,
                                    hintText: 'Age',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 13,
                                      color: AppColors.lightGrey,
                                      fontWeight: FontWeight.w300,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(vertical: 15),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 3),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            //mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: CommonTextColors(
                                  text: "Gender",
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins',
                                  color: isBookingForSomeoneElse?AppColors.black:AppColors.lightGrey,
                                ),
                              ),
                              SizedBox(height: 5,),
                              Container(
                                height: 50,
                                width: 160,
                                margin: EdgeInsets.only(left:6),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: isBookingForSomeoneElse?AppColors.redOrange:AppColors.lightGrey,
                                    )
                                ),
                                child:
                                //
                                isBookingForSomeoneElse
                                    ? DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    hint: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8),
                                      child: Text(
                                        "Select Gender",
                                        style: TextStyle(
                                          color: AppColors.lightGrey,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w300,
                                          fontFamily: "Inter",
                                        ),
                                      ),
                                    ),
                                    value: selectedValue,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedValue = newValue;
                                      });
                                    },
                                    items: items.map<DropdownMenuItem<String>>((String item) {
                                      return DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(item),
                                      );
                                    }).toList(),
                                  ),
                                )
                                    : SizedBox.shrink(),

                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
                GestureDetector(
                  child: Container(
                    height: 50,
                    width: 380,
                    decoration: BoxDecoration(
                      color: AppColors.redOrange,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight:Radius.circular(30),// Radius on top-left only
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Proceed to Payment',
                          style:TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: AppColors.white
                          ) ,),
                        SizedBox(width: 3,),
                        Icon(Icons.arrow_forward,color: AppColors.white,size: 25,)
                      ],
                    ),
                  )
                )
          ]))
    ]))));
  }
}
