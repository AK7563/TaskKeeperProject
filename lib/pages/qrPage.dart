import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxproject/controllers/controller.dart';
import 'package:getxproject/widgets/container.dart';
import 'package:getxproject/widgets/progressBar.dart';

class QRpage extends StatefulWidget {
  const QRpage({super.key});

  @override
  State<QRpage> createState() => _QRPageState();
}

class _QRPageState extends State<QRpage> {
  final MyController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Qr Code'),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Image.asset('lib/assets/Nail_QR.png'),
      )
    );
  }
}
