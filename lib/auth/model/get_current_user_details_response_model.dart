class GetCurrentUserResponseModel {
  UserData? data;
  String? message;
  bool? status;

  GetCurrentUserResponseModel({this.data, this.message, this.status});

  GetCurrentUserResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new UserData.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class UserData {
  String? id;
  String? phoneNumber;
  String? otp;
  bool? isOtpVerified;
  String? role;
  String? userType;
  String? fullName;
  String? email;
  String? gender;
  String? city;
  String? state;
  String? country;
  String? pincode;
  String? profilePicture;
  String? profession;
  String? currentFacingProb;
  bool? isActive;
  String? dateOfBirth;
  int? age;
  String? notificationPrefs;
  String? suspensionReason;
  String? suspendedAt;
  String? accountStatus;
  String? suspensionHistory;
  bool? hasUsedFreeSession;
  String? freeSessionDate;
  String? createdAt;
  String? updatedAt;

  UserData(
      {this.id,
        this.phoneNumber,
        this.otp,
        this.isOtpVerified,
        this.role,
        this.userType,
        this.fullName,
        this.email,
        this.gender,
        this.city,
        this.state,
        this.country,
        this.pincode,
        this.profilePicture,
        this.profession,
        this.currentFacingProb,
        this.isActive,
        this.dateOfBirth,
        this.age,
        this.notificationPrefs,
        this.suspensionReason,
        this.suspendedAt,
        this.accountStatus,
        this.suspensionHistory,
        this.hasUsedFreeSession,
        this.freeSessionDate,
        this.createdAt,
        this.updatedAt});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phoneNumber = json['phoneNumber'];
    otp = json['otp'];
    isOtpVerified = json['isOtpVerified'];
    role = json['role'];
    userType = json['userType'];
    fullName = json['fullName'];
    email = json['email'];
    gender = json['gender'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    pincode = json['pincode'];
    profilePicture = json['profilePicture'];
    profession = json['profession'];
    currentFacingProb = json['currentFacingProb'];
    isActive = json['isActive'];
    dateOfBirth = json['dateOfBirth'];
    age = json['age'];
    notificationPrefs = json['notificationPrefs'];
    suspensionReason = json['suspensionReason'];
    suspendedAt = json['suspendedAt'];
    accountStatus = json['accountStatus'];
    suspensionHistory = json['suspensionHistory'];
    hasUsedFreeSession = json['hasUsedFreeSession'];
    freeSessionDate = json['freeSessionDate'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phoneNumber'] = this.phoneNumber;
    data['otp'] = this.otp;
    data['isOtpVerified'] = this.isOtpVerified;
    data['role'] = this.role;
    data['userType'] = this.userType;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['pincode'] = this.pincode;
    data['profilePicture'] = this.profilePicture;
    data['profession'] = this.profession;
    data['currentFacingProb'] = this.currentFacingProb;
    data['isActive'] = this.isActive;
    data['dateOfBirth'] = this.dateOfBirth;
    data['age'] = this.age;
    data['notificationPrefs'] = this.notificationPrefs;
    data['suspensionReason'] = this.suspensionReason;
    data['suspendedAt'] = this.suspendedAt;
    data['accountStatus'] = this.accountStatus;
    data['suspensionHistory'] = this.suspensionHistory;
    data['hasUsedFreeSession'] = this.hasUsedFreeSession;
    data['freeSessionDate'] = this.freeSessionDate;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}