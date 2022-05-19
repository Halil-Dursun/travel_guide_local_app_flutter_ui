

import 'package:get/get.dart';
import 'package:go_mobile_app/screens/create_post_page/create_post_page_controller.dart';
import 'package:go_mobile_app/screens/home_page/home_controller.dart';
import 'package:go_mobile_app/screens/login_register_page/login_register_controller.dart';
import 'package:go_mobile_app/screens/comments_page/comments_page_controller.dart';
import 'package:go_mobile_app/screens/update_post_page/update_post_page_controller.dart';

Future createControllers () async{
  Get.create(() => LoginRegisterController(),permanent: false);
  Get.create(() => HomeController(),permanent: false);
  Get.create(() => CommentsPageController(),permanent: false);
  Get.create(() => CreatePostController(),permanent: false);
  Get.create(() => UpdatePostPageController(),permanent: false);
}