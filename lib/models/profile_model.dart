class ProfileModel {
  bool? status;
  Data? data;
  ProfileModel({
    this.status,
    this.data,
  });

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];

    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;

    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }

    return data;
  }
}

class Data {
  String? userId;
  String? email;
  String? phone;
  String? name;
  String? profilepicture;
  String? coverpicture;
  String? bio;
  int? numberofpost;
  List<Post>? posts;

  Data(
      {this.userId,
      this.email,
      this.phone,
      this.name,
      this.profilepicture,
      this.coverpicture,
      this.bio,
      this.numberofpost,
      this.posts});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    email = json['email'];
    phone = json['phone'];
    name = json['name'];
    profilepicture = json['profilepicture'];
    coverpicture = json['coverpicture'];
    bio = json['bio'];
    numberofpost = json['numberofpost'];
    if (json['posts'] != null) {
      posts = <Post>[];
      json['posts'].forEach((v) {
        posts!.add(Post.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['email'] = email;
    data['phone'] = phone;
    data['name'] = name;
    data['profilepicture'] = profilepicture;
    data['coverpicture'] = coverpicture;
    data['bio'] = bio;
    data['numberofpost'] = numberofpost;
    if (posts != null) {
      data['posts'] = posts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Post {
  String? postId;
  String? userId;
  String? name;
  String? profilePic;
  String? description;
  String? poster;
  String? postCreated;
  int? numberOfComments;
  List<Comments>? comments;
  int? numberOfLikes;
  List<Likes>? likes;

  Post(
      {this.postId,
      this.userId,
      this.name,
      this.profilePic,
      this.description,
      this.poster,
      this.postCreated,
      this.numberOfComments,
      this.comments,
      this.numberOfLikes,
      this.likes});

  Post.fromJson(Map<String, dynamic> json) {
    postId = json['postId'];
    userId = json['userId'];
    name = json['name'];
    profilePic = json['profilePic'];
    description = json['description'];
    poster = json['poster'];
    postCreated = json['postCreated'];
    numberOfComments = json['numberOfComments'];
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }
    numberOfLikes = json['numberOfLikes'];
    if (json['likes'] != null) {
      likes = <Likes>[];
      json['likes'].forEach((v) {
        likes!.add(Likes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['postId'] = postId;
    data['userId'] = userId;
    data['name'] = name;
    data['profilePic'] = profilePic;
    data['description'] = description;
    data['poster'] = poster;
    data['postCreated'] = postCreated;
    data['numberOfComments'] = numberOfComments;
    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
    }
    data['numberOfLikes'] = numberOfLikes;
    if (likes != null) {
      data['likes'] = likes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comments {
  String? commentId;
  String? commenterId;
  String? commenterName;
  String? commenterPic;
  String? descriptionComment;
  String? image;
  String? commentCreated;

  Comments(
      {this.commentId,
      this.commenterId,
      this.commenterName,
      this.commenterPic,
      this.descriptionComment,
      this.image,
      this.commentCreated});

  Comments.fromJson(Map<String, dynamic> json) {
    commentId = json['commentId'];
    commenterId = json['commenterId'];
    commenterName = json['commenterName'];
    commenterPic = json['commenterPic'];
    descriptionComment = json['descriptionComment'];
    image = json['image'];
    commentCreated = json['commentCreated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['commentId'] = commentId;
    data['commenterId'] = commenterId;
    data['commenterName'] = commenterName;
    data['commenterPic'] = commenterPic;
    data['descriptionComment'] = descriptionComment;
    data['image'] = image;
    data['commentCreated'] = commentCreated;
    return data;
  }
}

class Likes {
  String? likeId;
  String? userId;
  String? name;
  String? likedPic;

  Likes({this.likeId, this.userId, this.name, this.likedPic});

  Likes.fromJson(Map<String, dynamic> json) {
    likeId = json['likeId'];
    userId = json['userId'];
    name = json['name'];
    likedPic = json['likedPic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['likeId'] = likeId;
    data['userId'] = userId;
    data['name'] = name;
    data['likedPic'] = likedPic;
    return data;
  }
}

class ProfilePostDataModel {
  final List<ProfileModel> list;
  ProfilePostDataModel({
    required this.list,
  });
  factory ProfilePostDataModel.formJson(List<dynamic> parsedJson) {
    List<ProfileModel> list = <ProfileModel>[];
    list = parsedJson.map((i) => ProfileModel.fromJson(i)).toList();
    return ProfilePostDataModel(list: list);
  }
}
