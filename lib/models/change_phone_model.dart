class ChangePhoneModel {
  String? message;
  String? errors;
  bool? status;
  ChangePhoneModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    errors = json['errors'];
    status = json['status'];
  }
}
