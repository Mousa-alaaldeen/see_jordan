// ignore_for_file: prefer_collection_literals, unnecessary_this

class BioModel {
  bool? status;
  Error? errors;
  Data? data;
  String? message;

  BioModel({this.status, this.errors, this.data, this.message});

  BioModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errors = json['errors'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['errors'] = this.errors;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? bio;

  Data({this.bio});

  Data.fromJson(Map<String, dynamic> json) {
    bio = json['bio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['bio'] = this.bio;
    return data;
  }
}
