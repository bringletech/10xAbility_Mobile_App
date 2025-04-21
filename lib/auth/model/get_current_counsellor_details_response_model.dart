class GetCurrentCounsellorDetailsResponseMODEL {
  Data? data;
  String? message;
  bool? status;

  GetCurrentCounsellorDetailsResponseMODEL(
      {this.data, this.message, this.status});

  GetCurrentCounsellorDetailsResponseMODEL.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  String? id;
  String? phoneNumber;
  String? otp;
  bool? isOtpVerified;
  String? role;
  String? userType;
  String? status;
  String? fullName;
  String? email;
  String? gender;
  String? dateOfBirth;
  int? age;
  String? city;
  String? state;
  String? country;
  String? pincode;
  String? profilePicture;
  bool? isActive;
  String? previousStatus;
  String? rejectionReason;
  String? collegeName;
  String? degree;
  int? yearsOfExperience;
  List<String>? specialization;
  List<Null>? certification;
  String? higherEducation;
  String? bio;
  bool? isVerified;
  bool? isApproved;
  int? averageRating;
  List<String>? languages;
  String? aadharNumber;
  String? aadharFront;
  String? aadharBack;
  String? pancard;
  String? linkedinProfile;
  String? instagramProfile;
  String? facebookProfile;
  String? twitterProfile;
  String? suspensionReason;
  String? suspendedAt;
  String? accountStatus;
  String? suspensionHistory;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.phoneNumber,
        this.otp,
        this.isOtpVerified,
        this.role,
        this.userType,
        this.status,
        this.fullName,
        this.email,
        this.gender,
        this.dateOfBirth,
        this.age,
        this.city,
        this.state,
        this.country,
        this.pincode,
        this.profilePicture,
        this.isActive,
        this.previousStatus,
        this.rejectionReason,
        this.collegeName,
        this.degree,
        this.yearsOfExperience,
        this.specialization,
        this.certification,
        this.higherEducation,
        this.bio,
        this.isVerified,
        this.isApproved,
        this.averageRating,
        this.languages,
        this.aadharNumber,
        this.aadharFront,
        this.aadharBack,
        this.pancard,
        this.linkedinProfile,
        this.instagramProfile,
        this.facebookProfile,
        this.twitterProfile,
        this.suspensionReason,
        this.suspendedAt,
        this.accountStatus,
        this.suspensionHistory,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phoneNumber = json['phoneNumber'];
    otp = json['otp'];
    isOtpVerified = json['isOtpVerified'];
    role = json['role'];
    userType = json['userType'];
    status = json['status'];
    fullName = json['fullName'];
    email = json['email'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
    age = json['age'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    pincode = json['pincode'];
    profilePicture = json['profilePicture'];
    isActive = json['isActive'];
    previousStatus = json['previousStatus'];
    rejectionReason = json['rejectionReason'];
    collegeName = json['collegeName'];
    degree = json['degree'];
    yearsOfExperience = json['yearsOfExperience'];
    specialization = json['specialization'].cast<String>();
    // if (json['certification'] != null) {
    //   certification = <Null>[];
    //   json['certification'].forEach((v) {
    //     certification!.add(new Null.fromJson(v));
    //   });
    // }
    higherEducation = json['higherEducation'];
    bio = json['bio'];
    isVerified = json['isVerified'];
    isApproved = json['isApproved'];
    averageRating = json['averageRating'];
    languages = json['languages'].cast<String>();
    aadharNumber = json['aadharNumber'];
    aadharFront = json['aadharFront'];
    aadharBack = json['aadharBack'];
    pancard = json['pancard'];
    linkedinProfile = json['linkedinProfile'];
    instagramProfile = json['instagramProfile'];
    facebookProfile = json['facebookProfile'];
    twitterProfile = json['twitterProfile'];
    suspensionReason = json['suspensionReason'];
    suspendedAt = json['suspendedAt'];
    accountStatus = json['accountStatus'];
    //suspensionHistory = json['suspensionHistory'];
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
    data['status'] = this.status;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['dateOfBirth'] = this.dateOfBirth;
    data['age'] = this.age;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['pincode'] = this.pincode;
    data['profilePicture'] = this.profilePicture;
    data['isActive'] = this.isActive;
    data['previousStatus'] = this.previousStatus;
    data['rejectionReason'] = this.rejectionReason;
    data['collegeName'] = this.collegeName;
    data['degree'] = this.degree;
    data['yearsOfExperience'] = this.yearsOfExperience;
    data['specialization'] = this.specialization;
    // if (this.certification != null) {
    //   data['certification'] =
    //       this.certification!.map((v) => v.toJson()).toList();
    // }
    data['higherEducation'] = this.higherEducation;
    data['bio'] = this.bio;
    data['isVerified'] = this.isVerified;
    data['isApproved'] = this.isApproved;
    data['averageRating'] = this.averageRating;
    data['languages'] = this.languages;
    data['aadharNumber'] = this.aadharNumber;
    data['aadharFront'] = this.aadharFront;
    data['aadharBack'] = this.aadharBack;
    data['pancard'] = this.pancard;
    data['linkedinProfile'] = this.linkedinProfile;
    data['instagramProfile'] = this.instagramProfile;
    data['facebookProfile'] = this.facebookProfile;
    data['twitterProfile'] = this.twitterProfile;
    data['suspensionReason'] = this.suspensionReason;
    data['suspendedAt'] = this.suspendedAt;
    data['accountStatus'] = this.accountStatus;
    data['suspensionHistory'] = this.suspensionHistory;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}