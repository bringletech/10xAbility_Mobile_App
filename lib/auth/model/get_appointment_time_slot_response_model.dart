class AppointmentTimeSlotsResponse {
  final String message;
  final List<AppointmentSlot> data;

  AppointmentTimeSlotsResponse({
    required this.message,
    required this.data,
  });

  factory AppointmentTimeSlotsResponse.fromJson(Map<String, dynamic> json) {
    return AppointmentTimeSlotsResponse(
      message: json['message'] ?? '',
      data: List<AppointmentSlot>.from(
        json['data'].map((slot) => AppointmentSlot.fromJson(slot)),
      ),
    );
  }
}

class AppointmentSlot {
  final String id;
  final String timeSlot;
  final String startTime;
  final String endTime;
  final bool isBooked;

  AppointmentSlot({
    required this.id,
    required this.timeSlot,
    required this.startTime,
    required this.endTime,
    required this.isBooked,
  });

  factory AppointmentSlot.fromJson(Map<String, dynamic> json) {
    return AppointmentSlot(
      id: json['id'] ?? '',
      timeSlot: json['timeSlot'] ?? '',
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
      isBooked: json['isBooked'] ?? false,
    );
  }
}
