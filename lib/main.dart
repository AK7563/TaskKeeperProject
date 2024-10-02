import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxproject/controllers/taskBody.dart';
import 'package:getxproject/pages/TaskProgressPage.dart';
import 'package:getxproject/pages/HomePage.dart';
import 'package:getxproject/controllers/controller.dart';
import 'package:getxproject/pages/tasks.dart';

void main() {
  Get.put(MyController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: MainPage(),
      initialRoute: "/home",
      getPages: [
        GetPage(name: "/home", page: () => MainPage()),
        GetPage(name: "/tasks", page: () => const TaskPage()),
      ],
    );
  }
}

class MainPage extends StatelessWidget {
  final MyController controller = Get.find();
  late List<taskBody> uncompleted = controller.uncompleted;
  late List<taskBody> completed = controller.completed;
  PageController pageController = PageController(initialPage: 0);
  
  @override
  Widget build(BuildContext context) {
    controller.changeTab(0, MediaQuery.sizeOf(context).width);
    return Obx(()=> Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Text(controller.title.value),
            Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 750),
                  margin: controller.margin.value,
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xFFF1F1F1),
                  ),
                  child: TextField(
                    onChanged: (text){
                      controller.changeSearch(text);
                    },
                    decoration: InputDecoration(
                        icon: Icon(Icons.search),
                        hintText: "Search",
                        border: InputBorder.none,
                        isDense: true
                    ),
                  ),
                )
            ),
            if(controller.index.value == 1 || controller.index.value == 2 || controller.index.value == 3)...{

            }
          ],
        ),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        backgroundColor: Colors.blue,
      ),
      body: Obx(() => PageView(
        controller: pageController,
        onPageChanged: (newPage){
          controller.changeTab(newPage, MediaQuery.sizeOf(context).width);
        },
        children: [
          Homepage(),
          Homepage.search(),
          Homepage.task(isFinished: false, fullData: uncompleted,),
          Homepage.task(isFinished: true, fullData: completed,),
          Homepage()
        ],
      )),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        backgroundColor: Colors.blue,
        currentIndex: controller.index.value,
        onTap: ((index){
          controller.changeTab(index, MediaQuery.sizeOf(context).width);
          pageController.animateToPage(index, duration: const Duration(milliseconds: 750), curve:Curves.easeInOut);
        }),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.black), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search, color: Colors.black), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.filter_alt, color: Colors.black), label: 'Filter'),
          BottomNavigationBarItem(icon: Icon(Icons.mark_email_read, color: Colors.black), label: 'Finished'),
          BottomNavigationBarItem(icon: Icon(Icons.person, color: Colors.black), label: 'Profile'),
        ],
      )),
    ));
  }
}