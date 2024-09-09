import 'package:flutter/material.dart';// Substitua pelo nome correto do arquivo

class Navigation extends StatefulWidget {
  final Function(int) onOptionSelected;

  const Navigation({super.key, required this.onOptionSelected});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentPageIndex = 0;
  
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.onlyShowSelected;

  void _onItemTapped(int index) {
    setState(() {
      currentPageIndex = index;
    });
    widget.onOptionSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        indicatorColor: Theme.of(context).colorScheme.surface, // Cor do indicador ajustada
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(color: Colors.red); // Cor do texto quando selecionado
          }
          return TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color); // Cor do texto quando não selecionado
        }),
        iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: Colors.red); // Cor do ícone quando selecionado
          }
          return IconThemeData(color: Theme.of(context).textTheme.bodyLarge?.color); // Cor do ícone quando não selecionado
        }),
      ),
      child: NavigationBar(
        backgroundColor: Colors.transparent,
        labelBehavior: labelBehavior,
        selectedIndex: currentPageIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.explore),
            label: 'Mapa',
          ),
          NavigationDestination(
            icon: Icon(Icons.bus_alert),
            label: 'Ônibus',
          ),
        ],
      ),
    );
  }
}
