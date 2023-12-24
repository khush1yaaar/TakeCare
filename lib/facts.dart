import 'package:flutter/material.dart';

class facts extends StatelessWidget {
  const facts({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'Be Positive',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        body: const Center(
          child: Column(
            children: [Text('Facts', style: TextStyle(fontSize: 40))],
          ),
        ),
      ),
    );
  }
}
