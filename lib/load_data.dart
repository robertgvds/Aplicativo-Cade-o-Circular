/*import 'package:cadeocircularv5/app_controler.dart';
import 'package:cadeocircularv5/map_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Tela Inicial', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
        actions: [CustomSwitch()],
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: MapWidget(),
        ),
      
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.red,
        child: Icon(Icons.add, color: Colors.white,),
        onPressed: () {
          setState(() {
            counter++;
          });
        },
        ),
      
    );
    
  }
}

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Switch(
          activeTrackColor: Colors.black,
          activeColor: Colors.red,
          value: AppControler.instance.DarkTheme,
          onChanged: (value) {
            AppControler.instance.mudarTema();
          });
  }
}*/