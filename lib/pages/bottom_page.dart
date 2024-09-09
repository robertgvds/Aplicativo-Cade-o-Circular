import 'package:cadeocircularv5/widgets/carousel_bus.dart';
import 'package:flutter/material.dart';

class BottomPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.red,  // Fundo vermelho
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: CarouselWithIndicatorDemo(),
    );
  }
}
