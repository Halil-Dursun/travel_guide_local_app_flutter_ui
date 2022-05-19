import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_mobile_app/api/api.dart';
import 'package:go_mobile_app/api/current_user.dart';
import 'package:go_mobile_app/model/comment_model.dart';
import 'package:go_mobile_app/model/post_with_comment.dart';
import 'package:go_mobile_app/utils/widgets/get_snackbar.dart';

import '../../utils/consts/result_const.dart';

class CommentsPageController extends GetxController{
  PostWithComment post = Get.arguments;
  TextEditingController commentController = TextEditingController();
  late List<Comment> commentList;

  @override
  void onInit() {
    super.onInit();
    commentList = post.comments!.obs;
  }

  Future shareComment() async{
    Comment commentModel = Comment(id: 0, postId: post.post!.id, userId: currentUser!.id, username: currentUser!.name, comment: commentController.text);
    String result = await Api().createComment(commentModel);
      if (result == ResultConst.resultSucces) {
      commentList.add(commentModel);
      getSnackbar(content: 'Başarılı', description: 'Yorum yapıldı', color: Colors.green);

    } else {
      getSnackbar(content: 'Hata', description: 'Beklenmeyen bir hata oluştu.', color: Colors.red);
    }
  }

  Future deleteComment(int commentId,int index)async{
    String result = await Api().deleteComment(commentId);
    if (result == ResultConst.resultSucces) {
        commentList.removeAt(index);
      getSnackbar(content: 'Başarılı', description: 'Yorum silindi.', color: Colors.green);
    } else {
      getSnackbar(content: 'Hata', description: 'Beklenmeyen bir hata oluştu.', color: Colors.red);
    }

  }
}