import 'package:get/get.dart';
import 'package:go_mobile_app/screens/comments_page/comments_page_binding.dart';
import 'package:go_mobile_app/screens/create_post_page/create_post_page.dart';
import 'package:go_mobile_app/screens/home_page/home_binding.dart';
import 'package:go_mobile_app/screens/home_page/home_page.dart';
import 'package:go_mobile_app/screens/login_register_page/login_register_page.dart';
import 'package:go_mobile_app/screens/comments_page/comments_page.dart';
import 'package:go_mobile_app/screens/update_post_page/update_post_binding.dart';
import 'package:go_mobile_app/screens/update_post_page/update_post_page.dart';

List<GetPage> getPages = [
  GetPage(
      name: LoginRegisterPage.loginRegisterPageRoute,
      page: () => LoginRegisterPage()),
  GetPage(
      name: HomePage.homePageRoute,
      page: () => HomePage(),
      binding: HomeBinding()),
  GetPage(
    name: CommentsPage.commentsPageRoute,
    page: () => CommentsPage(),
    binding: CommentPageBinding(),
  ),
  GetPage(
    name: CreatePostPage.createPostPageRoute,
    page: () => CreatePostPage(),
  ),
  GetPage(
    name: UpdatePostPage.updatePostPage,
    page: () => UpdatePostPage(),
    binding: UpdatePostBinding(),
  ),
];
