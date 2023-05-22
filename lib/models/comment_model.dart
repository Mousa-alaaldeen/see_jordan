class CommentModel {
  String? name;
  String? profilePicture;
  String? commentText;
  String? commentImage;
  String? time;
  String? userId;
  String? postId;

  CommentModel(
      {this.name,
      this.profilePicture,
      this.commentText,
      this.commentImage,
      this.time,
      this.userId,
      this.postId});

  CommentModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    profilePicture = json['profilePicture'];
    commentText = json['description'];
    commentImage = json['Image'];
    time = json['time'];
    userId = json['UserId'];
    postId = json['PostId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profilePicture': profilePicture,
      'description': commentText,
      'Image': commentImage,
      'time': time,
      'UserId': userId,
      'PostId': postId,
    };
  }
}

class CModel {
  String? userId;
  String? postId;
  String? commentText;
  String? commentImage;
  CModel.fromJson(Map<String, dynamic> json) {
    userId = json['UserId'];
    postId = json['PostId'];
    commentImage = json['Image'];
    commentText = json['description'];
  }
  Map<String, dynamic> toMap() {
    return {
      'description': commentText,
      'Image': commentImage,
      'UserId': userId,
      'PostId': postId,
    };
  }
}
