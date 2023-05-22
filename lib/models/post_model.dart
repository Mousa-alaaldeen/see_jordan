// ignore_for_file: prefer_collection_literals

class PostModel {
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

  PostModel(
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

  PostModel.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = Map<String, dynamic>();
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['likeId'] = likeId;
    data['userId'] = userId;
    data['name'] = name;
    data['likedPic'] = likedPic;
    return data;
  }
}

class PostDataModel {
  final List<PostModel> list;
  PostDataModel({
    required this.list,
  });
  factory PostDataModel.formJson(List<dynamic> parsedJson) {
    List<PostModel> list = <PostModel>[];
    list = parsedJson.map((i) => PostModel.fromJson(i)).toList();
    return PostDataModel(list: list);
  }
}
