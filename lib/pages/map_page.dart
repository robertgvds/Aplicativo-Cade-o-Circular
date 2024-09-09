import 'package:cadeocircularv5/widgets/map_widget.dart';
import 'package:cadeocircularv5/widgets/navigationbar_widget.dart';
import 'package:flutter/material.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  int _selectedOption = 0;

  void onOptionSelected(int option) {
    setState(() {
      _selectedOption = option;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return MapWidget();
  }
}