import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class LoadBus {
  final Map<int, Marker> _markers = {};
  static List busStops = [];


  void loadParadasData(Function onTapMarker) async {
      final String response = await rootBundle.loadString('lib/assets/bus_stops.json');
      final data = json.decode(response);

      busStops = data['busStops'];
  }

  static List getParadasData() {
    return busStops;
  }

  Future<Map<int, Marker>> loadBusData(Function onTapMarker) async {
    try {
      loadParadasData(onTapMarker);
      for (var stop in busStops) {
        _markers[stop['id']] = Marker(
          rotate: true,
          point: LatLng(stop['latitude'], stop['longitude']),
          height: 50,
          width: 50,
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () => onTapMarker(stop['id']),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 20,
                  height: 20,
                  color: Colors.transparent,
                ),
                const Icon(
                  Icons.location_on_rounded,
                  color: Colors.red,
                  size: 50,
                ),
              ],
            ),
          ),
        );
      }
    } catch (e) {
      print("Erro ao carregar os dados dos ônibus: $e");
    }

    return _markers;
  }

}
