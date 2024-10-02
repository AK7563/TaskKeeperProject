import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxproject/controllers/controller.dart';

class AppBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>MyController());
  }
}