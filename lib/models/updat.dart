// ignore_for_file: unnecessary_this, prefer_collection_literals

class UpdatNameModel {
  bool? status;
  Errors? errors;
  Data? data;
  String? message;

  UpdatNameModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errors = json['errors'] != null ? Errors.fromJson(json['errors']) : null;
    data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    if (this.errors != null) {
      data['errors'] = this.errors!.toJson();
    }
    data['data'] = this.data!.toJson();
    data['message'] = this.message;
    return data;
  }
}

class Errors {
  String? password;

  Errors({this.password});

  Errors.fromJson(Map<String, dynamic> json) {
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['password'] = this.password;
    return data;
  }
}

class Data {
  late String firstname;
  late String lastname;

  Data({required this.firstname, required this.lastname});

  Data.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    return data;
  }
}
