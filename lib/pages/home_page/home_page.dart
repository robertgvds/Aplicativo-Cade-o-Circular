import 'package:cadeocircularv5/pages/card_page/bottom_page.dart';
import 'package:cadeocircularv5/pages/home_page/bus_page.dart';
import 'package:cadeocircularv5/pages/home_page/map_page.dart';
import 'package:cadeocircularv5/tema_notifier.dart';
import 'package:cadeocircularv5/pages/home_page/widgets/navigationbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedOption = 0;

  void onOptionSelected(int option) {
    setState(() {
      _selectedOption = option;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cadê o Circular?',
          style: TextStyle(color: isDarkMode ? Colors.black : Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
        actions: [
          IconButton(
              icon: Icon(Icons.nightlight_round, color: Theme.of(context).colorScheme.surface,),
              onPressed: () {
                Provider.of<TemaNotifier>(context, listen: false).toggleTheme();
          })
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            (_selectedOption == 0) ? const MapPage() : const BusPage(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 100),
              child: Container(
                height: 75,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface, // Cor do fundo ajustada
                  borderRadius: const BorderRadius.all(Radius.circular(80)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(120, 0, 0, 0),
                      spreadRadius: 0,
                      blurRadius: 7,
                    ),
                  ],
                ),
                child: Navigation(onOptionSelected: onOptionSelected),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: Icon(
          Icons.directions_bus_rounded,
          color: Theme.of(context).colorScheme.surface, // Cor do ícone ajustada
        ),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return const BottomPage(idParada: 0);
            },
          );
        },
      ),
    );
  }
}
