import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxproject/controllers/controller.dart';
import 'package:getxproject/controllers/taskBody.dart';
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
      if(controller.datas.value[i].name == task){
        return index;
      }
      index ++;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    int index = getIndex(Get.arguments['task'], controller.datas.value.length);
    return Obx((){
      return Scaffold(
        appBar: AppBar(
          title: Text(controller.datas.value[index].name),
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
                          text: controller.datas.value[index].name,
                          style: const TextStyle(color: Colors.lightBlueAccent,
                              fontSize: 24,
                              fontWeight:
                              FontWeight.w600
                          )
                      )),
                    ),
                    ProgressBar(count: controller.datas.value[index].tempProgress, len: controller.datas.value[index].chapters, high: true,),
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
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      begin: Alignment(0, -1),
                      end: Alignment(0, 0),
                      colors: <Color>[
                        Color.fromRGBO(185, 235, 255, 1.0),
                        Color.fromRGBO(145, 224, 255, 1.0),
                        Color.fromRGBO(85, 206, 255, 1.0),
                        Color.fromRGBO(85, 206, 255, 1.0),
                        Color.fromRGBO(85, 206, 255, 1.0),
                        Color.fromRGBO(85, 206, 255, 1.0),
                        Color.fromRGBO(85, 206, 255, 1.0),
                        Colors.lightBlueAccent,
                      ]
                    )
                  ),
                  child: Container(
                    margin: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xFFE6E6E6)
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
