import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:typed_data';

import 'package:takecare/provider/auth_provider.dart' as takecare_auth;
import 'package:takecare/theme/themes.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreen createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  Uint8List? _image;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _bioController = TextEditingController();
  String? _profilePicUrl;
  //String userPhoneNumber = getPhoneNumber(); // Replace with actual user phone number

  @override
  void initState() {
    super.initState();
    _loadProfilePic();
  }

  String getPhoneNumber() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;
    return user!.phoneNumber.toString();
  }

  Future<void> _loadProfilePic() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(getPhoneNumber())
          .get();
      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        if (userData.containsKey('profilePic')) {
          setState(() {
            _profilePicUrl = userData['profilePic'];
          });
        }
        if (userData.containsKey('name')) {
          _nameController.text = userData['name'];
        }
        if (userData.containsKey('bio')) {
          _bioController.text = userData['bio'];
        }
      }
    } catch (e) {
      print('Error loading profile picture: $e');
    }
  }

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _image = bytes;
        });
        // Optionally, upload the new image to Firestore here.
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              CustomTheme.isDarkTheme ? Icons.light_mode : Icons.dark_mode,
              color: Theme.of(context).appBarTheme.backgroundColor,
            ),
            onPressed: () {
              setState(() {
                Provider.of<CustomTheme>(context, listen: false).toggleTheme();
              });
            },
          ),
        ],
        title: Text(
          'Your Profile',
          style: TextStyle(
            color: theme.appBarTheme.backgroundColor,
            fontSize: 25,
            fontWeight: FontWeight.bold
          ),
        ), 
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 115,
                  backgroundColor: theme.appBarTheme.backgroundColor,
                  //backgroundImage: AssetImage('lib/images/family.png',),
                  child: _image == null
                      ? _profilePicUrl == null
                          ? Icon(Icons.person, size: 80, color: theme.appBarTheme.backgroundColor)
                          : ClipOval(
                              child: Image.network(
                                _profilePicUrl!,
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            )
                      : ClipOval(
                          child: Image.memory(
                            _image!,
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Enter your name',
                    label: const Text('Name'),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: theme.appBarTheme.backgroundColor ?? Colors.black, 
                            style: BorderStyle.solid,
                            width: 1.5,
                          ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: theme.appBarTheme.backgroundColor ?? Colors.black,
                            style: BorderStyle.solid
                          ),
                    ),
                    floatingLabelStyle: TextStyle(
                      color: theme.appBarTheme.backgroundColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _bioController,
                  decoration: InputDecoration(
                    hintText: 'Anything about you',
                    labelText: 'About',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: theme.appBarTheme.backgroundColor ?? Colors.black, 
                            style: BorderStyle.solid,
                            width: 1.5,
                          ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: theme.appBarTheme.backgroundColor ?? Colors.black,
                            style: BorderStyle.solid
                          ),
                    ),
                    floatingLabelStyle: TextStyle(
                            color: theme.appBarTheme.backgroundColor,
                        ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  Provider.of<takecare_auth.AuthProvider>(context, listen: false).signOut(context);
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(theme.appBarTheme.backgroundColor),
                ),
                child: Text(
                  'Sign out',
                  style: TextStyle(
                    color: theme.textTheme.bodyLarge!.color ?? Colors.white
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
