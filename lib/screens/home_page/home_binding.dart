
import 'package:get/get.dart';
import 'package:go_mobile_app/screens/home_page/home_controller.dart';

class HomeBinding  implements Bindings{
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController());
  }

}