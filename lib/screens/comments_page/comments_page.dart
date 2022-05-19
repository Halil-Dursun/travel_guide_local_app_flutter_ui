import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_mobile_app/api/current_user.dart';
import 'package:go_mobile_app/screens/comments_page/comments_page_controller.dart';
import 'package:go_mobile_app/utils/consts/comment_page_strings.dart';

import 'package:sizer/sizer.dart';

class CommentsPage extends GetWidget<CommentsPageController> {
  CommentsPage({
    Key? key,
  }) : super(key: key);
  static const String commentsPageRoute =
      "/screens/post_detail_page/post_detail_page";

  final CommentPageStrings _commentPageStrings = CommentPageStrings();

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            _commentPageStrings.appBarTitle,
            style: Theme.of(context)
                .textTheme
                .headline4
                ?.copyWith(color: Colors.black),
          ),
        ),
        body: _body(),
      );
    });
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _commetList(),
          _sendComment(),
        ],
      ),
    );
  }

  Widget _commetList() {
    return Obx(()=> controller.commentList.isEmpty
        ?  Text(_commentPageStrings.noCommentText)
        : SizedBox(
          //height: Get.height * .7,
          width: Get.width,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              itemCount: controller.commentList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                            const Icon(Icons.person),
                            const SizedBox(width: 5,),
                            Text(controller.commentList[index].username,style: Theme.of(context).textTheme.headline5?.copyWith(fontSize: 15.sp),),
                            ],),
                            if (controller.commentList[index].userId == currentUser!.id)
                            IconButton(onPressed: (){
                              controller.deleteComment(controller.post.comments![index].id,index);
                            }, icon: const Icon(Icons.delete,color: Colors.red,)),
                          ],
                        ),
                        subtitle: Text(
                          controller.commentList[index].comment,
                          style: Theme.of(context).textTheme.headline5?.copyWith(color: Colors.blueGrey,fontSize: 12.sp),
                        ),),
                        const Divider(color: Colors.black,),
                  ],
                );
              }),
        ));
  }

  Widget _sendComment() {
    return TextFormField(
      controller: controller.commentController,
      decoration: InputDecoration(
        hintText: _commentPageStrings.textFieldHintText,
        suffixIcon: OutlinedButton(onPressed: (){
          controller.shareComment();
        }, child: const Icon(Icons.send),),
      ),
    );
  }
}
