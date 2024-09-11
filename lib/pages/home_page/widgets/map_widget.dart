import 'package:cadeocircularv5/bus_stops_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:cadeocircularv5/pages/card_page/bottom_page.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  static void moveMap(LatLng newCenter) {
    _MapWidgetState.moveMap(newCenter);
  }

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> with SingleTickerProviderStateMixin {
  late MapController _mapController;
  late AnimationController _animationController;
  late Animation<LatLng> _animation;
  LatLng _currentCenter = const LatLng(-21.775270, -43.368840);
  
  // Static reference to MapWidgetState instance
  static _MapWidgetState? _instance;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _loadBusData = BusStopsProvider.loadBusData().then((_) => _populateMarkers());
    _animationController = AnimationController(
      duration: const Duration(seconds: 1), // Duração da animação
      vsync: this,
    );

    // Set the static instance to this instance
    _instance = this;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Static method to move the map
  static void moveMap(LatLng newCenter) {
    _instance?._moveMapToNewLocation(newCenter);
  }

  // Method to animate the map movement
  void _moveMapToNewLocation(LatLng newCenter) {
    final LatLng oldCenter = _currentCenter;
    _animation = LatLngTween(begin: oldCenter, end: newCenter).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animation.addListener(() {
      _mapController.move(_animation.value, 17);
      setState(() {
        _currentCenter = _animation.value;
      });
    });

    _animationController.forward(from: 0.0);
  }
  
  final Map<int, Marker> _markers = {};
  late Future<void> _loadBusData;
  
  final double _limitFactor = 0.02;

  void _populateMarkers() {
    for (var stop in BusStopsProvider.getBusStops().asMap().entries) {
      _markers[stop.value['id']] = Marker(
        rotate: true,
        point: LatLng(stop.value['latitude'], stop.value['longitude']),
        height: 50,
        width: 50,
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () {
            _moveMapToNewLocation(LatLng(stop.value['latitude'], stop.value['longitude']));
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return BottomPage(idParada: stop.key);
              },
            );
          },
          child: const Center(
            child: Icon(
              Icons.location_on_rounded,
              color: Colors.red,
              size: 50,
            ),
          ),
        ),
      );
    }
    setState(() {});
  }

  List<Marker> getMarkers() {
    return List.from(_markers.values);
  }

  bool _isWithinLimits(LatLng center) {
    return (center.latitude >= _currentCenter.latitude - _limitFactor &&
            center.latitude <= _currentCenter.latitude + _limitFactor) &&
        (center.longitude >= _currentCenter.longitude - _limitFactor &&
            center.longitude <= _currentCenter.longitude + _limitFactor);
  }

  TileLayer get mapTileLayer {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    String tileUrl = isDarkMode
        ? 'https://tiles.stadiamaps.com/tiles/alidade_smooth_dark/{z}/{x}/{y}{r}.png?api_key=dbe29069-000a-4e4e-9443-e148af835ff6'
        : 'https://tiles.stadiamaps.com/tiles/alidade_smooth/{z}/{x}/{y}{r}.png?api_key=dbe29069-000a-4e4e-9443-e148af835ff6';

    return TileLayer(
      urlTemplate: tileUrl,
      additionalOptions: const {
        "api_key": 'dbe29069-000a-4e4e-9443-e148af835ff6'
      },
      retinaMode: true,
      subdomains: const ['a', 'b', 'c'],
      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _loadBusData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Erro ao carregar o mapa'));
        }
        return FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: _currentCenter,
            initialZoom: 17,
            maxZoom: 20.0,
            minZoom: 10.0,
            interactionOptions:
                const InteractionOptions(flags: InteractiveFlag.all),
            backgroundColor: Theme.of(context).colorScheme.surface,
            onPositionChanged: (position, hasGesture) {
              if (!_isWithinLimits(position.center)) {
                _mapController.move(_currentCenter, position.zoom);
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
