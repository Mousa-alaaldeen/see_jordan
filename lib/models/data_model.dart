class CategoryModel {
  bool? status;
  String? errors;
  List<Data>? data;
  String? message;

  CategoryModel({this.status, this.errors, this.data, this.message});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errors = json['errors'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['errors'] = errors;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  String? id;
  String? name;
  String? createAt;
  List<CategoryItems>? categoryItems;

  Data({this.id, this.name, this.createAt, this.categoryItems});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createAt = json['createAt'];
    if (json['categoryItems'] != null) {
      categoryItems = <CategoryItems>[];
      json['categoryItems'].forEach((v) {
        categoryItems!.add(CategoryItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['createAt'] = createAt;
    if (categoryItems != null) {
      data['categoryItems'] = categoryItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryItems {
  String? map;
  String? id;
  String? title;
  String? description;
  String? cover;
  String? createAt;
  String? categoryId;
  String? category;
  String? address;

  CategoryItems(
      {this.id,
      this.map,
      this.address,
      this.title,
      this.description,
      this.cover,
      this.createAt,
      this.categoryId,
      this.category});

  CategoryItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    map = json['map'];
    title = json['title'];
    address = json['address'];
    description = json['description'];
    cover = json['cover'];
    createAt = json['createAt'];
    categoryId = json['categoryId'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['map'] = map;

    data[' address'] = address;
    data['title'] = title;
    data['description'] = description;
    data['cover'] = cover;
    data['createAt'] = createAt;
    data['categoryId'] = categoryId;
    data['category'] = category;
    return data;
  }
}
