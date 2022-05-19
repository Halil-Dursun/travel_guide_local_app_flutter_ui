import 'package:go_mobile_app/model/comment_model.dart';

import 'post_model.dart';

class PostWithComment {
  List<Comment>? comments;
  Post? post;

  PostWithComment({this.comments, this.post});

  PostWithComment.fromJson(Map<String, dynamic> json) {
    if (json['comments'] != null) {
      comments = <Comment>[];
      json['comments'].forEach((v) {
        comments!.add(Comment.fromJson(v));
      });
    }else{
      comments = [];
    }
    post = json['post'] != null ? Post.fromJson(json['post']) : null;
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = Map<String, dynamic>();
  //   if (comments != null) {
  //     data['comments'] = comments!.map((v) => v.toJson()).toList();
  //   }
  //   if (post != null) {
  //     data['post'] = post!.toJson();
  //   }
  //   return data;
  // }
}