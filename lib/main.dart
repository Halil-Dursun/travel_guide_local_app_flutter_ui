import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_mobile_app/api/api.dart';
import 'package:go_mobile_app/management/get_controllers.dart';
import 'package:go_mobile_app/screens/home_page/home_page.dart';
import 'package:sizer/sizer.dart';
import 'management/routing/get_pages.dart';
import 'screens/login_register_page/login_register_page.dart';

void main() async{
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    createControllers();
    final box  = GetStorage();
    print(box.read("id"));
    if(box.read("id") != null) {
      int id = box.read("id");
      Api().createCurrentUser(id);
    }
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        getPages: getPages,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.black,
          ),
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(primary: Colors.blue)),
        ),
        home:  box.read("id") == null ? LoginRegisterPage() : HomePage(),
      );
    });
  }
}
