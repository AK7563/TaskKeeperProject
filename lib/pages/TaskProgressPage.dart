import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxproject/controllers/controller.dart';
import 'package:getxproject/controllers/taskBody.dart';
import 'package:getxproject/widgets/progressBar.dart';

class TaskProgressPage extends StatelessWidget {
  TaskProgressPage({required this.isFinished, this.isHome = false});
  TaskProgressPage.Home({this.isFinished = false, this.isHome = true});

  final bool isFinished;
  final bool isHome;
  final MyController controller = Get.find();
  List<taskBody> get data =>
      isHome ? controller.datas.value : isFinished ? controller.completed : controller.uncompleted;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Books"),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        backgroundColor: Colors.blue,
      ),
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
                        leading: (data[index].icon),
                        title: Text(data[index].name.toString()),
                        titleTextStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.lightBlueAccent,
                            fontWeight: FontWeight.w600),
                        subtitle: Text("Added: ${data[index].addedDate}"),
                        dense: true,
                        onTap: () {
                          Get.toNamed("/tasks/" + data[index].name);
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
