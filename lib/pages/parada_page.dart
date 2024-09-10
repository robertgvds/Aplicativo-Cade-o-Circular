import 'package:flutter/material.dart';

class ParadaPage extends StatefulWidget {
  const ParadaPage({super.key});

  @override
  State<ParadaPage> createState() => _ParadaPageState();
}

class _ParadaPageState extends State<ParadaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Parada x",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
            shadows: [Shadow(color: Colors.grey, blurRadius: 5.0, )],
            color: Theme.of(context).colorScheme.primary
            ),
          ),
        automaticallyImplyLeading: false,
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Ver mais"),
        onPressed: () {}
      ),
    );
  }
}