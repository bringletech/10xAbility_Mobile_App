class GetApprovedTherapistResponseModel {
  String? message;
  List<ApprovedTherapistData>? data;
  Pagination? pagination;
  bool? status;

  GetApprovedTherapistResponseModel(
      {this.message, this.data, this.pagination, this.status});

  GetApprovedTherapistResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <ApprovedTherapistData>[];
      json['data'].forEach((v) {
        data!.add(new ApprovedTherapistData.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class ApprovedTherapistData {
  String? id;
  String? fullName;
  String? email;
  String? phoneNumber;
  String? gender;
  String? dateOfBirth;
  int? age;
  String? city;
  String? state;
  String? country;
  String? pincode;
  String? profilePicture;
  bool? isActive;
  String? collegeName;
  String? degree;
  int? yearsOfExperience;
  List<String>? specialization;
  List<String>? certification;
  String? higherEducation;
  String? bio;
  bool? isVerified;
  int? averageRating;
  List<String>? languages;
  String? aadharNumber;
  String? aadharFront;
  String? aadharBack;
  String? pancard;
  String? createdAt;
  List<Appointments>? appointments;
 // List<Null>? reviews;

  ApprovedTherapistData(
      {this.id,
        this.fullName,
        this.email,
        this.phoneNumber,
        this.gender,
        this.dateOfBirth,
        this.age,
        this.city,
        this.state,
        this.country,
        this.pincode,
        this.profilePicture,
        this.isActive,
        this.collegeName,
        this.degree,
        this.yearsOfExperience,
        this.specialization,
        this.certification,
        this.higherEducation,
        this.bio,
        this.isVerified,
        this.averageRating,
        this.languages,
        this.aadharNumber,
        this.aadharFront,
        this.aadharBack,
        this.pancard,
        this.createdAt,
        this.appointments,
       // this.reviews
      });

  ApprovedTherapistData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
    age = json['age'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    pincode = json['pincode'];
    profilePicture = json['profilePicture'];
    isActive = json['isActive'];
    collegeName = json['collegeName'];
    degree = json['degree'];
    yearsOfExperience = json['yearsOfExperience'];
    specialization = json['specialization'].cast<String>();
    certification = json['certification'].cast<String>();
    higherEducation = json['higherEducation'];
    bio = json['bio'];
    isVerified = json['isVerified'];
    averageRating = json['averageRating'];
    languages = json['languages'].cast<String>();
    aadharNumber = json['aadharNumber'];
    aadharFront = json['aadharFront'];
    aadharBack = json['aadharBack'];
    pancard = json['pancard'];
    createdAt = json['createdAt'];
    if (json['appointments'] != null) {
      appointments = <Appointments>[];
      json['appointments'].forEach((v) {
        appointments!.add(new Appointments.fromJson(v));
      });
    }
    // if (json['reviews'] != null) {
    //   reviews = <Null>[];
    //   json['reviews'].forEach((v) {
    //     reviews!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['gender'] = this.gender;
    data['dateOfBirth'] = this.dateOfBirth;
    data['age'] = this.age;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['pincode'] = this.pincode;
    data['profilePicture'] = this.profilePicture;
    data['isActive'] = this.isActive;
    data['collegeName'] = this.collegeName;
    data['degree'] = this.degree;
    data['yearsOfExperience'] = this.yearsOfExperience;
    data['specialization'] = this.specialization;
    data['certification'] = this.certification;
    data['higherEducation'] = this.higherEducation;
    data['bio'] = this.bio;
    data['isVerified'] = this.isVerified;
    data['averageRating'] = this.averageRating;
    data['languages'] = this.languages;
    data['aadharNumber'] = this.aadharNumber;
    data['aadharFront'] = this.aadharFront;
    data['aadharBack'] = this.aadharBack;
    data['pancard'] = this.pancard;
    data['createdAt'] = this.createdAt;
    if (this.appointments != null) {
      data['appointments'] = this.appointments!.map((v) => v.toJson()).toList();
    }
    // if (this.reviews != null) {
    //   data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Appointments {
  String? id;
  String? status;
  String? appointmentDate;

  Appointments({this.id, this.status, this.appointmentDate});

  Appointments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    appointmentDate = json['appointmentDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['appointmentDate'] = this.appointmentDate;
    return data;
  }
}

class Pagination {
  int? currentPage;
  int? totalPages;
  int? totalCount;
  bool? hasMore;

  Pagination(
      {this.currentPage, this.totalPages, this.totalCount, this.hasMore});

  Pagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    totalCount = json['totalCount'];
    hasMore = json['hasMore'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currentPage'] = this.currentPage;
    data['totalPages'] = this.totalPages;
    data['totalCount'] = this.totalCount;
    data['hasMore'] = this.hasMore;
    return data;
  }
}