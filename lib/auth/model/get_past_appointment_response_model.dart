class GetPastAppointmentsResponseModel {
  bool? success;
  String? message;
  List<PastAppointmentData>? data;

  GetPastAppointmentsResponseModel({this.success, this.message, this.data});

  GetPastAppointmentsResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PastAppointmentData>[];
      json['data'].forEach((v) {
        data!.add(new PastAppointmentData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PastAppointmentData {
  String? id;
  String? day;
  String? timeSlot;
  String? appointmentStatus;
  List<String>? specialization;
  String? therapistName;
  String? therapistId;
  String? therapistPicture;

  PastAppointmentData(
      {this.id,
        this.day,
        this.timeSlot,
        this.appointmentStatus,
        this.specialization,
        this.therapistName,
        this.therapistId,
        this.therapistPicture});

  PastAppointmentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    day = json['day'];
    timeSlot = json['timeSlot'];
    appointmentStatus = json['appointmentStatus'];
    specialization = json['specialization'].cast<String>();
    therapistName = json['therapistName'];
    therapistId = json['therapistId'];
    therapistPicture = json['therapistPicture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['day'] = this.day;
    data['timeSlot'] = this.timeSlot;
    data['appointmentStatus'] = this.appointmentStatus;
    data['specialization'] = this.specialization;
    data['therapistName'] = this.therapistName;
    data['therapistId'] = this.therapistId;
    data['therapistPicture'] = this.therapistPicture;
    return data;
  }
}