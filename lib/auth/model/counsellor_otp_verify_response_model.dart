class CounsellorOtpVerifyResponseModel {
  String? message;
  CounsellorData? data;
  bool? status;

  CounsellorOtpVerifyResponseModel({this.message, this.data, this.status});

  CounsellorOtpVerifyResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new CounsellorData.fromJson(json['data']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class CounsellorData {
  String? id;
  String? phoneNumber;
  String? accessToken;
  bool? isProfileComplete;
  String? profileStatus;
  String? userType;

  CounsellorData(
      {this.id,
        this.phoneNumber,
        this.accessToken,
        this.isProfileComplete,
        this.profileStatus,
        this.userType});

  CounsellorData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phoneNumber = json['phoneNumber'];
    accessToken = json['accessToken'];
    isProfileComplete = json['isProfileComplete'];
    profileStatus = json['profileStatus'];
    userType = json['userType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phoneNumber'] = this.phoneNumber;
    data['accessToken'] = this.accessToken;
    data['isProfileComplete'] = this.isProfileComplete;
    data['profileStatus'] = this.profileStatus;
    data['userType'] = this.userType;
    return data;
  }
}