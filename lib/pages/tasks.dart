import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxproject/controllers/controller.dart';
import 'package:getxproject/widgets/container.dart';
import 'package:getxproject/widgets/progressBar.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final MyController controller = Get.find();
  int getIndex(String task, int length){
    int index = 0;
    for(int i = 0; i < length; i ++){
      if(controller.datas[i].name == task){
        return index;
      }
      index ++;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    int index = getIndex(Get.arguments['task'], controller.datas.length);
    return Obx((){
      return Scaffold(
        appBar: AppBar(
          title: Text(controller.datas[index].name),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10,5,10,5),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(text: TextSpan(
                          text: controller.datas[index].name,
                          style: const TextStyle(color: Colors.lightBlueAccent,
                              fontSize: 24,
                              fontWeight:
                              FontWeight.w600
                          )
                      )),
                    ),
                    ProgressBar(count: controller.datas[index].tempProgress, len: controller.datas[index].chapters, high: true,),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: (){
                                controller.removeProgress(index);
                              },
                              child: Text("Previous Chapter")
                            ),
                          ),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: (){
                                controller.addProgress(index);
                              },
                              child: Text("Next Chapter")
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ),
              Expanded(
                child: myContainer(
                  child: Text(controller.datas[index].description)
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
