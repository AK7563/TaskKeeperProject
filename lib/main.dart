import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxproject/MainPage.dart';
import 'package:getxproject/controllers/controller.dart';
import 'package:getxproject/pages/SplashScreen.dart';
import 'package:getxproject/pages/qrPage.dart';
import 'package:getxproject/pages/tasks.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(MyController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final MyController controller = Get.put(MyController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: "/splash",
      getPages: [
        GetPage(name: "/splash", page: ()=> const LoginPage()),
        GetPage(name: "/home", page: ()=> TransferLayout()),
        GetPage(name: "/tasks", page: () => const TaskPage()),
        GetPage(name: "/qr", page: () => const QRpage()),
      ],
    );
  }
}