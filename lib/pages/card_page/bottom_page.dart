import 'package:cadeocircularv5/pages/card_page/widgets/carousel_bus.dart';
import 'package:flutter/material.dart';

class BottomPage extends StatelessWidget {
  final int idParada;
  const BottomPage({super.key, required this.idParada});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      height: 300,
      decoration: const BoxDecoration(
        color: Colors.red,  // Fundo vermelho
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: CarouselWithIndicatorDemo(idParada: idParada),
    );
  }
}
