import 'package:cadeocircularv5/pages/bottom_page.dart';
import 'package:cadeocircularv5/tema_notifier.dart';
import 'package:cadeocircularv5/widgets/map_widget.dart';
import 'package:cadeocircularv5/widgets/navigationbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cadê o Circular?',
          style: TextStyle(color: isDarkMode ? Colors.red : Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
        actions: [
          Switch(
            activeTrackColor: Colors.black,
            activeColor: Colors.red,
            value: Provider.of<TemaNotifier>(context).themeData.brightness == Brightness.dark,
            onChanged: (value) {
              Provider.of<TemaNotifier>(context, listen: false).toggleTheme();
            },
          )
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            MapWidget(),
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
                child: Navigation(),
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
              return BottomPage();
            },
          );
        },
      ),
    );
  }
}
