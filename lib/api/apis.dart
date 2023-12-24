import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class APIs {
  //for firebase Authentication
  static FirebaseAuth auth = FirebaseAuth.instance;
  //for accessing cloud firebase database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
}
