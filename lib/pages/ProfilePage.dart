import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxproject/controllers/controller.dart';
import 'package:getxproject/widgets/container.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key,});

  final MyController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            children: [
              Container(
                height: 200,
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.zero,
                    topRight: Radius.zero,
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)
                  ),
                  image: DecorationImage(image: NetworkImage(controller.backgroundPath.value.toString()), fit: BoxFit.fitHeight)
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(image: NetworkImage(controller.imagePath.value), fit: BoxFit.fitHeight)
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                      child: const Text('AK7563', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold))
                    )
                  ],
                )
              ),
              Expanded(
                child: Transform.translate(
                  offset: const Offset(0, -20),
                  child: myContainer(
                    color: const Color(0xFFF6F7FD),
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              const Expanded(
                                child: myContainer.button(
                                  child: Icon(Icons.settings, color: Colors.white),
                                  function: null,
                                  margin: EdgeInsets.all(5)
                                ),
                              ),
                              Expanded(
                                child: myContainer.button(
                                    child: const Icon(Icons.qr_code, color: Colors.white),
                                    function: (){
                                      Get.toNamed("/qr");
                                    },
                                    margin: const EdgeInsets.all(5)
                                ),
                              ),
                              const Expanded(
                                child: myContainer.button(
                                    child: Icon(Icons.notifications, color: Colors.white),
                                    function: null,
                                    margin: EdgeInsets.all(5)
                                ),
                              ),
                            ],
                          )
                        ),
                        const ListTile(
                          leading: Icon(Icons.settings),
                          title: Text('Profile Settings'),
                        ),
                        const ListTile(
                          leading: Icon(Icons.notifications),
                          title: Text('Notifications'),
                        ),
                        const ListTile(
                          leading: Icon(Icons.qr_code),
                          title: Text('Your QR Code'),
                        ),
                        ListTile(
                          leading: const Icon(Icons.check),
                          title: const Text('Completed Books: '),
                          trailing: Text(controller.completed.length.toString(), textAlign: TextAlign.end, style: const TextStyle(color: Colors.blue, fontSize: 20)),
                        ),
                        ListTile(
                          leading: const Icon(Icons.close),
                          title: const Text('Uncompleted Books: '),
                          trailing: Text(controller.uncompleted.length.toString(), textAlign: TextAlign.end, style: const TextStyle(color: Colors.blue, fontSize: 20)),
                        ),
                      ],
                    )
                  ),
                ),
              )
            ],
          ),
        ),
    );
  }
}
