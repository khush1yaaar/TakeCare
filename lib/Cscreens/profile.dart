//import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:takecare/api/apis.dart';
import 'package:takecare/auth/login_screen.dart';
//import 'package:takecare/Cscreens/helper/dialogs.dart';
//import 'package:google_sign_in/google_sign_in.dart';
import 'package:takecare/models/chat_user.dart';
import 'package:takecare/screens/chat.dart';
//import 'package:takecare/Cscreens/widgets/chat_user_card.dart';
//import 'package:takecare/widgets/chat_user_card.dart';
//import 'dart:convert';
//import 'package:flutter/widgets.dart';
//import 'api/apis.dart';

class Profile extends StatefulWidget {
  final ChatUser user;

  const Profile({super.key, required this.user});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: FloatingActionButton.extended(
          onPressed: () async {
            //Dialogs.showProgressBar(context);
            // ignore: await_only_futures
            await APIs.auth.signOut;
            await GoogleSignIn().signOut();
            // ignore: use_build_context_synchronously
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const LoginScreen()));
          },
          icon: const Icon(Icons.logout),
          label: const Text('LogOut'),
          //focusColor: Colors.black,
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            width: mq.width,
            height: mq.height * 0.02,
          ),
          Stack(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(mq.width * 10),
              child: CircleAvatar(
                radius: mq.width * 0.25,
                child: CachedNetworkImage(
                  width: mq.width * 10,
                  height: mq.height * 10,
                  imageUrl: widget.user.image,
                  errorWidget: (context, url, error) => const CircleAvatar(
                    child: Icon(CupertinoIcons.person),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: MaterialButton(
                onPressed: () {},
                color: Colors.black,
                shape: const CircleBorder(eccentricity: 0.01),
                child: const Icon(Icons.edit, color: Colors.white),
              ),
            ),
          ]),
          SizedBox(
            height: mq.height * 0.02,
          ),
          Text(widget.user.email,
              style: const TextStyle(color: Colors.black54, fontSize: 16)),
          SizedBox(
            height: mq.height * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: TextFormField(
              initialValue: widget.user.name,
              decoration: const InputDecoration(
                  prefixIcon: Icon(CupertinoIcons.person),
                  border: OutlineInputBorder(),
                  hintText: 'eg : Khushi Soni',
                  label: Text('Name')),
            ),
          ),
          SizedBox(
            height: mq.height * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: TextFormField(
              initialValue: widget.user.about,
              decoration: const InputDecoration(
                  prefixIcon: Icon(CupertinoIcons.info),
                  border: OutlineInputBorder(),
                  hintText: 'eg : busy',
                  label: Text('About')),
            ),
          ),
          SizedBox(
            height: mq.height * 0.02,
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                minimumSize: Size(mq.width * 0.3, mq.height * 0.055)),
            onPressed: () {},
            icon: const Icon(Icons.edit),
            label: const Text('Update'),
          ),
        ],
      ),
    );
  }
}
