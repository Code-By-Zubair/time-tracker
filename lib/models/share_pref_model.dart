import 'dart:convert';

class SharePrefModel {
  String? firstName;
  String? lastName;
  String? email;
  String? profile;
  String? loginMethod;
  String role;

  SharePrefModel({
    this.firstName,
    this.lastName,
    this.email,
    this.profile,
    this.loginMethod,
    required this.role,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'profile': profile,
      'loginMethod': loginMethod,
      'role': role,
    };
  }

  factory SharePrefModel.fromJson(Map<String, dynamic> json) {
    return SharePrefModel(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      profile: json['profile'] ?? '',
      loginMethod: json['loginMethod'] ?? '',
      role: json['role'] ?? '',
    );
  }
  factory SharePrefModel.fromString(String data) {
    Map<String, dynamic> userMap = Map<String, dynamic>.from(jsonDecode(data));
    return SharePrefModel.fromJson(userMap);
  }
}
