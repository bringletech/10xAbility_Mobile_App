class CreateAppointmentResponseModel{
  final String message;
  final AppointmentData data;

  CreateAppointmentResponseModel({required this.message, required this.data});

  factory CreateAppointmentResponseModel.fromJson(Map<String, dynamic> json) {
    return CreateAppointmentResponseModel(
      message: json['message'],
      data: AppointmentData.fromJson(json['data']),
    );
  }
}

class AppointmentData {
  final Map<String, MonthAppointment> monthAndYear;

  AppointmentData({required this.monthAndYear});

  factory AppointmentData.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> map = json['monthAndYear'];
    final parsedMap = map.map((key, value) =>
        MapEntry(key, MonthAppointment.fromJson(value)));
    return AppointmentData(monthAndYear: parsedMap);
  }
}

class MonthAppointment {
  final List<Appointment> appointments;
  final int appointmentCount;

  MonthAppointment({required this.appointments, required this.appointmentCount});

  factory MonthAppointment.fromJson(Map<String, dynamic> json) {
    return MonthAppointment(
      appointments: (json['appointments'] as List)
          .map((e) => Appointment.fromJson(e))
          .toList(),
      appointmentCount: json['appointmentCount'],
    );
  }
}

class Appointment {
  final String id;
  final String startTime;
  final String endTime;
  final String status;

  Appointment({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.status,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      status: json['status'],
    );
  }
}
