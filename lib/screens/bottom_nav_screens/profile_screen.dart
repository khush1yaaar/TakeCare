import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:typed_data';

import 'package:takecare/provider/auth_provider.dart' as takecare_auth;

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
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            //Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back,color: Color.fromARGB(255, 49, 162, 197))
        ),
        title: const Text('Profile Screen',style: TextStyle(color: Colors.white),),
        backgroundColor: Color.fromARGB(255, 49, 162, 197),
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
                  backgroundColor: Color.fromARGB(255, 49, 162, 197),
                  //backgroundImage: AssetImage('lib/images/family.png',),
                  child: _image == null
                      ? _profilePicUrl == null
                          ? const Icon(Icons.person, size: 80, color: Colors.white)
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
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 49, 162, 197), 
                            style: BorderStyle.solid,
                            width: 1.5,
                          ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            style: BorderStyle.solid
                          ),
                    ),
                    floatingLabelStyle: const TextStyle(
                      color: Color.fromARGB(255, 49, 162, 197),
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
                    hintText: 'Enter your bio',
                    labelText: 'Feeling Awesome',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 49, 162, 197), 
                            style: BorderStyle.solid,
                            width: 1.5,
                          ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            style: BorderStyle.solid
                          ),
                    ),
                    floatingLabelStyle: const TextStyle(
                            color: Color.fromARGB(255, 49, 162, 197),
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
                  backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 49, 162, 197)),
                ),
                child: Text(
                  'Sign out',
                  style: TextStyle(
                    color: Colors.white
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
