import 'package:cadeocircularv5/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tema_notifier.dart';  // Substitua pelo nome do arquivo onde `TemaNotifier` está definido

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TemaNotifier(),
      child: const MyApp(),
    ),
  );
}
