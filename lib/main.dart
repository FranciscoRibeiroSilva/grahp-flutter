import 'package:flutter/material.dart';
import 'umid.dart';
import 'smok.dart';
import 'voltagem.dart';
import 'home2.dart';
import 'widget/navigator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage2(),
    );
  }
}
