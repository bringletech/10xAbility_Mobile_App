class Otp_Verify_Response_Model {
  String? message;
  OtpVerifyData? otpVerifyData;
  bool? status;

  Otp_Verify_Response_Model({this.message, this.otpVerifyData, this.status});

  Otp_Verify_Response_Model.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    otpVerifyData = json['data'] != null ? new OtpVerifyData.fromJson(json['data']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.otpVerifyData != null) {
      data['data'] = this.otpVerifyData!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class OtpVerifyData {
  String? id;
  String? phoneNumber;
  String? accessToken;
  bool? isProfileComplete;
  String? userType;

  OtpVerifyData(
      {this.id,
        this.phoneNumber,
        this.accessToken,
        this.isProfileComplete,
        this.userType});

  OtpVerifyData.fromJson(Map<String, dynamic> json) {
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