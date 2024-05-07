import 'package:flutter/material.dart';

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({super.key});

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: const Text('Articles',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
      ),
      body: const Center(
        child: Text('Articles Screen')
      ),
    );
  }
}
