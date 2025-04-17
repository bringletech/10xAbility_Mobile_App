class Mobile_Verify_Response_Model {
  String? otpdata;
  String? message;
  bool? status;

  Mobile_Verify_Response_Model({this.otpdata, this.message, this.status});

  Mobile_Verify_Response_Model.fromJson(Map<String, dynamic> json) {
    otpdata = json['data'];
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.otpdata;
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}