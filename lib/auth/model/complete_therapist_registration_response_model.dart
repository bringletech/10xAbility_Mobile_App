class CompleteTherapistRegistrationResponseModel {
  String? message;
  bool? status;
  String? profileStatus;

  CompleteTherapistRegistrationResponseModel(
      {this.message, this.status, this.profileStatus});

  CompleteTherapistRegistrationResponseModel.fromJson(
      Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    profileStatus = json['profileStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    data['profileStatus'] = this.profileStatus;
    return data;
  }
}