import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_mobile_app/screens/home_page/home_page.dart';
import 'package:go_mobile_app/utils/widgets/get_snackbar.dart';

import '../../api/api.dart';
import '../../api/current_user.dart';
import '../../model/user_model.dart';

class LoginRegisterController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxBool isLogin = false.obs;
  RxBool visibility = false.obs;

  TextEditingController emailController = TextEditingController();

  TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final box = GetStorage();

  void changeVisibility() {
    visibility.value = !visibility.value;
  }

  void isLoginMakeFalse() {
    isLogin.value = false;
  }

  void isLoginMakeTrue() {
    isLogin.value = true;
  }

  login() async {
    if (formKey.currentState!.validate()) {
      User _userModel = User(
          id: 0,
          name: usernameController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text.trim());

      final api = Api();
      var result = await api.loginUser(_userModel);
      if (result == "no-account") {
        getSnackbar(content: "Hata!",description: 'Kayıt Bulunamadı', color: Colors.red);
      } else if (result == "wrong-password") {
        getSnackbar(content: 'Hata!',description: 'Hatalı şifre girişi', color: Colors.red);
      } else if (result is int) {
        await api.createCurrentUser(result);
        getSnackbar(
            content: "Giriş başarılı",description: 'Hoşgeldiniz ${currentUser!.name}', color: Colors.blue);
        box.write("id", result);
        Get.offAndToNamed(HomePage.homePageRoute);
      } else {
        getSnackbar(
            content: "Hata!",description: 'Beklenmeyen bir hata oluştu', color: Colors.red);
      }
    }
  }

  register() async {
    if (formKey.currentState!.validate()) {
      User _userModel = User(
          id: 0,
          name: usernameController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      final api = Api();
      dynamic result = await api.createUser(_userModel);
      if (result is int) {
        await api.createCurrentUser(result);
        getSnackbar(
        content: 'Kayıt Başarılı',description: "Kullanıcı kaydı oluştruldu. Hoşgeldiniz ${currentUser!.name}", color: Colors.blue);
        box.write("id", result);
        Get.offAndToNamed(HomePage.homePageRoute);
      } else if (result == "email-already-exist") {
        getSnackbar(
            content: 'Hata!',description: 'Bu e-postaya ait hesap bulunmakta.', color: Colors.red);
      } else {
        getSnackbar(
            content: 'Hata!',description: 'Kayıt başarısız bir hata oluştu', color: Colors.red);
      }
    }
  }

}
