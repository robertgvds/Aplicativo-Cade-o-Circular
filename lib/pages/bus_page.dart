import 'package:cadeocircularv5/listBus.dart';
import 'package:flutter/material.dart';

class BusPage extends StatefulWidget {
  const BusPage({super.key});

  @override
  State<BusPage> createState() => _BusPageState();
}

class _BusPageState extends State<BusPage> {
  void onOptionSelected(int option) {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 100),
      child: ListBus(

      )
    );
  }
}