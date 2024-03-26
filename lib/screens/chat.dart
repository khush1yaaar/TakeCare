import 'package:flutter/material.dart';
import 'package:takecare/Cscreens/Chome.dart';

//import 'Cscreens/Chome.dart';
late Size mq;

// ignore: camel_case_types
class chat extends StatelessWidget {
  const chat({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: Chome());
  }
}
