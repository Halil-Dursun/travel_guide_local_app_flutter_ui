import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_mobile_app/api/api.dart';
import 'package:go_mobile_app/model/post_with_comment.dart';
import 'package:go_mobile_app/screens/login_register_page/login_register_page.dart';
import 'package:go_mobile_app/utils/consts/result_const.dart';
import 'package:go_mobile_app/utils/widgets/get_snackbar.dart';

class HomeController extends GetxController {
  RxList<PostWithComment> postList = <PostWithComment>[].obs;
  RxBool isFavorite = false.obs;
  final box = GetStorage();

  void changeFavorite() {
    isFavorite.value = !isFavorite.value;
  }

  @override
  void onInit() {
    getPost();
    super.onInit();
  }

  Future getPost() async {
    postList.value = await Api().fetchPost();
  }

  void logOut() {
    Get.offNamed(LoginRegisterPage.loginRegisterPageRoute);
    box.remove("id");
  }

  Future deletePost(PostWithComment post) async {
    String result = await Api().deletePost(post.post!.id);
    if (result == ResultConst.resultSucces) {
      postList.remove(post);
      getSnackbar(
          content: "Post Silindi!",
          description: 'Post silme işlemi başarı ile gerçekleşti.',
          color: Colors.green);
    }else{
      getSnackbar(content: 'Hata!', description: 'Beklenmeyen bir hata oluştu.', color: Colors.red);
    }
  }
}
