import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxproject/widgets/container.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.auto_stories, color: Colors.black, size: MediaQuery.sizeOf(context).width / 5,),
              const Text("Welcome To E-Lib", style: TextStyle(fontSize: 30),),
              Container(
                width: MediaQuery.sizeOf(context).width - 100,
                child: const Text("The application to help you keep up with your tasks", textAlign: TextAlign.center),
              ),

              Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Insert Email', style: TextStyle(fontSize: 20))
                ),
              ),
              myContainer(child: TextField(
                controller: email,
                maxLines: 1,
                style: const TextStyle(fontSize: 15),
                decoration: const InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: 'email',
                ),
              )),

              Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Insert Password', style: TextStyle(fontSize: 20))
                ),
              ),
              myContainer(child: TextField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                controller: password,
                maxLines: 1,
                style: const TextStyle(fontSize: 15),
                decoration: const InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: 'password',
                ),
              )),
              myContainer.button(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Row(
                  children: [
                    Expanded(child: Container()),
                    const Text('Log In', style: TextStyle(color: Colors.white, fontSize: 30)),
                    Expanded(child: Container())
                  ],
                ),
                function:(){
                  if(email.text != 'nail.mmmhstuddy@gmail.com' || password.text != 'Gottem7563'){
                    showDialog(
                      context: context,
                      builder: (context)=>AlertDialog(
                        title: const Text('Email Or Password Is Incorrect'),
                        content: const Text('Email or password maybe incorrect. Try other combination or try another email'),
                        actions: [
                          TextButton(
                            onPressed: ()=>Navigator.pop(context),
                            child: const Text('Ok')
                          )
                        ],
                      )
                    );
                    email.clear();
                    password.clear();
                    return;
                  }
                  print('aaaaaa');
                  Get.toNamed('/home');
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}
