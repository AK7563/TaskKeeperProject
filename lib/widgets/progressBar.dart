import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({Key? key, required this.count, required this.len, required this.high}) : super(key: key);
  final num count;
  final num len;
  final bool high;

  @override
  Widget build(BuildContext context) {

    final double _barWidth = MediaQuery.of(context).size.width * (high ? 0.9 : 0.9);

    return Container(
      margin: EdgeInsets.all(5),
      child: Column(
        children: [
          if(high)...{
            Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.w600),
                  children: <InlineSpan>[
                    TextSpan(
                      text: count.toString(),
                      style: const TextStyle(color: Colors.lightBlueAccent, fontSize: 15.0),
                    ),
                    const TextSpan(text: "/"),
                    TextSpan(
                      text: len.toString(),
                      style: const TextStyle(color: Colors.lightBlueAccent, fontSize: 15.0),
                    ),
                  ],
                ),
              ),
            )
          },
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: high ? 5 : 2,
                    width: _barWidth,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: const Color.fromRGBO(234, 234, 234, 1.0)
                    ),
                  ),
                  Container(
                    height: high ? 5 : 2,
                    width: _barWidth * count/len,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        gradient: const LinearGradient(
                          colors: <Color>[
                            Color.fromRGBO(185, 235, 255, 1.0),
                            Color.fromRGBO(145, 224, 255, 1.0),
                            Color.fromRGBO(85, 206, 255, 1.0),
                            Colors.lightBlueAccent,
                          ],
                          stops: [0.25, 0.5, 0.75, 1.0],
                        )
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}