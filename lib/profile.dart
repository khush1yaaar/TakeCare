//import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:google_sign_in/google_sign_in.dart';
import 'package:takecare/Cscreens/models/chat_user.dart';
//import 'package:takecare/Cscreens/widgets/chat_user_card.dart';
//import 'package:takecare/widgets/chat_user_card.dart';
//import 'dart:convert';
//import 'package:flutter/widgets.dart';
//import 'api/apis.dart';

class Profile extends StatefulWidget {
  final ChatUser user;

  const Profile({super.key,required this.user});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(CupertinoIcons.home),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(bottom: 50, right: 10),
      //   child: FloatingActionButton(
      //     onPressed: () async {
      //       await APIs.auth.signOut();
      //       await GoogleSignIn().signOut();
      //     },
      //     child: const Icon(Icons.add_comment_rounded),
      //     //focusColor: Colors.black,
      //   ),
      // ),
      //body:
    );
  }
}
