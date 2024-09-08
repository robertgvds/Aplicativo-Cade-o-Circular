import 'package:cadeocircularv5/app_controler.dart';
import 'package:cadeocircularv5/home_page.dart';
import 'package:cadeocircularv5/login_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
    animation: AppControler.instance,
    builder: (context, child) {
      return  MaterialApp(
        theme: ThemeData(
          colorScheme: AppControler.instance.DarkTheme ? ColorScheme.dark().copyWith(primary: Colors.red) : ColorScheme.light().copyWith(primary: Colors.red),
        ),
        initialRoute: '/home',
        routes: {
          '/': (context) => LoginPage(),
          '/home': (context) => HomePage(),
          //'/bottom': (context) => BottomSheetExample(),
        },
      );
    });
  }
}