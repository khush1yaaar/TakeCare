import 'package:flutter/material.dart';

class Result extends StatefulWidget {
  final int result;
  final String keyword;
  const Result({super.key,required this.result, required this.keyword});

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
        title: const Text(
          'See Your Results',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text(
                '${widget.keyword} Test Results',
                style: const TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                ),
              ), 
              Text('Your score : ${widget.result}'),
              Text(
                showResult(widget.result, widget.keyword)
              ),
            ],
          ),
        ),
      ),
    );
  }
  String showResult(int result, String keyword) {
    
    return "";
  }
}