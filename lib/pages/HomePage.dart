import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxproject/controllers/controller.dart';
import 'package:getxproject/controllers/taskBody.dart';
import 'package:getxproject/widgets/progressBar.dart';
import 'package:getxproject/widgets/tile.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key, this.isFinished = false, this.isHome = true, this.isSearch = false}){
    controller.loadTasks();
  }
  Homepage.task({super.key, required this.isFinished, this.isHome = false, this.isSearch = false}){
    controller.loadTasks();
  }
  Homepage.search({super.key, this.isFinished = false, this.isHome = false, this.isSearch = true}){
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
                      child: myTile(
                        index: index,
                        name: data[index].name.toString(),
                        addedDate: data[index].addedDate,
                        onTap: (){
                          Get.toNamed("/tasks", arguments:  {'task' : data[index].name.toString()});
                        },
                        onRemove: (){
                          controller.removeTask(controller.datas[index]);
                          Navigator.pop(context);
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
