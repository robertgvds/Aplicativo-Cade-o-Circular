import 'dart:convert';

import 'package:cadeocircularv5/bottom_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  @override
  void initState() {
    super.initState();
    loadBusData(context);
  }

  final Map<int, Marker> _markers = {};

  Future<void> loadBusData(BuildContext context) async {
    final String response =
        await rootBundle.loadString('lib/assets/bus_stops.json');
    final data = json.decode(response);

    // Adiciona as paradas de ônibus
    List busStops = data['busStops'];
    busStops.forEach((stop) {
      _markers[stop['id']] = Marker(
        rotate: true,
        point: LatLng(stop['latitude'], stop['longitude']),
        height: 50,
        width: 50,
        alignment: Alignment.center,
        child: GestureDetector(
            onTap: () {
              showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return const BottomPage();
                  });
            },
            child: const Icon(
              Icons.location_on,
              color: Colors.red,
              size: 50,
            )),
      );
    });

    /*
    // Adiciona os ônibus em tempo real
    List buses = data['buses'];
    buses.forEach((bus) {
      _markers[stop['id']] = Marker(
          point: const LatLng(-21.774639, -43.370316),
          height: 50,
          width: 50,
          alignment: Alignment.center,
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
              child: const Icon(
                Icons.directions_bus,
                color: Colors.red,
                size: 50,
              )),
        ),
      );
    });*/

    setState(() {});
  }

  List<Marker> getMarkers() {
    return List.from(_markers.values);
  }

  final MapController _mapController = MapController();

  // Defina o centro inicial e o fator de limite
  final LatLng _initialCenter = const LatLng(-21.775270, -43.368840);
  final double _limitFactor = 0.01;

  // Verifica se o mapa está dentro de um limite aproximado
  bool _isWithinLimits(LatLng center) {
    return (center.latitude >= _initialCenter.latitude - _limitFactor &&
            center.latitude <= _initialCenter.latitude + _limitFactor) &&
        (center.longitude >= _initialCenter.longitude - _limitFactor &&
            center.longitude <= _initialCenter.longitude + _limitFactor);
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
          initialCenter: _initialCenter,
          initialZoom: 17,
          maxZoom: 20.0, // Zoom máximo
          minZoom: 10.0, // Zoom mínimo

          interactionOptions:
              const InteractionOptions(flags: InteractiveFlag.all),
          backgroundColor: Colors.white,
          onPositionChanged: (position, hasGesture) {
            // Verifica se o mapa está fora do limite aproximado
            if (!_isWithinLimits(position.center)) {
              _mapController.move(_initialCenter, position.zoom);
            }
          }),
      children: [openStreetMap, MarkerLayer(markers: getMarkers())],
    );
  }
}

TileLayer get openStreetMap => TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
    );
