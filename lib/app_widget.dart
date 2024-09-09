import 'package:cadeocircularv5/pages/bus_page.dart';
import 'package:cadeocircularv5/pages/home_page.dart';
import 'package:cadeocircularv5/pages/map_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tema_notifier.dart';  // Substitua pelo nome do arquivo onde `TemaNotifier` está definido

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TemaNotifier>(
      builder: (context, temaNotifier, child) {
        return MaterialApp(
          theme: temaNotifier.themeData,
          initialRoute: '/',
          routes: {
            '/': (context) => HomePage(),
            '/bus': (context) => const BusPage(),
          },
        );
      },
    );
  }
}
