import 'package:cadeocircularv5/bus_stops_provider.dart';
import 'package:flutter/material.dart';

class ParadaPage extends StatefulWidget {
  final int idParada;  // Defina um campo para armazenar o idParada

  const ParadaPage({super.key, required this.idParada});  // Utilize o "this.idParada" no construtor

  @override
  State<ParadaPage> createState() => _ParadaPageState();
}

class _ParadaPageState extends State<ParadaPage> {

  @override
  Widget build(BuildContext context) {
    // Acesse o idParada através de widget.idParada
    var busStop = BusStopsProvider.getBusStops().elementAt(widget.idParada);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          busStop['parada'],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            shadows: const [Shadow(color: Colors.grey, blurRadius: 5.0, )],
            color: Theme.of(context).colorScheme.primary
            ),
          ),
        automaticallyImplyLeading: false,
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Ver mais"),
        onPressed: () {}
      ),
    );
  }
}