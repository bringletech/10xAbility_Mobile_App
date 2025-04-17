import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../auth/api_services/api_service.dart';
import '../../auth/model/get_monthly_appointment_response_model.dart';
import '../../common/colors/colors.dart';
import '../../common/commonButton/common_button.dart';
import '../../common/commonButton/common_button_get_otp.dart';
import '../../common/commonText/common_text.dart';
import '../../common/commonText/common_text_colors.dart';
import '../councellor_chat/councellor_chat_online.dart';
import '../councellor_my_history/counsellor_my_history.dart';
import 'create_slots_forAppointment.dart';

class BookingsCounsellor extends StatefulWidget {
  const BookingsCounsellor({super.key});

  @override
  State<BookingsCounsellor> createState() => _BookingsCounsellorState();
}

class _BookingsCounsellorState extends State<BookingsCounsellor> {
  bool showAll = false;
  bool showAll1 = false;
  bool isLoading = false;
  String month='',year='',appointmentCount="";
  final List<Map<String, String>> historyData = List.generate(
    8,
    (index) => {
      'name': 'individual',
      'age': '25',
      'name1': 'Arjun Sharma',
      'email': 'arjunsharma123@gmail.com',
      'mobile': '+9109876543214',
      'time': '10:30 AM-11:30 AM',
    },
  );
  final List<Map<String, String>> historyData1 = List.generate(
    8,
    (index) => {
      'name': 'individual',
      'age': '25',
      'name1': 'Arjun Sharma',
      'email': 'arjunsharma123@gmail.com',
      'mobile': '+9109876543214',
      'time': '10:30 AM-11:30 AM',
    },
  );


  DateTime _selectedDate = DateTime.now();
  Map<String, int> _appointments = {
    // '2025-04-15': 5,
    // '2025-04-17': 5,
  };
  final List<String> _weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat','Sun'];

  void _nextMonth() {
    setState(() {
      _selectedDate = DateTime(_selectedDate.year, _selectedDate.month + 1);
      getMonthlyAppointment(); // Fetch data for the new month
    });
  }

  void _previousMonth() {
    setState(() {
      _selectedDate = DateTime(_selectedDate.year, _selectedDate.month - 1);
      getMonthlyAppointment(); // Fetch data for the new month
    });
  }

  MonthlyAppointmentData monthlyAppointmentData = MonthlyAppointmentData(monthAndYear: {});

  List<Widget> _buildCalendarDays() {
    final firstDayOfMonth = DateTime(_selectedDate.year, _selectedDate.month, 1);
    final daysInMonth = DateTime(_selectedDate.year, _selectedDate.month + 1, 0).day;
    final startWeekday = firstDayOfMonth.weekday - 1; // Monday = 0

    List<Widget> dayWidgets = [];

    for (int i = 0; i < startWeekday + daysInMonth; i++) {
      if (i < startWeekday) {
        dayWidgets.add(Container());
      } else {
        final day = i - startWeekday + 1;
        final date = DateTime(_selectedDate.year, _selectedDate.month, day);
        final key = DateFormat('yyyy-MM-dd').format(date);
        final hasAppointments = _appointments.containsKey(key);
        final appointmentCount = _appointments[key];

        dayWidgets.add(
          GestureDetector(
            onTap: () {
              if (hasAppointments) {
                // Get the appointments for this date from the model
                final formattedDate = DateFormat('yyyy-MM-dd').format(date);
                if (_appointments.containsKey(formattedDate)) {
                  // Find the appointment details in the data
                  List<Appointment> dateAppointments = [];

                  try {
                    // This assumes you have access to the full model data
                    for (var monthAndYearEntry in monthlyAppointmentData.monthAndYear.entries) {
                      if (monthAndYearEntry.key == formattedDate) {
                        dateAppointments = monthAndYearEntry.value.appointments;
                        break;
                      }
                    }

                    // Show popup with appointments
                    showAppointmentsPopup(context, formattedDate, dateAppointments);
                  } catch (e) {
                    print("Error fetching appointments: $e");
                  }
                }
              }
            },
            child: Container(
              margin: EdgeInsets.all(4),
              //padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: appointmentCount != null
                    ? Border.all(color: Colors.red)
                    : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    day.toString(),
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 4),
                  if (appointmentCount != null)
                    Text(
                      '$appointmentCount Slots',
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400,
                        color: Colors.red[500],
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      }
    }

    return dayWidgets;
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMonthlyAppointment();
  }

  @override
  Widget build(BuildContext context) {
    final month = DateFormat.MMMM().format(_selectedDate);
    final year = _selectedDate.year;

    return isLoading
        ? Center(
      child: CircularProgressIndicator(color: AppColors.darkOrange),)
        :Scaffold(
      body: Padding(
        padding:EdgeInsets.symmetric(horizontal: 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 40, left: 15),
                    child: CommonText(
                      text: 'Bookings',
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    width: 170,
                    margin: EdgeInsets.only(top: 40, left: 15),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF6B5F), Color(0xFFFF9472)],
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        //  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                      ),
                      onPressed: () {
                       Navigator.push(context,
                           MaterialPageRoute(builder: (context)=>CreateSlotsForAppointment()));
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.add,
                              size: 16,
                              color: Colors.orange,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Create Slot',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20,),
              Container(
                child: Dash(
                  length: MediaQuery.of(context).size.width * 0.90,
                  dashColor: AppColors.redOrange,
                  dashLength: 10,
                  dashThickness: 1,
                  dashGap: 9,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Card background color
                  borderRadius: BorderRadius.circular(20), // Rounded corners
                  border: Border.all(
                    color: AppColors.redOrange, // Border color
                    width: 1, // Border width
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2), // Light shadow
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(left: 8,right: 8),
                height: MediaQuery.of(context).size.height*0.52,
                child: Column(
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Time Slots',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            DropdownButton<String>(
                              value: month,
                               items: List.generate(12, (index) {
                                return DropdownMenuItem(
                                  value: DateFormat.MMMM().format(DateTime(0, index + 1)),
                                  child: Text(DateFormat.MMMM().format(DateTime(0, index + 1))),
                                );
                              }),
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    final index = DateFormat.MMMM().parse(value).month;
                                    _selectedDate = DateTime(_selectedDate.year, index);
                                  });
                                }
                              },
                            ),
                            SizedBox(width: 8),
                            DropdownButton<int>(
                              value: year,
                              items: List.generate(5, (index) {
                                final yr = 2025 + index;
                                return DropdownMenuItem(
                                  child: Text(yr.toString()),
                                  value: yr,
                                );
                              }),
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    _selectedDate = DateTime(value, _selectedDate.month);
                                  });
                                }
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    // Weekdays
                    Padding(
                      padding:EdgeInsets.only(left: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: _weekdays.map((d) {
                          return Expanded(
                            child: Container(
                              height: 20,
                             margin: EdgeInsets.all(2),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.special,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                d,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  fontFamily: "Inter",
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 8,),
                    Expanded(
                      child: GridView.count(
                        padding: EdgeInsets.zero,
                        crossAxisCount: 7,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 5,
                        childAspectRatio: 0.93,
                        children: _buildCalendarDays(),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 15),
                child: CommonTextColors(
                  text: 'Upcoming Session',
                  fontSize: 30,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  color: AppColors.redOrange,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(8),
                //height: MediaQuery.of(context).size.height * 0.58, // Set a fixed height for 2 items
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount:
                      showAll ? historyData.length : 4, // Show only 2 initially
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.9,
                  ),
                  itemBuilder: (context, index) {
                    final item = historyData[index];
                    return HistoryCard(item: item);
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    showAll = !showAll;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonText(
                      text:
                          showAll ? 'Less' : 'More', // Change text dynamically
                      fontSize: 17,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                    SvgPicture.asset("assets/svgIcon/moreIcon.svg"),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 15),
                child: CommonTextColors(
                  text: 'Session Completed',
                  fontSize: 30,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  color: AppColors.redOrange,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(8),
                //height: MediaQuery.of(context).size.height * 0.58, // Set a fixed height for 2 items
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: showAll1
                      ? historyData1.length
                      : 4, // Show only 2 initially
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.9,
                  ),
                  itemBuilder: (context, index) {
                    final item1 = historyData1[index];
                    return HistoryCard(item: item1);
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    showAll1 = !showAll1;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonText(
                      text:
                          showAll1 ? 'Less' : 'More', // Change text dynamically
                      fontSize: 17,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                    SvgPicture.asset("assets/svgIcon/moreIcon.svg"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getMonthlyAppointment() {
    month = _selectedDate.month.toString();
    year =_selectedDate.year.toString();
    setState(() {
      isLoading = true;

      WidgetsBinding.instance.addPostFrameCallback((_) async {

        GetMonthlyAppointmentResponseModel model =
        await CallService().getMonthlyAppointment(month,year);

        Map<String, int> updatedAppointments = {};

        model.data.monthAndYear.forEach((date, appointmentDate) {
          updatedAppointments[date] = appointmentDate.appointmentCount;
        });

        setState(() {
          isLoading = false;
          _appointments = updatedAppointments;
          monthlyAppointmentData = model.data;
          print(" Appointment Value is: $_appointments");
        });
      });
    });
  }

  void showAppointmentsPopup(BuildContext context, String selectedDate, List<Appointment> appointments) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Appointments for $selectedDate",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(Icons.close, size: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Appointments list
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: appointments.length,
                    itemBuilder: (context, index) {
                      final appointment = appointments[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300),
                          color: Colors.grey.shade100,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${appointment.startTime} - ${appointment.endTime}",
                                  style: const TextStyle(fontSize: 12),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.yellow.shade100,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    appointment.status,
                                    style: const TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            // You can add more appointment details here if needed
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}


