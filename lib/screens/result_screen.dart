import 'package:flutter/material.dart';

class Result extends StatefulWidget {
  final int result;
  const Result({super.key,required this.result});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 15, 75, 165),
        title: const Text('See Your Results'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text('${widget.result}'),
              const Text('Mild Anxiety'),
              const Text('Suggestion what to do next'),
            ],
          ),
        ),
      ),
    );
  }
}