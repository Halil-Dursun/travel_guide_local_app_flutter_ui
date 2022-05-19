
import 'package:get/get.dart';
import 'package:go_mobile_app/screens/update_post_page/update_post_page_controller.dart';

class UpdatePostBinding implements Bindings{
  @override
  void dependencies() {
    Get.put<UpdatePostPageController>(UpdatePostPageController());
  }
}