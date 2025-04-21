import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/colors/colors.dart';
import '../base_url/base_url.dart';
import '../model/aws_response_model.dart';
import '../model/complete_patient_details_response_model.dart';
import '../model/complete_therapist_registration_response_model.dart';
import '../model/counsellor_otp_verify_response_model.dart';
import '../model/create_appointment_response_model.dart';
import '../model/create_time_slot_response_model.dart';
import '../model/delete_appointment_time_slot_response_model.dart';
import '../model/edit_user_profile_response_model.dart';

import '../model/get_all_approved_therapist_response_model.dart';
import '../model/get_appointment_remainder_response_model.dart';
import '../model/get_appointment_time_slot_response_model.dart';
import '../model/get_current_counsellor_details_response_model.dart';
import '../model/get_current_user_details_response_model.dart';
import '../model/get_monthly_appointment_response_model.dart';
import '../model/get_therapist_payment_stats_response_model.dart';
import '../model/get_upcoming_appointment_therapist_response_model.dart';
import '../model/mobile_verify_response_model.dart';

import '../model/patient_otp_verify_response_model.dart';
import '../model/upload_profile_picture_response_model.dart';

class CallService extends GetConnect{
  String? accessToken;

  // For Patient/Counsellor

  //1). For Getting Otp
  Future<Mobile_Verify_Response_Model> userLogin(dynamic body) async {
    httpClient.baseUrl = apiOtpBaseUrl;
    var res = await post('createUserAndGetOtp', body, headers: {
      'accept': 'application/json',
      /*'Authorization': "Bearer $accessToken",*/
    });
    print("response is ${res.statusCode}");
    if (res.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      print("Otp Getting Response is : ${res.statusCode.toString()}");
      return Mobile_Verify_Response_Model.fromJson(res.body);
    } else {
      throw Fluttertoast.showToast(
          msg: res.body["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  //2). For Counsellor Verifying Otp
  Future<CounsellorOtpVerifyResponseModel> verifyOtp(dynamic body) async {
    httpClient.baseUrl = apiOtpBaseUrl;
    var res = await post('authenticateUser', body, headers: {
      'accept': 'application/json',
      /*'Authorization': "Bearer $accessToken",*/
    });
    print("response is ${res.statusCode}");
    print("response is ${res}");
    if (res.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      print("Otp Getting Response is : ${res.statusCode.toString()}");
      print("Raw response body: ${res.body}");

      return CounsellorOtpVerifyResponseModel.fromJson(res.body);

    } else {
      throw Fluttertoast.showToast(
          msg: res.body["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  //3). For Patient Verifying Otp
  Future<PatientOtpVerifyResponseModel> verifyPatientOtp(dynamic body) async {
    httpClient.baseUrl = apiOtpBaseUrl;
    var res = await post('authenticateUser', body, headers: {
      'accept': 'application/json',
      /*'Authorization': "Bearer $accessToken",*/
    });
    print("response is ${res.statusCode}");
    print("response is ${res}");
    if (res.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      print("Otp Getting Response is : ${res.statusCode.toString()}");
      return PatientOtpVerifyResponseModel.fromJson(res.body);
    } else {
      throw Fluttertoast.showToast(
          msg: res.body["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  //4). For Calling Aws in For Uploading Profile Picture User/Counsellor
  Future<AwsResponseModel> getAwsUrl(String fileType,folder_name) async {
    httpClient.baseUrl = apiBaseUrl;
    print("Story Response is ${fileType}");
    print("Story Response is ${folder_name}");
    var res = await get('aws/getputurl?fileType=$fileType&folder_name=$folder_name', headers: {
      'accept': 'application/json',
    });

    print("Story Response is ${res.statusCode}");
    if (res.statusCode == 200) {
      return AwsResponseModel.fromJson(res.body);
    } else {
      throw Fluttertoast.showToast(
          msg: res.body["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  //5). For Uploading Profile Picture Of User/Counsellor
  Future<Upload_Profile_Picture_Response_Model> uploadProfilePic(dynamic body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('userToken');
    print("Access Token is $accessToken");
    httpClient.baseUrl = apiOtpBaseUrl;
    var res = await put('changeProfilePic',body, headers: {
      'accept': 'application/json',
      'Authorization': "Bearer $accessToken",
    });
    print("Story Response is ${res.statusCode}");
    if (res.statusCode == 200) {

      return Upload_Profile_Picture_Response_Model.fromJson(res.body);
    } else {
      throw Fluttertoast.showToast(
          msg: res.body["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  //6). for Completing The patient details
  Future<complete_Update_patientDetailsResponseModel> completeRegistration(dynamic body) async {
    print("Registration details value is $body");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('userToken');
    print("Access Token is $accessToken");
    httpClient.baseUrl = apiBaseUrl;
    var res = await post('patient/completePatientRegistration', body, headers: {
      'accept': 'application/json',
      'Authorization': "Bearer $accessToken",
    });
    print("Complete Patient Registration response is ${res.statusCode}");
    if (res.statusCode == 201) {
      return complete_Update_patientDetailsResponseModel.fromJson(res.body);
    } else {
      throw Fluttertoast.showToast(
          msg: res.body["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  //7).for Getting Current User
  Future<GetCurrentUserResponseModel> getCurrentUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('userToken');
    print("User Access Token Value is : $accessToken");
    httpClient.baseUrl = apiOtpBaseUrl;
    var res = await get('getCurrentUser', headers: {
      'accept': 'application/json',
      'Authorization': "Bearer $accessToken",
    });
    print("Current User Response is ${res.statusCode}");
    if (res.statusCode == 200) {
      return GetCurrentUserResponseModel.fromJson(res.body);
    } else {
      throw Fluttertoast.showToast(
          msg: res.body["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  //8). For Editing Patient Profile
  Future<EditUserProfileDetailsResponseModel> editUserDetails(dynamic body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('userToken');
    print("Access Token is $accessToken");
    httpClient.baseUrl = apiOtpBaseUrl;
    var res = await put('editUser', body, headers: {
      'accept': 'application/json',
      'Authorization': "Bearer $accessToken",
    });
    print("Edit Profile Response is ${res.statusCode}");
    if (res.statusCode == 200) {
      return EditUserProfileDetailsResponseModel.fromJson(res.body);
    } else {
      throw Fluttertoast.showToast(
          msg: res.body["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  //9).For Completing Registration Of Therapist
  Future<CompleteTherapistRegistrationResponseModel> completeRegistrationTherapist(dynamic body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('userToken');
    print("Access Token is $accessToken");
    httpClient.baseUrl = apiBaseUrl;
    print("Therapist body value is $body");
    var res = await post('therapist/completeTherapistRegistration', body, headers: {
      'accept': 'application/json',
      'Authorization': "Bearer $accessToken",
    });
    print("Complete Patient Registration response is ${res.statusCode}");
    if (res.statusCode == 201) {
      return CompleteTherapistRegistrationResponseModel.fromJson(res.body);
    } else {
      throw Fluttertoast.showToast(
          msg: res.body["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  //10).For Getting Current Therapist Details
  Future<GetCurrentCounsellorDetailsResponseMODEL> getCurrentTherapistDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('userToken');
    print("User Access Token Value is : $accessToken");
    httpClient.baseUrl = apiOtpBaseUrl;
    var res = await get('getCurrentUser', headers: {
      'accept': 'application/json',
      'Authorization': "Bearer $accessToken",
    });
    print("Current Therapist Response is ${res.statusCode}");
    if (res.statusCode == 200) {
      return GetCurrentCounsellorDetailsResponseMODEL.fromJson(res.body);
    } else {
      throw Fluttertoast.showToast(
          msg: res.body["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  //11). For Creating Time Slot For Therapist
  Future<CreateTimeSlotForAppointmentResponseModel> createAppointmentTimeSlot(dynamic body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('userToken');
    print("Access Token is $accessToken");
    httpClient.baseUrl = apiBaseUrl;
    print("Therapist body value is $body");
    var res = await post('therapist/appointmentTimeSlot/createAppointmentTimeSlot', body, headers: {
      'accept': 'application/json',
      'Authorization': "Bearer $accessToken",
    });
    print("Create Therapist Appointment Time Slot  response is ${res.statusCode}");
    if (res.statusCode == 201) {
      return CreateTimeSlotForAppointmentResponseModel.fromJson(res.body);
    } else {
      throw Fluttertoast.showToast(
          msg: res.body["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  //12). For Creating Appointment For Therapist
  Future<CreateAppointmentResponseModel> createAppointment(dynamic body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('userToken');
    print("Access Token is $accessToken");
    httpClient.baseUrl = apiBaseUrl;
    print("Therapist body value is $body");
    var res = await post('appointment/createAppointment', body, headers: {
      'accept': 'application/json',
      'Authorization': "Bearer $accessToken",
    });
    print("Create Therapist Appointment response is ${res.statusCode}");
    if (res.statusCode == 201) {
      return CreateAppointmentResponseModel.fromJson(res.body);
    } else {
      throw Fluttertoast.showToast(
          msg: res.body["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  //13). For Getting AllTime Slot
  Future<AppointmentTimeSlotsResponse> getTimeSlot(String date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('userToken');
    print("Access Token is $accessToken");
    httpClient.baseUrl = apiBaseUrl;
    var res = await get('therapist/appointmentTimeSlot/getAppointmentTimeSlots?date=$date',headers: {
      'accept': 'application/json',
      'Authorization': "Bearer $accessToken",
    });
    print("TimeSlot List Response IS ${res.statusCode}");
    if (res.statusCode == 200) {
      return AppointmentTimeSlotsResponse.fromJson(res.body);
    } else {
      throw Fluttertoast.showToast(
          msg: res.body["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  //14).For Deleting The TimeSlot
  Future<DeleteAppointmentTimeSlotResponseModel> deleteAppointmentTimeSlot(String slotId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('userToken');
    print("Access Token is $accessToken");
    print("Access Token is $slotId");
    httpClient.baseUrl = apiBaseUrl;
    var res = await delete('therapist/appointmentTimeSlot/deleteAppointmentTimeSlot/$slotId',  headers: {
      'accept': 'application/json',
      'Authorization': "Bearer $accessToken",
    });
    print("Delete TimeSlot Response is ${res.statusCode}");
    if (res.statusCode == 200) {
      return DeleteAppointmentTimeSlotResponseModel.fromJson(res.body);
    } else {
      throw Fluttertoast.showToast(
          msg: res.body["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  //15).Get Monthly Appointment
  Future<GetMonthlyAppointmentResponseModel> getMonthlyAppointment(String month ,String year) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('userToken');
    print("Access Token is $accessToken");
    httpClient.baseUrl = apiBaseUrl;
    var res = await get('appointment/getTherapistMonthlyAppointment?month=$month&year=$year',headers: {
      'accept': 'application/json',
      'Authorization': "Bearer $accessToken",
    });
    print("Monthly Appointment Response IS ${res.statusCode}");
    if (res.statusCode == 200) {
      return GetMonthlyAppointmentResponseModel.fromJson(res.body);
    } else {
      throw Fluttertoast.showToast(
          msg: res.body["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  //16). Get Therapist Payment Stats
  Future<GetTherapistPaymentStatusResponseModel> getTherapistPaymentStats() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('userToken');
    print("Access Token is $accessToken");
    httpClient.baseUrl = apiBaseUrl;
    var res = await get('therapist/getTherapistPaymentStats',headers: {
      'accept': 'application/json',
      'Authorization': "Bearer $accessToken",
    });
    print("Payment Stats Response IS ${res.statusCode}");
    if (res.statusCode == 200) {
      return GetTherapistPaymentStatusResponseModel.fromJson(res.body);
    } else {
      throw Fluttertoast.showToast(
          msg: res.body["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  //17). Get UpcomingAppointmentReminder
  Future<GetUpcomingAppointmentRemainderResponseModel> getAppointmentReminder() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('userToken');
    print("Access Token is $accessToken");
    httpClient.baseUrl = apiBaseUrl;
    var res = await get('appointment/getReminderAppointments',headers: {
      'accept': 'application/json',
      'Authorization': "Bearer $accessToken",
    });
    print("Reminder Response IS ${res.statusCode}");
    if (res.statusCode == 200) {
      return GetUpcomingAppointmentRemainderResponseModel.fromJson(res.body);
    } else {
      throw Fluttertoast.showToast(
          msg: res.body["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  //18). Get Upcoming Appointment Therapist
  Future<GetUpcomingAppointmentTherapistResponseModel> getUpcomingAppointment({ required String date}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('userToken');
    print("Access Token is $accessToken");
    httpClient.baseUrl = apiBaseUrl;
    var res = await get('appointment/upcomingAppointmentsByDate?date=$date',headers: {
      'accept': 'application/json',
      'Authorization': "Bearer $accessToken",
    });
    print("Upcoming Appointment Response IS ${res.statusCode}");
    if (res.statusCode == 200) {
      return GetUpcomingAppointmentTherapistResponseModel.fromJson(res.body);
    } else {
      throw Fluttertoast.showToast(
          msg: res.body["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  //19). Get Approved Therapist List
  Future<GetApprovedTherapistResponseModel> getTherapistList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('userToken');
    print("Access Token is $accessToken");
    httpClient.baseUrl = apiBaseUrl;
    var res = await get('therapist/getTherapistsWithCriteriaController',headers: {
      'accept': 'application/json',
      'Authorization': "Bearer $accessToken",
    });
    print("Approved Therapist List Response IS ${res.statusCode}");
    if (res.statusCode == 200) {
      return GetApprovedTherapistResponseModel.fromJson(res.body);
    } else {
      throw Fluttertoast.showToast(
          msg: res.body["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

}