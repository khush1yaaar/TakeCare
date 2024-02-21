import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:takecare/Cscreens/models/chat_user.dart';

class APIs {
  //for firebase Authentication
  static FirebaseAuth auth = FirebaseAuth.instance;

  //for accessing cloud firebase database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  //to return current user
  static User get user => auth.currentUser!;

  //for checking user exists or not
  static Future<bool> userExits() async {
    return (await firestore.collection('users').doc(user.email).get()).exists;
  }

  //for creating new user
  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final chatUser = ChatUser(
        image: user.photoURL.toString(),
        about: "Hey! I'm using TakeCare!",
        name: user.displayName.toString(),
        createdAt: time,
        isOnline: true,
        id: user.uid.toString(),
        lastActive: time,
        email: user.email.toString(),
        pushToken: "");
    return await firestore
        .collection('users')
        .doc(user.email)
        .set(chatUser.toJson());
  }
}
