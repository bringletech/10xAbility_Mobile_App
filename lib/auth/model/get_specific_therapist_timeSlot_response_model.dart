class GetSpecificTherapistTimeSlotResponseModel {
  bool? success;
  List<timeSlotData>? data;
  String? message;

  GetSpecificTherapistTimeSlotResponseModel(
      {this.success, this.data, this.message});

  GetSpecificTherapistTimeSlotResponseModel.fromJson(
      Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <timeSlotData>[];
      json['data'].forEach((v) {
        data!.add(new timeSlotData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class timeSlotData {
  String? id;
  String? startTime;
  String? endTime;
  String? timeSlot;
  String? status;

  timeSlotData({this.id, this.startTime, this.endTime, this.timeSlot, this.status});

  timeSlotData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    timeSlot = json['timeSlot'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['timeSlot'] = this.timeSlot;
    data['status'] = this.status;
    return data;
  }
}