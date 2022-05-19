import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_mobile_app/screens/comments_page/comments_page.dart';
import 'package:go_mobile_app/screens/create_post_page/create_post_page.dart';
import 'package:go_mobile_app/screens/home_page/home_controller.dart';
import 'package:go_mobile_app/screens/update_post_page/update_post_page.dart';
import 'package:go_mobile_app/utils/consts/home_page_strings.dart';
import 'package:go_mobile_app/utils/consts/images.dart';
import 'package:sizer/sizer.dart';

import '../../api/current_user.dart';

class HomePage extends GetWidget<HomeController> {
  final HomePageStrings _homePageStrings = HomePageStrings();
  static const String homePageRoute = '/screens/home_page/home_page';

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        drawer: _homePageDrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(CreatePostPage.createPostPageRoute);
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          title: Text(_homePageStrings.homePageTitle,
              style: Theme.of(context).textTheme.headline4),
        ),
        body: Obx(
          () => (controller.postList.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : _postList()),
        ),
      );
    });
  }

  ListView _postList() {
    return ListView.builder(
        itemCount: controller.postList.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return _post(index, context);
        });
  }

  Container _post(index, context) {
    return Container(
      margin: EdgeInsets.all(1.h),
      padding: EdgeInsets.all(.5.h),
      constraints: BoxConstraints(minHeight: 40.h),
      width: Get.height,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: _postDesign(index, context),
    );
  }

  Column _postDesign(index, context) {
    return Column(
      children: [
        _personInfo(index, context),
        const Divider(
          color: Colors.black,
        ),
        Stack(
          children: [
            _postImage(index),
            Positioned(
              child: _postCityName(index, context),
              right: 2.w,
            ),
            if (currentUser!.id == controller.postList[index].post!.userId)
              Positioned(
                child: _deleteUpdateRow(context, index),
                left: 2.w,
              ),
          ],
        ),
        _postDetail(index, context),
      ],
    );
  }

  Row _deleteUpdateRow(context, index) {
    return Row(
      children: [
        _deletePostButton(index, context),
        SizedBox(width: 1.w,),
        OutlinedButton(
          onPressed: () {
            Get.toNamed(UpdatePostPage.updatePostPage,arguments: controller.postList[index]);
          },
          child: Text(
            _homePageStrings.fixButtonText,
            style: Theme.of(context)
                .textTheme
                .subtitle2
                ?.copyWith(color: Colors.white),
          ),
          style: OutlinedButton.styleFrom(backgroundColor: Colors.blueGrey),
        ),
      ],
    );
  }

  OutlinedButton _deletePostButton(index, context) {
    return OutlinedButton(
          onPressed: () {
            controller.deletePost(controller.postList[index]);
          },
          child: Text(
            _homePageStrings.deleteButtonText,
            style: Theme.of(context)
                .textTheme
                .subtitle2
                ?.copyWith(color: Colors.white),
          ),
          style: OutlinedButton.styleFrom(backgroundColor: Colors.red),
        );
  }

  Text _postCityName(index, context) => Text(
        controller.postList[index].post!.city,
        style: Theme.of(context).textTheme.headline4,
      );

  Row _personInfo(index, context) {
    return Row(
      children: [
        const Icon(Icons.person),
        const SizedBox(
          width: 5,
        ),
        Text(
          controller.postList[index].post!.username,
          style:
              Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: 15.sp),
        ),
      ],
    );
  }

  Container _postImage(index) {
    return Container(
      height: 20.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(
          image: AssetImage(ImagesList().imagePathList[0]),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Column _postDetail(index, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          controller.postList[index].post!.title,
          style: Theme.of(context)
              .textTheme
              .headline5
              ?.copyWith(color: Colors.blueGrey),
        ),
        Text(
          controller.postList[index].post!.description,
          style:
              Theme.of(context).textTheme.headline5?.copyWith(fontSize: 13.sp),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                Get.toNamed(CommentsPage.commentsPageRoute,
                    arguments: controller.postList[index]);
              },
              child: Text(
                '${controller.postList[index].comments!.length} yorumu gör...',
              ),
            ),
            Obx(
              () => IconButton(
                onPressed: controller.changeFavorite,
                icon: Icon(
                  Icons.favorite,
                  color:
                      controller.isFavorite.value ? Colors.pink : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Drawer _homePageDrawer() {
    return Drawer(
      child: ListView(
        children: [
          ListTile(title: Text(_homePageStrings.logOutButtonText), onTap: () => controller.logOut()),
        ],
      ),
    );
  }
}
