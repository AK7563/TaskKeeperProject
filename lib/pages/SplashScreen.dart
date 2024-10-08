import 'dart:ffi';

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.auto_stories, color: Colors.black, size: MediaQuery.sizeOf(context).width / 5,),
            Text("Welcome To E-Lib", style: TextStyle(fontSize: 30),),
            Container(
              width: MediaQuery.sizeOf(context).width - 100,
              child: Text("The application to help you keep up with your tasks", textAlign: TextAlign.center,),
            ),
          ],
        ),
      ),
    );
  }
}
