import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomPage extends StatefulWidget {
  const BottomPage({super.key});

  @override
  State<BottomPage> createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
            child: CarouselView(
              scrollDirection: Axis.horizontal,
              elevation: 10.0,
              itemExtent: 300,
              itemSnapping: true,
              backgroundColor: Colors.red,
              children: List<Widget>.generate(10, (int index) {
                return Center(child: Text('Item $index'));
              }
            ),
          )
        ),
      ),
    );
  }
}


