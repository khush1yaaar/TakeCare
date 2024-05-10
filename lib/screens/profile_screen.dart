import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takecare/provider/auth_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: const Text('Profile',style: TextStyle(color: Colors.white),),
        backgroundColor: Color.fromARGB(255, 1, 47, 114),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ap.signOut(context);
          },
          child: Text('Sign Out'),
        ),
      ),
    );
  }
}