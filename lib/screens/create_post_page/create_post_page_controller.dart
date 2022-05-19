import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_mobile_app/api/api.dart';
import 'package:go_mobile_app/utils/consts/result_const.dart';

import '../../utils/city_list.dart';

class CreatePostController extends GetxController {
  RxString dropDownValue = cityList[0].obs;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  Future<void> sendPost() async {
    String sendPostResult = 'error';
    sendPostResult = await Api().createPost(
        city: dropDownValue.value,
        title: titleController.text,
        description: descriptionController.text);
    if (sendPostResult == ResultConst.resultSucces) {
      Get.back();
      _getSnackbar(content: 'Başarılı', description: 'Gönderi başarı ile paylaşıldı.', color: Colors.green);
    } else {
      _getSnackbar(content: 'Hata', description: 'Beklenmeyen bir hata oluştu.', color: Colors.red);
    }
  }

  void _getSnackbar({required String content,required String description, required Color color}) {
    Get.snackbar(
      content,
      description,
      backgroundColor: color,
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.white,
    );
  }
}