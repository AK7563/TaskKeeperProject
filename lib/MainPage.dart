import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getxproject/controllers/taskBody.dart';
import 'package:getxproject/pages/HomePage.dart';
import 'package:getxproject/controllers/controller.dart';
import 'package:getxproject/pages/ProfilePage.dart';
import 'package:getxproject/widgets/container.dart';

class TransferLayout extends StatelessWidget {
  TransferLayout({super.key});

  final MyController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint){
      controller.updateScreenWidth(constraint.maxWidth);
      if(controller.isMobile){
        return MainPage.mobile();
      }
      return MainPage.tablet();
    });
  }
}

class MainPage extends StatelessWidget {
  final MyController controller = Get.find();
  final List<String> list = <String>['Finished', 'Unfinished'];
  final PageController pageController = PageController(initialPage: 0);
  final titleAdd = TextEditingController();
  final chaptersAdd = TextEditingController();
  final progressAdd = TextEditingController();
  final descriptionAdd = TextEditingController();

  MainPage({super.key, this.isMobile = true});
  MainPage.mobile({super.key, this.isMobile = true});
  MainPage.tablet({super.key, this.isMobile = false});

  bool isMobile;
  DateTime get date => DateTime.now();

  @override
  Widget build(BuildContext context) {
    controller.changeTab(0, MediaQuery.sizeOf(context).width);
    controller.textSize = (15.0 * MediaQuery.sizeOf(context).height/700).obs;
    return Center(
      child: Obx(() => Scaffold(

        appBar: AppBar(
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
          backgroundColor: Colors.blue,
          automaticallyImplyLeading: controller.isMobile ? false : true,
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

                    //If App Bar is search or filter
                    child: tabBar(),
                  )
              ),
            ],
          ),
        ),

        body: PageView(
          controller: pageController,
          onPageChanged: (newPage){
            controller.changeTab(newPage, MediaQuery.sizeOf(context).width);
          },
          children: [
            Homepage(),
            Homepage.search(),
            Homepage.task(
                isFinished: controller.isFinished.value
            ),
            ProfilePage()
          ],
        ),

        drawer: !isMobile? Drawer(
          child: ListView(
            padding: const EdgeInsets.all(0.0),
            children: [
              DrawerHeader(
                padding: const EdgeInsets.all(0.0),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.zero,
                        topRight: Radius.zero,
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)
                    ),
                    image: DecorationImage(image: NetworkImage(controller.backgroundPath.value.toString()), fit: BoxFit.cover)
                ),
                child: SizedBox(
                    height: 200,
                    width: MediaQuery.sizeOf(context).width,
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(image: NetworkImage(controller.imagePath.value), fit: BoxFit.fitHeight)
                            ),
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                            child: const Text('AK7563', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold))
                        )
                      ],
                    )
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home, color: Colors.black),
                title: const Text('Home'),
                onTap: (){
                  changePage(0, context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.search, color: Colors.black),
                title: const Text('Search'),
                onTap: (){
                  changePage(1, context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.filter_alt, color: Colors.black),
                title: const Text('Filter'),
                onTap: (){
                  changePage(2, context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.person, color: Colors.black),
                title: const Text('Profile'),
                onTap: (){
                  changePage(3, context);
                },
              )
            ],
          ),
        ) : null,

        bottomNavigationBar: isMobile? BottomNavigationBar(
          currentIndex: controller.index.value,
          backgroundColor: Colors.blue,

          onTap: ((index) {
            changePage(index, context);
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
        ) : null,

        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: (){
            showDialog(
                context: context,
                builder: (context)=>AlertDialog(
                  title: const Text('Add To List'),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Title', style: TextStyle(fontSize: 20))
                        ),
                        myContainer(child: TextField(
                          controller: titleAdd,
                          maxLines: 1,
                          style: const TextStyle(fontSize: 15),
                          decoration: const InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintText: 'Title',
                          ),
                        )),

                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Total Chapters', style: TextStyle(fontSize: 20))
                          ),
                        ),
                        myContainer(child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                          controller: chaptersAdd,
                          maxLines: 1,
                          style: const TextStyle(fontSize: 15),
                          decoration: const InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintText: 'Total Chapters',
                          ),
                        )),

                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Progress', style: TextStyle(fontSize: 20))
                          ),
                        ),
                        myContainer(child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                          controller: progressAdd,
                          maxLines: 1,
                          style: const TextStyle(fontSize: 15),
                          decoration: const InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintText: 'Progress',
                          ),
                        )),

                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Description', style: TextStyle(fontSize: 20))
                          ),
                        ),
                        myContainer(child: TextField(
                          controller: descriptionAdd,
                          style: const TextStyle(fontSize: 15),
                          decoration: const InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintText: 'Description',
                          ),
                        )),
                      ],
                    ),
                  ),

                  actions: [
                    TextButton(
                        onPressed: (){
                          titleAdd.clear();
                          chaptersAdd.clear();
                          progressAdd.clear();
                          descriptionAdd.clear();
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel')
                    ),
                    TextButton(
                        onPressed: () {
                          taskBody task = taskBody(
                              id: controller.datas.length + 1,
                              name: titleAdd.text,
                              chapters: int.parse(chaptersAdd.text),
                              tempProgress: int.parse(progressAdd.text),
                              progress: 'On going',
                              description: descriptionAdd.text,
                              addedDate: '${date.day}/${date.month}/${date.year}'
                          );
                          controller.addTask(task);
                          titleAdd.clear();
                          chaptersAdd.clear();
                          progressAdd.clear();
                          descriptionAdd.clear();
                          Navigator.pop(context);
                        },
                        child: const Text('Add')
                    )
                  ],
                )
            );
          },
          child: const Icon(Icons.add, color: Colors.white),
        ),
      )),
    );
  }
  void changePage(int index, BuildContext context){
    controller.changeTab(index, MediaQuery.sizeOf(context).width);
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 750),
        curve: Curves.easeInOut
    );
  }
  Widget? tabBar(){
    if(controller.index.value == 1){
      return TextField(
        decoration: const InputDecoration(
            icon: Icon(Icons.search),
            border: InputBorder.none,
            isDense: true,
            hintText: "Search"
        ),
        onChanged: (text) {
          controller.changeSearch(text);
        },
      );
    }
    else if(controller.index.value == 2){
      return DropdownButton<String>(
        value: controller.filterValue.value,
        isExpanded: true,
        items: list.map<DropdownMenuItem<String>>((String value) => DropdownMenuItem(value: value, child: Text(value))).toList(),
        underline: Container(
          height: 0,
          color: const Color(0x00000000),
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
      );
    }
    return null;
  }
}