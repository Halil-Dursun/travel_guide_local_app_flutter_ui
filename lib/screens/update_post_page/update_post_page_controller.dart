import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_mobile_app/api/api.dart';
import 'package:go_mobile_app/model/post_model.dart';
import 'package:go_mobile_app/utils/widgets/get_snackbar.dart';

import '../../model/post_with_comment.dart';
import '../../utils/city_list.dart';
import '../../utils/consts/result_const.dart';

class UpdatePostPageController extends GetxController {
  PostWithComment post = Get.arguments;
  late RxString dropDownValue;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void onInit() {
    super.onInit();
    titleController.text = post.post!.title;
    descriptionController.text = post.post!.description;
    dropDownValue = cityList[cityList.indexOf(post.post!.city)].obs;
  }

  Future updatePost() async {
    Post postModel = Post(
        id: post.post!.id,
        userId: post.post!.userId,
        username: post.post!.username,
        title: titleController.text,
        description: descriptionController.text,
        city: dropDownValue.value);
    String result = await Api().updatePost(postModel);

    if (result == ResultConst.resultSucces) {
      Get.back();
      getSnackbar(
          content: 'Başarılı',
          description: 'Gönderi başarı ile güncellendi.',
          color: Colors.green);
    } else {
      getSnackbar(
          content: 'Hata',
          description: 'Beklenmeyen bir hata oluştu.',
          color: Colors.red);
    }
  }
}
