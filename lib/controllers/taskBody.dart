import 'package:flutter/material.dart';

class taskBody{
  taskBody({
    required this.name,
    required this.chapters,
    required this.tempProgress,
    @required this.progress,
    @required this.description,
    @required this.addedDate,
    @required this.completed,
    @required this.icon,
  });

  final String name;
  final int chapters;
  int tempProgress;
  final String? progress;
  final String? description;
  final String? addedDate;
  bool? completed;
  final Icon? icon;

  void addProgress(){
    tempProgress += 1;
  }
  void removeProgress(){
    tempProgress -= 1;
  }
}