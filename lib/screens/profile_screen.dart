import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: const Text('Profile',style: TextStyle(color: Colors.white),),
        backgroundColor: Color.fromARGB(255, 1, 47, 114),
      ),
      body: const Center(child: Text('Profile Screen')),
    );
  }
}