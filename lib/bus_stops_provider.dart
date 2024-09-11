import 'dart:convert';
import 'package:flutter/services.dart';

class BusStopsProvider {
  static List<dynamic> busStops = [];

  static Future<void> loadBusData() async {
    try {
      final String response = await rootBundle.loadString('lib/assets/bus_stops.json');
      final data = json.decode(response);
      busStops = List.from(data['busStops']);
    } catch (e) {
      print("Erro ao carregar os dados dos ônibus: $e");
    }
  }

  static List<dynamic> getBusStops() {
    return busStops;
  }
}