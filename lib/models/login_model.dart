// ignore_for_file: prefer_collection_literals, unnecessary_this

class LoginModel {
  bool? status;
  Errors? errorData;
  Data? data;

  LoginModel({
    this.status,
    this.errorData,
    this.data,
  });

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errorData = json['errors'] != null ? Errors.fromJson(json['errors']) : null;
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    if (this.errorData != null) {
      data['errors'] = this.errorData!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }

    return data;
  }
}

class Errors {
  String? username;
  String? password;

  Errors({this.username, this.password});

  Errors.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    return data;
  }
}

class Data {
  bool? isAdmin;
  String? token;
  String? userId;
  String? firstName;
  late String lastName;
  String? email;
  String? profilePic;
  String? bio;

  Data(
      {this.isAdmin,
      required this.token,
      this.userId,
      required this.firstName,
      required this.lastName,
      this.email,
      this.profilePic,
      this.bio});

  Data.fromJson(Map<String, dynamic> json) {
    isAdmin = json['isAdmin'];
    token = json['token'];
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    profilePic = json['profilePic'];
    bio = json['bio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['isAdmin'] = this.isAdmin;
    data['token'] = this.token;
    data['userId'] = this.userId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['profilePic'] = this.profilePic;
    data['bio'] = this.bio;
    return data;
  }
}
