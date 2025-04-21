import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math';

import 'package:intl/intl.dart';
import '../../auth/api_services/api_service.dart';
import '../../auth/model/create_appointment_response_model.dart';
import '../../auth/model/create_time_slot_response_model.dart';

import '../../auth/model/delete_appointment_time_slot_response_model.dart';
import '../../auth/model/get_appointment_time_slot_response_model.dart';
import '../../common/colors/colors.dart';
import '../../common/commonText/common_text.dart';


class TimeSlot {
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final DateTime date;
  bool isSelected;

  TimeSlot({
    required this.startTime,
    required this.endTime,
    required this.date,
    this.isSelected = false,
  });

  String get formattedTimeRange {
    // Format manually without using format() method
    String formatTimeOfDay(TimeOfDay time) {
      final int hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
      final String minute = time.minute < 10 ? '0${time.minute}' : '${time.minute}';
      final String period = time.period == DayPeriod.am ? 'AM' : 'PM';
      return '$hour:$minute $period';
    }

    return '${formatTimeOfDay(startTime)} - ${formatTimeOfDay(endTime)}';
  }
}

class CreateSlotsForAppointment extends StatefulWidget {
  const CreateSlotsForAppointment({super.key});

  @override
  State<CreateSlotsForAppointment> createState() => _CreateSlotsForAppointmentState();
}

class _CreateSlotsForAppointmentState extends State<CreateSlotsForAppointment> {
  DateTime selectedDate = DateTime.now();
  DateTime displayMonth = DateTime.now();
  String selectedType = 'start'; // Controls whether we're editing start or end time
  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();
  bool isSelectingHour = true;
  bool isLoading= false;
  bool isCreatingSlot = false;
  bool isCreatingAppointment = false;
  List<TimeSlot> timeSlots = [];
  List<AppointmentSlot> timeSlotData=[];
  String date='';
  List<DateTime> get weekDays {
    // Get the first day of the week (Monday) for the selected date's week
    final firstDayOfWeek = selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
    // Generate 7 days from Monday to Sunday
    return List.generate(7, (index) => firstDayOfWeek.add(Duration(days: index)));
  }

  void onTimeChanged(TimeOfDay time) {
    setState(() {
      if (selectedType == 'start') {
        selectedStartTime = time;
      } else {
        selectedEndTime = time;
      }
    });
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        displayMonth = picked; // Update displayed month when date is picked
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTimeSlotList();
    //createTimeSlot();
    //createAppointment();
  }


  @override
  Widget build(BuildContext context) {

    TimeOfDay selectedTime = selectedType == 'start' ? selectedStartTime : selectedEndTime;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 20,left: 15),
                child: CommonText(
                  text: 'Appointment',
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
              SizedBox(height: 16),
              Align(alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text("Set Appointment Date", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  )),
              SizedBox(height: 4),
              Padding(
                padding: EdgeInsets.only(left: 15.0,right: 20),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        DateFormat('yyyy-MM-dd').format(displayMonth),
                        style: TextStyle(color: Colors.redAccent)
                    ),
                    GestureDetector(onTap: (){
                      _selectDate(context);
                    },
                        child: SvgPicture.asset('assets/svgIcon/editIcon.svg',height: 30,width: 30,)),
                  ],
                ),
              ),
              SizedBox(height: 12),
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: weekDays.length,
                  itemBuilder: (context, index) {
                    DateTime date = weekDays[index];
                    bool isSelected = DateFormat('yyyy-MM-dd').format(date) == DateFormat('yyyy-MM-dd').format(selectedDate);
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDate = date;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 6),
                        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected ?AppColors.redOrange : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(DateFormat('E').format(date).toUpperCase(), style: TextStyle(fontSize: 12, color: isSelected ? Colors.white : Colors.black54)),
                            SizedBox(height: 4),
                            Text(date.day.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isSelected ? Colors.white : Colors.black)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
        
              // Start/End Time Toggle - FIXED
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ToggleButtons(
                    isSelected: [selectedType == 'start', selectedType == 'end'],
                    onPressed: (index) {
                      setState(() {
                        selectedType = index == 0 ? 'start' : 'end';
                      });
                    },
                    selectedColor: Colors.white,
                    fillColor: AppColors.redOrange,
                    borderRadius: BorderRadius.circular(8),
                    children: [
                      Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text("Start-Time")),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text("End-Time")),
                    ],
                  ),
                ],
              ),
        
              SizedBox(height: 20),
        
              // Hour/Minute Toggle - Kept separate from Start/End toggle
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ToggleButtons(
                    isSelected: [isSelectingHour, !isSelectingHour],
                    onPressed: (index) {
                      setState(() {
                        isSelectingHour = index == 0;
                      });
                    },
                    selectedColor: Colors.white,
                    fillColor: AppColors.redOrange,
                    borderRadius: BorderRadius.circular(8),
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text("Hour"),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text("Minute"),
                      ),
                    ],
                  ),
                  SizedBox(width: 16),
                  ToggleButtons(
                    isSelected: [
                      selectedTime.period == DayPeriod.am,
                      selectedTime.period == DayPeriod.pm,
                    ],
                    onPressed: (index) {
                      setState(() {
                        TimeOfDay current = selectedTime;
                        int hour = current.hour;
                        if (index == 0 && hour >= 12) hour -= 12;
                        if (index == 1 && hour < 12) hour += 12;
        
                        TimeOfDay updated = TimeOfDay(hour: hour, minute: current.minute);
                        if (selectedType == 'start') {
                          selectedStartTime = updated;
                        } else {
                          selectedEndTime = updated;
                        }
                      });
                    },
                    selectedColor: Colors.white,
                    fillColor: AppColors.redOrange,
                    borderRadius: BorderRadius.circular(8),
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text("AM"),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text("PM"),
                      ),
                    ],
                  ),
                ],
              ),
        
              SizedBox(height: 20),
        
              // Clock widget - now properly showing the selected time (start or end)
              ClockWidget(
                initialTime: selectedTime,
                onTimeChanged: onTimeChanged,
                isSelectingHour: isSelectingHour,
              ),
        
              SizedBox(height: 12),
        
              // Show which time is being edited
              Text(
                selectedType == 'start' ? "Setting Start Time" : "Setting End Time",
                style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
              ),
        
              // Selected time display
              Text(
                selectedTime.format(context),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
        
              SizedBox(height: 20),
              // Display both selected times in boxes
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: selectedType == 'start' ? AppColors.redOrange : Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                        color: selectedType == 'start' ? AppColors.redOrange : Colors.white,
                      ),
                      child: Text(selectedStartTime.format(context,),

                      ),
                    ),
                    Icon(Icons.remove),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: selectedType == 'end' ? Colors.redAccent : Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                        color: selectedType == 'end' ? Colors.red.shade50 : Colors.white,
                      ),
                      child: Text(selectedEndTime.format(context)),
                    ),
                    SizedBox(width: 8,),
                    GestureDetector(
                      onTap: () {
                        if (!isLoading) {
                          setState(() {
                            isLoading = true;
                          });

                          createTimeSlot().then((_) {
                            setState(() {
                              isLoading = false;
                            });
                          });
                        }
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: AppColors.redOrange,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: isLoading
                            ? Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                            : Icon(Icons.add, color: Colors.white),
                      ),
                    )

                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.only(left: 15),
                alignment: Alignment.centerLeft,
                child: CommonText(
                    text: "Time Slots",
                    fontSize: 17,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(children: [
                  if (timeSlotData.isEmpty)
                    Text(
                      "No slots added yet",
                      style: TextStyle(color: Colors.grey),
                    ),

                  ...timeSlotData.map((slot) {
                    return Column(
                      children: [
                        if (timeSlotData.indexOf(slot) > 0) SizedBox(height: 8),
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.access_time, size: 20),
                              SizedBox(width: 8),
                              Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        slot.startTime,
                                        style: TextStyle(fontSize: 16),),
                                      Icon(Icons.remove ,),
                                      Text(slot.endTime,
                                          style: TextStyle(fontSize: 16)),
                                      SizedBox(width: 20,),
                                      GestureDetector(onTap: (){
                                        String slotId=slot.id.toString();
                                        deleteTimeSlot(slotId);
                                      },
                                          child: Icon(Icons.delete)),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                  SizedBox(
                    height: 10,
                  ),
                  if (timeSlots.isEmpty)
                    Text(
                      "No slots added yet",
                      style: TextStyle(color: Colors.grey),
                    ),

                  ...timeSlots.map((slot) {
                    return Column(
                      children: [
                        if (timeSlots.indexOf(slot) > 0) SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: CheckboxListTile(
                            value: slot.isSelected,
                            onChanged: (value) {
                              setState(() {
                                slot.isSelected = value ?? false;
                              });
                            },
                            title: Row(
                              children: [
                                Icon(Icons.access_time, size: 20),
                                SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(slot.formattedTimeRange),
                                        SizedBox(width: 20,),
                                        GestureDetector(onTap: (){
                                          setState(() {
                                            timeSlots.remove(slot);
                                          });
                                        }, child: Icon(Icons.delete)),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                        ),
                      ],
                    );
                  }).toList(),

                  SizedBox(height: 80), // Space for more time slots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            side: BorderSide(color: Colors.grey.shade400),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: Text("Cancel"),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed:
                              isCreatingAppointment ? null : createAppointment,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent.shade100,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: isCreatingAppointment
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2, color: Colors.white),
                                )
                              : Text(
                                  "Create Appointment",
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ]))));
  }

  Future<void> createTimeSlot() async {
    setState(() {
      isLoading = true;
    });

    final DateTime startDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedStartTime.hour,
      selectedStartTime.minute,
    );

    final DateTime endDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedEndTime.hour,
      selectedEndTime.minute,
    );

    var map = <String, dynamic>{
      "startTime": startDateTime.toUtc().toIso8601String(),
      "endTime": endDateTime.toUtc().toIso8601String(),
    };

    print("Map value is: $map");

    try {
      CreateTimeSlotForAppointmentResponseModel model =
      await CallService().createAppointmentTimeSlot(map);

      setState(() {
        timeSlots.insert(0, TimeSlot(
          startTime: selectedStartTime,
          endTime: selectedEndTime,
          date: selectedDate,
        ));
        isLoading = false;
      });

      Fluttertoast.showToast(
        msg: model.message.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      Fluttertoast.showToast(
        msg: "Something went wrong!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  Future<void> createAppointment() async {
    setState(() {
      isLoading = true;
    });

    List<Map<String, String>> formattedSlots = timeSlots.map((slot) {
      String formatTimeOfDay(TimeOfDay time) {
        final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
        final minute = time.minute.toString().padLeft(2, '0');
        final period = time.period == DayPeriod.am ? 'AM' : 'PM';
        return '$hour:$minute $period';
      }

      return {
        "startTime": formatTimeOfDay(slot.startTime),
        "endTime": formatTimeOfDay(slot.endTime),
        "appointmentDate": "${slot.date.month}/${slot.date.day}/${slot.date.year}",
      };
    }).toList();

    var map = <String, dynamic>{
      "processedData": formattedSlots,
    };

    print("Map value is: $map");

    try {
      CreateAppointmentResponseModel model =
      await CallService().createAppointment(map);

      Fluttertoast.showToast(
        msg: model.message.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  getTimeSlotList() {
   date = selectedDate.toString();
   print("Date value is $date");
    setState(() {
      isLoading = true;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        AppointmentTimeSlotsResponse model =
        await CallService().getTimeSlot(date);
        setState(() {
          isLoading = false;
          timeSlotData=model.data;
          print("Time Slot list Value is: $timeSlotData");
        });
      });
    });
  }

  void deleteTimeSlot(String slotId) {
    setState(() {
      isLoading = true;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        DeleteAppointmentTimeSlotResponseModel model =
        await CallService().deleteAppointmentTimeSlot(slotId,);
        setState(() {
          isLoading = false;
          String message = model.message.toString();
          print('request accepted $message');
          getTimeSlotList();
        });
      });
    });
  }

}

class ClockWidget extends StatefulWidget {
  final TimeOfDay initialTime;
  final Function(TimeOfDay) onTimeChanged;
  final bool isSelectingHour;

  const ClockWidget({
    required this.initialTime,
    required this.onTimeChanged,
    required this.isSelectingHour,
    super.key,
  });

  @override
  State<ClockWidget> createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {
  late TimeOfDay currentTime;
  final double clockSize = 250;

  @override
  void initState() {
    super.initState();
    currentTime = widget.initialTime;
  }

  void _updateTimeFromOffset(Offset localPosition) {
    final center = Offset(clockSize / 2, clockSize / 2);
    final dx = localPosition.dx - center.dx;
    final dy = localPosition.dy - center.dy;
    final angle = atan2(dy, dx);
    final angleInDegrees = (angle * 180 / pi + 360) % 360;

    setState(() {
      if (widget.isSelectingHour) {
        int hour = ((angleInDegrees / 30).round()) % 12;
        hour = hour == 0 ? 12 : hour;
        if (currentTime.period == DayPeriod.pm && hour != 12) {
          hour += 12;
        } else if (currentTime.period == DayPeriod.am && hour == 12) {
          hour = 0;
        }
        currentTime = TimeOfDay(hour: hour, minute: currentTime.minute);
      } else {
        int minute = ((angleInDegrees / 6).round()) % 60;
        currentTime = TimeOfDay(hour: currentTime.hour, minute: minute);
      }
    });

    widget.onTimeChanged(currentTime);
  }

  @override
  void didUpdateWidget(covariant ClockWidget oldWidget) {
    if (widget.initialTime != oldWidget.initialTime) {
      currentTime = widget.initialTime;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onPanStart: (details) => _updateTimeFromOffset(details.localPosition),
      onPanUpdate: (details) => _updateTimeFromOffset(details.localPosition),
      onTapDown: (details) => _updateTimeFromOffset(details.localPosition),
      child: Container(
        width: clockSize,
        height: clockSize,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Clock background
            Container(
              width: clockSize,
              height: clockSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                gradient: RadialGradient(
                  colors: [Colors.transparent, Colors.black.withOpacity(0.1)],
                  stops: [0.95, 1.0],
                ),
              ),
            ),

            ...List.generate(12, (index) {
              final angle = (index + 1) * 30 * pi / 180 - pi / 2;
              final x = cos(angle) * 100;
              final y = sin(angle) * 100;
              final hourLabel = (index + 1);
              final currentHour = currentTime.hourOfPeriod == 0 ? 12 : currentTime.hourOfPeriod;
              final isSelectedHour = hourLabel == currentHour;
              return Positioned(
                left: clockSize / 2 + x - 14,
                top: clockSize / 2 + y - 14,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: isSelectedHour ? Colors.redAccent : Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: Center(
                    child: Text(
                      "$hourLabel",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isSelectedHour ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              );
            }),

            // Hour needle
            Transform.rotate(
              angle: (currentTime.hour % 12 + currentTime.minute / 60) * 30 * pi / 180,
              child: Container(
                height: clockSize / 2,
                alignment: Alignment.topCenter,
                child: Container(
                  height: 60,
                  width: 4,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
            // Minute needle
            Transform.rotate(
              angle: currentTime.minute * 6 * pi / 180,
              child: Container(
                height: clockSize / 2,
                alignment: Alignment.topCenter,
                child: Container(
                  height: 68,
                  width: 2,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
            // Center knob
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
            ),


          ],
        ),
      ),
    );
  }
}