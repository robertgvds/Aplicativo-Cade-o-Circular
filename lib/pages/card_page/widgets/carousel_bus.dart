import 'package:cadeocircularv5/bus_stops_provider.dart';
import 'package:cadeocircularv5/pages/card_page/parada_page.dart';
import 'package:cadeocircularv5/pages/home_page/widgets/map_widget.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:latlong2/latlong.dart';

final List listParadaPage = [
  for(int i = 0; i < BusStopsProvider.getBusStops().length; i++) ParadaPage(idParada: i)
];

class CarouselWithIndicatorDemo extends StatefulWidget {
  final int idParada;
  //final Function(LatLng) onMoveMap;

  const CarouselWithIndicatorDemo({super.key, required this.idParada});

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    final List<Widget> stopsBus = listParadaPage
        .map((item) => Container(
          margin: const EdgeInsets.all(5.0),
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(25.0)),
              child: Stack(
                children: <Widget>[
                  item,
                ],
              )),
        ))
        .toList();

    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      CarouselSlider(
        items: stopsBus,
        carouselController: _controller,
        options: CarouselOptions(
            initialPage: widget.idParada,
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 1.6,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
              MapWidget.moveMap(LatLng(BusStopsProvider.getBusStops().elementAt(index)['latitude'], BusStopsProvider.getBusStops().elementAt(index)['longitude']));
            }),
      ),
      Container(
        height: 5.0,
      ),
      Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: stopsBus.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 8.0,
                height: 8.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).colorScheme.surface)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList()),
    ]);
  }
}
