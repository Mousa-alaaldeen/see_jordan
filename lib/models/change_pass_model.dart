class ChangePassModel {
  String? message;
  String? errors;
  bool? status;
  ChangePassModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    errors = json['errors'];
    status = json['status'];
  }
}
