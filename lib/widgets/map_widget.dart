import 'dart:convert';
import 'package:cadeocircularv5/pages/bottom_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  Map<int, Marker> _markers = {};
  late Future<void> _loadBusData;

  @override
  void initState() {
    super.initState();
    _loadBusData = loadBusData();
  }

  Future<void> loadBusData() async {
    try {
      final String response = await rootBundle.loadString('lib/assets/bus_stops.json');
      final data = json.decode(response);

      List busStops = data['busStops'];
      for (var stop in busStops) {
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
                return BottomPage();
              },
            );
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                width: 20,  // Ajuste o tamanho do fundo se necessário
                height: 20,
                color: const Color.fromARGB(255, 131, 0, 0), // Cor de fundo ajustada
              ),
              const Center(
                  child: Icon(
                    Icons.location_on_rounded,
                    color: Colors.red,
                    size: 50,  // Ajuste o tamanho do ícone se necessário
                  ),
                ),
            ],
          ),
        ),
      );
      }
      setState(() {});
    } catch (e) {
      print("Erro ao carregar os dados dos ônibus: $e");
    }
  }

  List<Marker> getMarkers() {
    return List.from(_markers.values);
  }

  final MapController _mapController = MapController();

  final LatLng _initialCenter = const LatLng(-21.775270, -43.368840);
  final double _limitFactor = 0.01;

  bool _isWithinLimits(LatLng center) {
    return (center.latitude >= _initialCenter.latitude - _limitFactor &&
            center.latitude <= _initialCenter.latitude + _limitFactor) &&
        (center.longitude >= _initialCenter.longitude - _limitFactor &&
            center.longitude <= _initialCenter.longitude + _limitFactor);
  }

TileLayer get mapTileLayer {
  bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

  String tileUrl = isDarkMode
      ? 'https://tiles.stadiamaps.com/tiles/alidade_smooth_dark/{z}/{x}/{y}{r}.png?api_key=dbe29069-000a-4e4e-9443-e148af835ff6' // Tema escuro intermediário (menos intenso)
      : 'https://tiles.stadiamaps.com/tiles/alidade_smooth/{z}/{x}/{y}{r}.png?api_key=dbe29069-000a-4e4e-9443-e148af835ff6'; // Tema claro padrão

  return TileLayer(
    urlTemplate: tileUrl,
    additionalOptions: {
        "api_key": 'dbe29069-000a-4e4e-9443-e148af835ff6'
      },
    subdomains: ['a', 'b', 'c'],
    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
  );
}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _loadBusData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro ao carregar o mapa'));
        }
        return FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: _initialCenter,
            initialZoom: 17,
            maxZoom: 20.0,
            minZoom: 10.0,
            interactionOptions: const InteractionOptions(flags: InteractiveFlag.all),
            backgroundColor: Theme.of(context).colorScheme.surface,
            onPositionChanged: (position, hasGesture) {
              if (!_isWithinLimits(position.center)) {
                _mapController.move(_initialCenter, position.zoom);
              }
            },
          ),
          children: [
            mapTileLayer,
            MarkerLayer(markers: getMarkers()),
          ],
        );
      },
    );
  }
}
