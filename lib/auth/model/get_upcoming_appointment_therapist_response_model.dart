class GetUpcomingAppointmentTherapistResponseModel {
  bool? success;
  String? message;
  List<UpcomingAppointmentData>? data;

  GetUpcomingAppointmentTherapistResponseModel(
      {this.success, this.message, this.data});

  GetUpcomingAppointmentTherapistResponseModel.fromJson(
      Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <UpcomingAppointmentData>[];
      json['data'].forEach((v) {
        data!.add(new UpcomingAppointmentData.fromJson(v));
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

class UpcomingAppointmentData {
  String? id;
  String? title;
  String? timeSlot;
  String? day;
  String? therapistName;
  String? therapistId;
  String? therapistImage;

  UpcomingAppointmentData(
      {this.id,
        this.title,
        this.timeSlot,
        this.day,
        this.therapistName,
        this.therapistId,
        this.therapistImage});

  UpcomingAppointmentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    timeSlot = json['timeSlot'];
    day = json['day'];
    therapistName = json['therapistName'];
    therapistId = json['therapistId'];
    therapistImage = json['therapistImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['timeSlot'] = this.timeSlot;
    data['day'] = this.day;
    data['therapistName'] = this.therapistName;
    data['therapistId'] = this.therapistId;
    data['therapistImage'] = this.therapistImage;
    return data;
  }
}