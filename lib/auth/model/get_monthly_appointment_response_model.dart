class GetMonthlyAppointmentResponseModel {
  final String message;
  final MonthlyAppointmentData data;

  GetMonthlyAppointmentResponseModel({
    required this.message,
    required this.data,
  });

  factory GetMonthlyAppointmentResponseModel.fromJson(Map<String, dynamic> json) {
    return GetMonthlyAppointmentResponseModel(
      message: json['message'],
      data: MonthlyAppointmentData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.toJson(),
    };
  }
}

class MonthlyAppointmentData {
  final Map<String, AppointmentDate> monthAndYear;

  MonthlyAppointmentData({
    required this.monthAndYear,
  });

  factory MonthlyAppointmentData.fromJson(Map<String, dynamic> json) {
    Map<String, AppointmentDate> temp = {};
    json['monthAndYear'].forEach((key, value) {
      temp[key] = AppointmentDate.fromJson(value);
    });
    return MonthlyAppointmentData(monthAndYear: temp);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    monthAndYear.forEach((key, value) {
      result[key] = value.toJson();
    });
    return {'monthAndYear': result};
  }
}

class AppointmentDate {
  final List<Appointment> appointments;
  final int appointmentCount;

  AppointmentDate({
    required this.appointments,
    required this.appointmentCount,
  });

  factory AppointmentDate.fromJson(Map<String, dynamic> json) {
    return AppointmentDate(
      appointments: List<Appointment>.from(
        json['appointments'].map((x) => Appointment.fromJson(x)),
      ),
      appointmentCount: json['appointmentCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'appointments': appointments.map((x) => x.toJson()).toList(),
      'appointmentCount': appointmentCount,
    };
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'startTime': startTime,
      'endTime': endTime,
      'status': status,
    };
  }
}
