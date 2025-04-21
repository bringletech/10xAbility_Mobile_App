class GetTherapistPaymentStatusResponseModel {
  String? message;
  bool? status;
  List<TherapistPaymentData>? data;

  GetTherapistPaymentStatusResponseModel(
      {this.message, this.status, this.data});

  GetTherapistPaymentStatusResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <TherapistPaymentData>[];
      json['data'].forEach((v) {
        data!.add(new TherapistPaymentData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TherapistPaymentData {
  String? title;
  String? date;
  String? amount;
  String? rate;
  bool? isIncrement;
  String? last;
  List<Details>? details;

  TherapistPaymentData(
      {this.title,
        this.date,
        this.amount,
        this.rate,
        this.isIncrement,
        this.last,
        this.details});

  TherapistPaymentData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    date = json['date'];
    amount = json['amount'];
    rate = json['rate'];
    isIncrement = json['isIncrement'];
    last = json['last'];
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(new Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['date'] = this.date;
    data['amount'] = this.amount;
    data['rate'] = this.rate;
    data['isIncrement'] = this.isIncrement;
    data['last'] = this.last;
    if (this.details != null) {
      data['details'] = this.details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  String? date;
  String? amount;

  Details({this.date, this.amount});

  Details.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['amount'] = this.amount;
    return data;
  }
}