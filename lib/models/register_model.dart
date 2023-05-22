class RegisterModel {
  late UserData data;
  ErrorData? errorData;
  RegisterModel.fromJson(Map<String, dynamic> json) {
    data = (json['data'] != null ? UserData.fromJson(json['data']) : null)!;
    errorData =
        json['error'] != null ? ErrorData.fromJson(json['error']) : null;
  }
}

class UserData {
  String? userId;
  String? firatName;
  String? lastName;
  int? phone;
  String? password;
  String? confirmPassword;
  String? email;
  String? token;

  UserData.fromJson(Map<String, dynamic> json) {
    firatName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
    password = json['password'];
    email = json['email'];
    confirmPassword = json['confirmPassword'];
    token = json['token'];
    userId = json['userId'];
  }
}

class ErrorData {
  String? firstName;
  String? lastName;
  String? eamil;
  int? phone;
  String? confirmPassword;

  ErrorData.fromJson(Map<String, dynamic> json) {
    firstName = json['FirstName'];
    lastName = json['LastName'];
    eamil = json['Eamil'];
    phone = json['Phone'];
    confirmPassword = json['ConfirmPassword'];
  }
}
