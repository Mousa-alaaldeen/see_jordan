// class LoginModel {
//   late bool status;
//   UserData? data;
//   ErrorData? errorData;
//   LoginModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     data = json['data'] != null ? UserData.fromJson(json['data']) : null;
//     errorData =
//         json['errors'] != null ? ErrorData.fromJson(json['errors']) : null;
//   }
// }

// class UserData {
//   String? token;
//   String? userId;
//   UserData.fromJson(Map<String, dynamic> json) {
//     token = json['token'];
//     userId = json['userId'];
//   }
// }

// class ErrorData {
//   String? password;
//   String? username;
//   ErrorData.fromJson(Map<String, dynamic> json) {
//     password = json['password'];
//     username = json[' username'];
//   }
// }