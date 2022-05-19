import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:go_mobile_app/api/current_user.dart';
import 'package:go_mobile_app/model/post_model.dart';
import 'package:go_mobile_app/model/post_with_comment.dart';
import 'package:go_mobile_app/model/user_model.dart';
import 'package:go_mobile_app/utils/consts/result_const.dart';

import '../model/comment_model.dart';

class Api {
  final String baseUrl = 'http://192.168.2.190:8080/';
  final dio = Dio();

  Future<dynamic> createUser(User userModel) async {
    var userJson = userModel.toJson();
    var response = await dio.post(baseUrl + 'user/create', data: userJson);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.data);
      return data["result"];
    } else {
      return 'error';
    }
  }

  Future<dynamic> loginUser(User userModel) async {
    var userJson = userModel.toJson();
    var response = await dio.post(baseUrl + "user/login", data: userJson);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.data);
      return data["result"];
    } else {
      return "error";
    }
  }

  Future<List<PostWithComment>> fetchPost() async {
    List<PostWithComment> postList = [];
    var response = await dio.get(baseUrl + "post");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.data);
      data.forEach((v) {
        postList.add(PostWithComment.fromJson(v));
      });
    }
    return postList;
  }

  Future createCurrentUser(int id) async {
    var response = await dio.get(baseUrl + 'user/${id}');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.data);
      print(data);
      currentUser = User.fromJson(data);
    }
  }

  Future<String> createPost(
      {required String city,
      required String title,
      required String description}) async {
    Post postModel = Post(
        id: 0,
        userId: currentUser!.id,
        username: currentUser!.name,
        title: title,
        description: description,
        city: city);
    var postJson = postModel.toJson();
    var response = await dio.post(baseUrl + "post/create", data: postJson);
    if (response.statusCode == 200) {
      return ResultConst.resultSucces;
    } else {
      return ResultConst.resultError;
    }
  }

  Future<String> deletePost(int postId) async {
    var response = await dio.delete(baseUrl + 'post/delete/${postId}');
    if (response.statusCode == 200) {
      return ResultConst.resultSucces;
    } else {
      return ResultConst.resultError;
    }
  }

  Future<String> updatePost(Post postModel) async {
    var postJson = postModel.toJson();
    var response = await dio.put(baseUrl + 'post/update',data: postJson);
    if (response.statusCode == 200) {
      return ResultConst.resultSucces;
    } else {
      return ResultConst.resultError;
    }
  }

  Future<String> createComment(Comment commentModel) async {
    Map<String,dynamic> jsonComment = commentModel.toJson();
    var response = await dio.post(baseUrl  + "comment/create",data: jsonComment);

    if (response.statusCode == 200) {
      return ResultConst.resultSucces;
    } else {
      return ResultConst.resultError;
    }
  }

  Future<String> deleteComment(int commentId) async {

    var response = await dio.delete(baseUrl  + "comment/delete/${commentId}");

    if (response.statusCode == 200) {
      return ResultConst.resultSucces;
    } else {
      return ResultConst.resultError;
    }
  }
}
