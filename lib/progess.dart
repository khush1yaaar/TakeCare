import 'package:flutter/material.dart';

class progress extends StatefulWidget {
  const progress({super.key});

  @override
  State<progress> createState() => _progressState();
}

// ignore: camel_case_types
class _progressState extends State<progress> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: const Center(
            child: Text('Progress'),
          ),
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: const Text(
              'progress',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )),
    );
  }
}
