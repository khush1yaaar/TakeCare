import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'home-screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
      ),
      body: const Center(
        child: Text(
        'Home Screen')),
    );
  }
}