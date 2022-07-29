import 'package:flutter/material.dart';

import 'src/ui/home/home.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Day Targets',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const Home(title: 'Daily-Targets'),
    );
  }
}
