import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxproject/controllers/controller.dart';
import 'package:getxproject/controllers/taskBody.dart';
import 'package:getxproject/widgets/progressBar.dart';

class Homepage extends StatelessWidget {
  Homepage({this.isFinished = false, this.isHome = true, this.isSearch = false}){
    controller.loadTasks();
  }
  Homepage.task({required this.isFinished, this.isHome = false, this.isSearch = false}){
    controller.loadTasks();
  }
  Homepage.search({this.isFinished = false, this.isHome = false, this.isSearch = true}){
    controller.loadTasks();
  }

  final bool isFinished;
  final bool isHome;
  final bool isSearch;
  final MyController controller = Get.find();
  List<taskBody> get data => loadDB();

  List<taskBody> loadDB() {
    if(isHome){
      return controller.datas;
    }
    if(isFinished){
      return controller.completed;
    }
    if(isSearch){
      return controller.search;
    }
    return controller.uncompleted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      child: ListTile(
                        leading: (Icon(Icons.auto_stories)),
                        title: Text(data[index].name.toString()),
                        titleTextStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.lightBlueAccent,
                            fontWeight: FontWeight.w600),
                        subtitle: Text("Added: ${data[index].addedDate}"),
                        dense: true,
                        onTap: () {
                          Get.toNamed("/tasks", arguments:  {'task' : data[index].name.toString()});
                        },
                      ),
                    ),
                    ProgressBar(
                      count: data[index].tempProgress,
                      len: data[index].chapters,
                      high: false,
                    )
                  ],
                ),
              );
            });
      }),
    );
  }
}
