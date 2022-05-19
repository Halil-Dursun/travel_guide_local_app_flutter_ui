import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:go_mobile_app/screens/create_post_page/create_post_page_controller.dart';
import 'package:go_mobile_app/utils/city_list.dart';
import 'package:go_mobile_app/utils/consts/create_post_page_strings.dart';
import 'package:sizer/sizer.dart';

class CreatePostPage extends GetWidget<CreatePostController> {
  CreatePostPage({Key? key}) : super(key: key);

  static const String createPostPageRoute =
      "/screens/create_post_page/create_post_page.dart";
  final CreatePostPageStrings _createPostPageStrings = CreatePostPageStrings();

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        appBar: AppBar(
          title: Text(_createPostPageStrings.appBarTitle,
              style: Theme.of(context).textTheme.headline4?.copyWith(
                    fontSize: 25.sp,
                  )),
        ),
        body: SingleChildScrollView(child: _buildBody(context)),
      );
    });
  }

  Center _buildBody(context) {
    return Center(
      child: Form(
        key: controller.formKey,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 8.0,vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _postTitle(context),
              _dropdownButton(),
              _titleTextFormField(),
              SizedBox(
                height: 1.h,
              ),
              _descriptionTextFormField(),
              SizedBox(
                height: 1.h,
              ),
              SizedBox(height: 8.h,child: _postButton())
            ],
          ),
        ),
      ),
    );
  }

  Padding _postTitle(context) {
    return Padding(
              padding:  EdgeInsets.symmetric(vertical:2.h),
              child: Text(_createPostPageStrings.createPostText,textAlign: TextAlign.center,style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.blue,fontSize: 40.sp),),
            );
  }

  ElevatedButton _postButton() => ElevatedButton(
        onPressed: () {
          controller.sendPost();
        },
        child: Text(_createPostPageStrings.createPostText),
        style: ElevatedButton.styleFrom(primary: Colors.blue),
      );

  TextFormField _descriptionTextFormField() {
    return TextFormField(
      validator: (value) {
        if (value != null && value.length <= 1) {
          return null;
        } else {
          return "Açıkklama kısmı boş bırakılamaz.";
        }
      },
      controller: controller.descriptionController,
      maxLines: 5,
      decoration: InputDecoration(
          border: const OutlineInputBorder(), hintText: _createPostPageStrings.postDescriptionText),
    );
  }

  TextFormField _titleTextFormField() {
    return TextFormField(
      validator: (value) {
        if (value != null && value.length <= 1) {
          return null;
        } else {
          return "Başlık kısmı boş bırakılamaz.";
        }
      },
      controller: controller.titleController,
      decoration: InputDecoration(
          border: const OutlineInputBorder(), hintText: _createPostPageStrings.postTitleText),
    );
  }

  _dropdownButton() {
    return Obx(() => DropdownButton<String>(
          isExpanded: true,
          value: controller.dropDownValue.value,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: const TextStyle(color: Colors.blue),
          underline: Container(
            height: 2,
            color: Colors.blue,
          ),
          onChanged: (String? newValue) {
            controller.dropDownValue.value = newValue!;
            print(newValue);
          },
          items: cityList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ));
  }
}
