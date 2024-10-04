import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxproject/controllers/taskBody.dart';
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
  List<String> list = <String>['Finished', 'Unfinished'];
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    controller.changeTab(0, MediaQuery.sizeOf(context).width);
    return Center(
      child: Obx(() => Scaffold(
        appBar: AppBar(
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
          backgroundColor: Colors.blue,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Text(controller.title.value),
              Expanded(
                child: AnimatedContainer(
                  height: 30,
                  margin: controller.margin.value,
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  duration: const Duration(milliseconds: 500),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xFFF1F1F1),
                  ),


                  //If App Bar is search
                  child: (controller.index.value == 1) ?
                  TextField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.search),
                      border: InputBorder.none,
                      isDense: true,
                      hintText: "Search"
                    ),
                    onChanged: (text) {
                      controller.changeSearch(text);
                    },
                  ) :


                  //If App Bar is filter
                  controller.index.value == 2 ?
                  DropdownButton<String>(
                    value: controller.filterValue.value,
                    isExpanded: true,
                    items: list.map<DropdownMenuItem<String>>((String value) => DropdownMenuItem(value: value, child: Text(value))).toList(),
                    underline: Container(
                      height: 0,
                      color: Color(0x00000000),
                    ),
                    onChanged: (String? value) {
                      if (value == "Finished") {
                        controller.filterValue.value = value!;
                        controller.isFinished.value = true;
                        return;
                      }
                      controller.filterValue.value = value!;
                      controller.isFinished.value = false;
                    },
                  ):null,
                )
              ),
            ],
          ),
        ),
        body: Obx(() => PageView(
          controller: pageController,
          onPageChanged: (newPage) => controller.changeTab(newPage, MediaQuery.sizeOf(context).width),
          children: [
            Homepage(),
            Homepage.search(),
            Homepage.task(
              isFinished: controller.isFinished.value,
              fullData: uncompleted,
            ),
            Homepage()
          ],
        )),
        bottomNavigationBar: Obx(() => BottomNavigationBar(
          currentIndex: controller.index.value,
          backgroundColor: Colors.blue,

          onTap: ((index) {
            controller.changeTab(index, MediaQuery.sizeOf(context).width);
            pageController.animateToPage(index,
              duration: const Duration(milliseconds: 750),
              curve: Curves.easeInOut
            );
          }),

          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.black),
              label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.search, color: Colors.black),
              label: 'Search'),
            BottomNavigationBarItem(
              icon: Icon(Icons.filter_alt, color: Colors.black),
              label: 'Filter'),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.black),
              label: 'Profile'),
          ],
        )),
      )),
    );
  }
}
