import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxproject/controllers/controller.dart';

class Profilepage extends StatelessWidget {
  Profilepage({super.key,});

  final MyController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            children: [
              Container(
                height: 150,
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(controller.backgroundPath.value.toString()), fit: BoxFit.fitHeight)
                ),
                foregroundDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(controller.imagePath.value),
                    fit: BoxFit.fitHeight
                  )
                ),
              )
            ],
          ),
        ),
    );
  }
}
