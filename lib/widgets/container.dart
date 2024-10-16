import 'package:flutter/material.dart';

class myContainer extends StatelessWidget {
  const myContainer({super.key, required this.child, this.isBtn = false, this.function, this.margin, this.color});
  const myContainer.button({super.key, required this.child, this.isBtn = true, required this.function, this.margin, this.color});

  final EdgeInsets? margin;
  final Color? color;
  final VoidCallback? function;
  final bool isBtn;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
              begin: !isBtn ? Alignment(0, -1) : Alignment(-1.0, 0),
              end:!isBtn ? Alignment(0, 0) : Alignment(1.0, 0),
              colors: <Color>[
                Color.fromRGBO(185, 235, 255, 1.0),
                Color.fromRGBO(145, 224, 255, 1.0),
                Color.fromRGBO(85, 206, 255, 1.0),
                Colors.lightBlueAccent,
              ]
          )
      ),
      child: !isBtn ? Container(
        margin: EdgeInsets.all(2),
        padding: EdgeInsets.all(5),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: color?? Color(0xFFF3F3F3),
        ),
        child: child,
      ) :
      ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(Color(0x00000000)),
          shadowColor: MaterialStatePropertyAll<Color>(Color(0x00000000))
        ),
        onPressed: function,
        child: child
      ),
    );
  }
}
