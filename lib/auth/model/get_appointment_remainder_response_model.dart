class GetUpcomingAppointmentRemainderResponseModel {
  List<reminderData>? data;
  String? message;
  bool? success;

  GetUpcomingAppointmentRemainderResponseModel(
      {this.data, this.message, this.success});

  GetUpcomingAppointmentRemainderResponseModel.fromJson(
      Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <reminderData>[];
      json['data'].forEach((v) {
        data!.add(new reminderData.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class reminderData {
  String? id;
  String? patientName;
  String? timeSlot;

  reminderData({this.id, this.patientName, this.timeSlot});

  reminderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientName = json['patientName'];
    timeSlot = json['timeSlot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['patientName'] = this.patientName;
    data['timeSlot'] = this.timeSlot;
    return data;
  }
}