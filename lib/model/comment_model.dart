
class Comment {
  int id;
  int postId;
  int userId;
  String username;
  String comment;
  Comment({
    required this.id,
    required this.postId,
    required this.userId,
    required this.username,
    required this.comment,
  });

  Comment.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        username = json['username'],
        postId = json['post_id'],
        comment = json['comment'];

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'id': id,
        'username' : username,
        'post_id' : postId,
        'comment': comment,
      };
  
}
