import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxproject/controllers/taskBody.dart';

class MyController extends GetxController{
  var index = 0.obs;
  var margin = EdgeInsets.fromLTRB(50000, 5, 5, 0).obs;
  var title = "Home".obs;
  var searchParam = "".obs;
  var isFinished = true.obs;
  var filterValue = "Finished".obs;

  Rx<List<taskBody>> datas = Rx<List<taskBody>>([
    taskBody(
      name: "Harry Potter",
      chapters: 198,
      tempProgress: 98,
      progress: "On The Way",
      description: "Harry Potter",
      addedDate: "9/23/2024",
      completed: false,
        icon: const Icon(Icons.auto_stories)
    ),
    taskBody(
      name: "School Math Book",
      chapters: 38,
      tempProgress: 36,
      progress: "Near Done",
      description: "Algebra",
      addedDate: "9/23/2024",
      completed: false,
        icon: const Icon(Icons.auto_stories)
    ),
    taskBody(
      name: "School History Book",
      chapters: 10,
      tempProgress: 0,
      progress: "Not Started",
      description: "Bad, just bad",
      addedDate: "9/23/2024",
      completed: false,
        icon: const Icon(Icons.auto_stories)
    ),
    taskBody(
      name: "School Physics Book",
      chapters: 40,
      tempProgress: 40,
      progress: "Near Done",
      description: "Aerospace 101",
      addedDate: "9/23/2024",
      completed: true,
        icon: const Icon(Icons.auto_stories)
    ),
    taskBody(
        name: "School Biology Book",
        chapters: 20,
        tempProgress: 20,
        progress: "Done",
        description: "Microbiology pt.1",
        addedDate: "9/23/2024",
        completed: true,
        icon: const Icon(Icons.auto_stories)
    ),
    taskBody(
      name: "School Chemist Book",
      chapters: 35,
      tempProgress: 32,
      progress: "Done",
      description: "How to Meth :3",
      addedDate: "9/23/2024",
      completed: false,
      icon: const Icon(Icons.auto_stories)
    ),
  ].obs);
  List<taskBody> get completed => getCompleted();
  List<taskBody> get uncompleted => getUncompleted();
  List<taskBody> get search => getSearch(searchParam.value);

  List<taskBody> getCompleted(){
    Rx<List<taskBody>> temp = Rx<List<taskBody>>([]);
    for(int i = 0; i < datas.value.length; i++){
      if(datas.value[i].tempProgress == datas.value[i].chapters){
        temp.value.add(datas.value[i]);
      }
    }
    return temp.value;
  }
  List<taskBody> getUncompleted(){
    Rx<List<taskBody>> temp = Rx<List<taskBody>>([]);
    for(int i = 0; i < datas.value.length; i++){
      if(datas.value[i].tempProgress != datas.value[i].chapters){
        temp.value.add(datas.value[i]);
      }
    }
    return temp.value;
  }
  List<taskBody> getSearch(String text){
    Rx<List<taskBody>> temp = Rx<List<taskBody>>([]);
    for(int i = 0; i < datas.value.length; i++){
      if(datas.value[i].name.toLowerCase().contains(text.toLowerCase())){
        temp.value.add(datas.value[i]);
      }
    }
    return temp.value;
  }

  void changeTab(int index, double width) {
    this.index.value = index;
    switch(index){
      case(0):
        title = "Home".obs;
        margin = EdgeInsets.fromLTRB(width, 5, 5, 0).obs;
        break;
      case(1):
        title = "Search".obs;
        margin = EdgeInsets.fromLTRB(10, 5, 5, 0).obs;
        break;
      case(2):
        title = "Filter".obs;
        margin = EdgeInsets.fromLTRB(10, 5, 5, 0).obs;
        break;
      case(3):
        title = "Profile".obs;
        margin = EdgeInsets.fromLTRB(width, 5, 5, 0).obs;
        break;
    }
  }
  void addProgress(int index){
    taskBody tempData = datas.value[index];
    if (tempData.tempProgress != tempData.chapters){
      tempData.completed = false;
      tempData.tempProgress ++;
    }
    if (tempData.tempProgress == tempData.chapters){
      tempData.completed = true;
    }
    else{
      tempData.completed = false;
    }
    datas.value[index] = tempData;
  }
  void removeProgress(int index){
    taskBody tempData = datas.value[index];
    if (tempData.tempProgress > 0){
      tempData.tempProgress --;
    }
    datas.value[index] = tempData;
  }
  void changeSearch(String text){
    searchParam.value = text;
  }
}