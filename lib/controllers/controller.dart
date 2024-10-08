import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxproject/controllers/taskBody.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyController extends GetxController{
  var index = 0.obs;
  var margin = EdgeInsets.fromLTRB(50000, 5, 5, 0).obs;
  var title = "Home".obs;
  var searchParam = "".obs;
  var isFinished = true.obs;
  var filterValue = "Finished".obs;
  var imagePath = "https://i1.sndcdn.com/avatars-j3SRoUzaLbJxPNDz-38FaEg-t500x500.jpg".obs;
  var backgroundPath = "https://i1.sndcdn.com/visuals-001422203943-o29q4e-t2480x520.jpg".obs;

  static Database? _db;

  // list data yang digunakan untuk menampun hasil database, .obs diguanakan di UI
  var datas = <taskBody>[].obs;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initDB();
    }
    return _db;
  }

  Future<Database> initDB() async {
    print('creating db');
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'task_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE tasks(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            chapters INTEGER,
            tempProgress INTEGER,
            progress TEXT,
            description TEXT,
            addedDate TEXT
          )
        ''');
      },
    );
  }

  // Insert Task
  Future<int> addTask(taskBody task) async {
    print('adding task');
    var dbClient = await db;
    int result = await dbClient!.insert('tasks', task.toMap());
    loadTasks();
    return result;
  }

  // Retrieve Tasks
  Future<void> loadTasks() async {
    print('loading task');
    var dbClient = await db;
    List<Map<String, dynamic>> queryResult = await dbClient!.query('tasks');
    datas.assignAll(queryResult.map((data) => taskBody.fromMap(data)).toList());
    if(datas.length == 0){
      datas.addAll({
        taskBody(
          id: 1,
          name: "Harry Potter",
          chapters: 198,
          tempProgress: 98,
          progress: "On The Way",
          description: "Harry Potter",
          addedDate: "9/23/2024",
        ),
        taskBody(
          id: 2,
          name: "School Math Book",
          chapters: 38,
          tempProgress: 36,
          progress: "Near Done",
          description: "Algebra",
          addedDate: "9/23/2024",
        ),
        taskBody(
          id: 3,
          name: "School History Book",
          chapters: 10,
          tempProgress: 0,
          progress: "Not Started",
          description: "Bad, just bad",
          addedDate: "9/23/2024",
        ),
        taskBody(
          id: 4,
          name: "School Physics Book",
          chapters: 40,
          tempProgress: 40,
          progress: "Near Done",
          description: "Aerospace 101",
          addedDate: "9/23/2024",
        ),
        taskBody(
          id: 5,
          name: "School Biology Book",
          chapters: 20,
          tempProgress: 20,
          progress: "Done",
          description: "Microbiology pt.1",
          addedDate: "9/23/2024",
        ),
        taskBody(
          id: 6,
          name: "School Chemist Book",
          chapters: 35,
          tempProgress: 32,
          progress: "Done",
          description: "How to Meth :3",
          addedDate: "9/23/2024",
        ),
      });
      for(int i = 0; i < datas.length; i++){
        addTask(datas[i]);
      }
    }
  }

  Future<int> updateTask(taskBody task) async {
    print('updating task');
    var dbClient = await db;
    int result = await dbClient!.update(
      'tasks',
      task.toMap(),
      where: 'id = ${task.id}'
    );
    loadTasks();
    return result;
  }



  List<taskBody> get completed => getCompleted();

  List<taskBody> get uncompleted => getUncompleted();

  List<taskBody> get search => getSearch(searchParam.value);



  List<taskBody> getCompleted(){
    List<taskBody> _datas = datas;
    Rx<List<taskBody>> temp = Rx<List<taskBody>>([]);
    for(int i = 0; i < _datas.length; i++){
      if(_datas[i].tempProgress == _datas[i].chapters){
        temp.value.add(_datas[i]);
      }
    }
    return temp.value;
  }

  List<taskBody> getUncompleted(){
    List<taskBody> _datas = datas;
    Rx<List<taskBody>> temp = Rx<List<taskBody>>([]);
    for(int i = 0; i < _datas.length; i++){
      if(_datas[i].tempProgress != _datas[i].chapters){
        temp.value.add(_datas[i]);
      }
    }
    return temp.value;
  }

  List<taskBody> getSearch(String text) {
    List<taskBody> _datas = datas;
    Rx<List<taskBody>> temp = Rx<List<taskBody>>([]);
    for(int i = 0; i < _datas.length; i++){
      if(_datas[i].name.toLowerCase().contains(text.toLowerCase())){
        temp.value.add(_datas[i]);
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

  Future<void> addProgress(int index) async {
    List<taskBody> _datas = await datas;
    taskBody tempData = _datas[index];
    if (tempData.tempProgress != tempData.chapters){
      tempData.tempProgress ++;
    }
    await updateTask(tempData);
    _datas[index] = tempData;
  }

  Future<void> removeProgress(int index) async {
    List<taskBody> _datas = await datas;
    taskBody tempData = _datas[index];
    if (tempData.tempProgress > 0){
      tempData.tempProgress --;
    }
    await updateTask(tempData);
    _datas[index] = tempData;
  }

  void changeSearch(String text){
    searchParam.value = text;
  }
}