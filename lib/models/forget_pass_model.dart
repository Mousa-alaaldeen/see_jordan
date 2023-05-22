class ForgetPassModel {
  String? email;
  ForgetPassModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
  }
}
