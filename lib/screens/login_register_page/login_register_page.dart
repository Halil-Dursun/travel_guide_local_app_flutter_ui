import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_mobile_app/screens/login_register_page/login_register_controller.dart';
import 'package:go_mobile_app/utils/consts/login_register_strings.dart';
import 'package:sizer/sizer.dart';
import '../../utils/widgets/slider_images.dart';

class LoginRegisterPage extends GetWidget<LoginRegisterController> {
  LoginRegisterPage({Key? key}) : super(key: key);
  final LoginRegisterStrings _loginRegisterStrings = LoginRegisterStrings();
  static const String loginRegisterPageRoute =
      '/screens/login_register_page/login_register_page';

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Scaffold(
          ///resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(
              _loginRegisterStrings.appBarTitle,
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  ?.copyWith(color: Colors.black),
            ),
          ),
          body: Obx(
            () => SingleChildScrollView(child: _body(context)),
          ),
        );
      },
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: const _LoginRegisterPadding.symmetricHorizantal(),
      child: Column(
        children: [
          Container(height: 20.h, child: SliderImages()),
          SizedBox(
            height: 1.h,
          ),
          Container(
            child: Column(
              children: [
                controller.isLogin.value == true
                    ? Text(_loginRegisterStrings.loginTitle,
                        style: Theme.of(context).textTheme.headline5?.copyWith(color: Colors.blueGrey,fontSize: 25.sp),)
                    : Text(_loginRegisterStrings.registerTitle,
                        style: Theme.of(context).textTheme.headline5?.copyWith(color: Colors.blueGrey,fontSize: 25.sp),),
                SizedBox(
                  height: 1.h,
                ),
                Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const _LoginRegisterPadding.symmetricVertical(),
                        child: _emailTextFormField(),
                      ),
                      if (controller.isLogin.value == false)
                        Padding(
                          padding:
                              const _LoginRegisterPadding.symmetricVertical(),
                          child: _usernameTextFormField(),
                        ),
                      Padding(
                        padding:
                            const _LoginRegisterPadding.symmetricVertical(),
                        child: passwordTextFormField(),
                      ),
                      Padding(
                        padding:
                            const _LoginRegisterPadding.symmetricVertical(),
                        child: _loginRegisterButton(context),
                      ),
                    ],
                  ),
                ),
                controller.isLogin.value
                    ? TextButton(
                        onPressed: () {
                          controller.isLoginMakeFalse();
                        },
                        child: Text(_loginRegisterStrings.haveNotAnAccount),
                      )
                    : TextButton(
                        onPressed: () {
                          controller.isLoginMakeTrue();
                        },
                        child: Text(_loginRegisterStrings.haveAnAccount),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SizedBox _loginRegisterButton(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 7.h,
      child: ElevatedButton(
        onPressed: controller.isLogin.value
            ? () {
                controller.login();
              }
            : () {
                controller.register();
              },
        child: controller.isLogin.value
            ? Text(_loginRegisterStrings.loginTitle)
            : Text(
                _loginRegisterStrings.registerTitle,
              ),
      ),
    );
  }

  Widget passwordTextFormField() {
    return TextFormField(
      obscureText: controller.visibility.value ? false : true,
      validator: (value) {
        if (value == null) {
          return _loginRegisterStrings.passwordNotNullError;
        } else if (value.length >= 8) {
          return null;
        } else {
          return _loginRegisterStrings.passwordLenghtError;
        }
      },
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.visiblePassword,
      controller: controller.passwordController,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.key),
          suffixIcon: controller.visibility.value
              ? IconButton(
                  onPressed: () {
                    controller.changeVisibility();
                  },
                  icon: const Icon(Icons.visibility_rounded),
                )
              : IconButton(
                  onPressed: () {
                    controller.changeVisibility();
                  },
                  icon: const Icon(
                    Icons.visibility_off_rounded,
                  ),
                ),
          hintText: _loginRegisterStrings.passwordHintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          )),
    );
  }

  Widget _usernameTextFormField() {
    return TextFormField(
      validator: (value) {
        if (value == null) {
          return _loginRegisterStrings.usernameNotNullError;
        } else if (value.length >= 5) {
          return null;
        } else {
          return _loginRegisterStrings.usernameLengthError;
        }
      },
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      controller: controller.usernameController,
      decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.person,
          ),
          hintText: _loginRegisterStrings.usernameHintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          )),
    );
  }

  Widget _emailTextFormField() {
    return TextFormField(
      validator: (value) {
        if (value == null) {
          return _loginRegisterStrings.emailNotNullError;
        } else if (value.length > 8 &&
            value.contains('@') &&
            value.contains('.')) {
          return null;
        } else {
          return _loginRegisterStrings.badlyEmailFormat;
        }
      },
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      controller: controller.emailController,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail),
          hintText: _loginRegisterStrings.emailHintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          )),
    );
  }
}

class _LoginRegisterPadding extends EdgeInsets {
  const _LoginRegisterPadding.symmetricVertical()
      : super.symmetric(
          vertical: 4.0,
        );
  const _LoginRegisterPadding.symmetricHorizantal()
      : super.symmetric(
          horizontal: 8.0,
        );
}
