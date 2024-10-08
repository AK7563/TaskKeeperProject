import 'package:flutter/material.dart';

class taskBody{
  taskBody({
    required this.id,
    required this.name,
    required this.chapters,
    required this.tempProgress,
    required this.progress,
    required this.description,
    required this.addedDate,
  });

  int id;
  String name;
  int chapters;
  int tempProgress;
  String progress;
  String description;
  String addedDate;

  Map<String, dynamic> toMap(){
    return{
      'id' : id,
      'name' : '${name.toString()}',
      'chapters' : chapters,
      'tempProgress' : tempProgress,
      'progress' : '${progress.toString()}',
      'description' : '${description.toString()}',
      'addedDate' : '${addedDate.toString()}'
    };
  }

  factory taskBody.fromMap(Map<String, dynamic> map){
    return taskBody(
      id:  map['id'],
      name: map['name'],
      chapters: map['chapters'],
      tempProgress: map['tempProgress'],
      progress: map['progress'],
      description: map['description'],
      addedDate: map['addedDate'],
    );
  }
}