import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:takecare/widgets/chat_user_card.dart';
import 'dart:convert';
//import 'package:flutter/widgets.dart';
import '../api/apis.dart';

class Chome extends StatelessWidget {
  const Chome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(CupertinoIcons.home),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: const Text(
          'Safe Space',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50, right: 10),
        child: FloatingActionButton(
          onPressed: () async {
            await APIs.auth.signOut();
            await GoogleSignIn().signOut();
          },
          child: const Icon(Icons.add_comment_rounded),
          //focusColor: Colors.black,
        ),
      ),
      body: StreamBuilder(
        stream: APIs.firestore.collection('users').snapshots(),
        builder: (context, snapshot) {
          final list = [];
          if (snapshot.hasData) {
            final data = snapshot.data?.docs;
            for (var i in data!) {
              // var jasonEncode2 = jasonEncode;
              print('${jsonEncode(i.data())}' );
              list.add(i.data()['name']);
            }
          }
          return ListView.builder(
            itemCount: list.length,
            padding: const EdgeInsets.only(top: 5),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Text('Name: ${list[index]}');
            },
          );
        },
      ),
    );
  }
}
