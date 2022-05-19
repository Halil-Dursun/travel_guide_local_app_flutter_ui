

import 'package:get/get.dart';
import 'package:go_mobile_app/screens/comments_page/comments_page_controller.dart';

class CommentPageBinding implements Bindings{
  @override
  void dependencies() {
    Get.put<CommentsPageController>(CommentsPageController());
  }

}