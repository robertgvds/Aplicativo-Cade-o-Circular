import 'package:cadeocircularv5/listBus.dart';
import 'package:cadeocircularv5/widgets/navigationbar_widget.dart';
import 'package:flutter/material.dart';

class BusPage extends StatefulWidget {
  const BusPage({super.key});

  @override
  State<BusPage> createState() => _BusPageState();
}

class _BusPageState extends State<BusPage> {
  int _selectedOption = 0;

  void onOptionSelected(int option) {
    setState(() {
      _selectedOption = option;
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