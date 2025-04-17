class PatientOtpVerifyResponseModel{
  String? message;
  PatientOtpVerifyData? data;
  bool? status;

  PatientOtpVerifyResponseModel({this.message, this.data, this.status});

  PatientOtpVerifyResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new PatientOtpVerifyData.fromJson(json['data']) : null;
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

class PatientOtpVerifyData {
  String? id;
  String? phoneNumber;
  String? accessToken;
  bool? isProfileComplete;
  String? userType;

  PatientOtpVerifyData(
      {this.id,
        this.phoneNumber,
        this.accessToken,
        this.isProfileComplete,
        this.userType});

  PatientOtpVerifyData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phoneNumber = json['phoneNumber'];
    accessToken = json['accessToken'];
    isProfileComplete = json['isProfileComplete'];
    userType = json['userType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phoneNumber'] = this.phoneNumber;
    data['accessToken'] = this.accessToken;
    data['isProfileComplete'] = this.isProfileComplete;
    data['userType'] = this.userType;
    return data;
  }
}