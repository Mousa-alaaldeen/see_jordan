class CreatePost {
  String? userId;
  String? poster;
  String? description;
  String? postId;
  String? name;

  String? userImage;

  CreatePost({
    this.postId,
    this.name,
    this.userId,
    this.userImage,
    this.description,
    this.poster,
  });

  CreatePost.fromJson(Map<String, dynamic>? json) {
    postId = json!['postId'];
    name = json['name'];
    userId = json['UserId'];
    userImage = json['userImage'];
    description = json['description'];
    poster = json['Poster'];
  }

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'name': name,
      'UserId': userId,
      'userImage': userImage,
      'description': description,
      'Poster': poster,
    };
  }
}
