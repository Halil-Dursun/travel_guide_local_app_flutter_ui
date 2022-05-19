class Post {
  int id;
  int userId;
  String username;
  String title;
  String description;
  String city;
  Post({
    required this.id,
    required this.userId,
    required this.username,
    required this.title,
    required this.description,
    required this.city,
  });

  Post.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        username = json['username'],
        title = json['title'],
        description = json['description'],
        city = json['city'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'username' : username,
        'title' : title,
        'description': description,
        'city' : city,
      };
  
}
