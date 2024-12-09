import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:takecare/models/user_model.dart';
import 'package:takecare/screens/get_started.dart';
import 'package:takecare/screens/auth_screens/otp_screen.dart';
import 'package:takecare/widgets/utils.dart';

class AuthProvider extends ChangeNotifier {
  // for sign in
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  // for otp verification
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // user details
  String? _uid;
  String get uid => _uid!;

  UserModel? _userModel;
  UserModel get userModel => _userModel!;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool checkLoggedIn() {
    final user = _auth.currentUser;
    return user != null;
  }

  Future setSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("is_signed_in", true);
    _isSignedIn = true;
    notifyListeners();
  }

  void checkSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool('is_signed_in') ?? false;
    notifyListeners();
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _firebaseAuth.signOut();
      _uid = null;
      _isSignedIn = false;
      final SharedPreferences s = await SharedPreferences.getInstance();
      await s.setBool('is_signed_in', false);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => GetStartedScreen())); // Replace '/login' with your login screen route
    } catch (e) {
      showSnackbar(context, 'Failed to sign out. ${e.toString()}');
    }
  }

  Future<void> fetchUserData() async {
    _uid ??= _firebaseAuth.currentUser?.uid;

    if (_uid != null) {
      DocumentSnapshot snapshot = await _firebaseFirestore.collection('users').doc(_uid).get();
      if (snapshot.exists) {
        _userModel = UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
        notifyListeners();
      }
    }
  }

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          _isSignedIn = true;
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool("is_signed_in", true);
          await _firebaseAuth.signInWithCredential(phoneAuthCredential); // only when the OTP is completed
        },
        verificationFailed: (error) {
          print('VERIFICATION FAILED');
          throw Exception(error.message); // in case of any error
        },
        codeSent: (verificationId, forceResendingToken) {
          print('EXECUTED CODE SENT');
          _isSignedIn = true;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => OtpScreen(
                      verificationId: verificationId,
                    )),
          );
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      showSnackbar(context, e.message.toString());
    }
  }

//   void verifyOtp({
//   required BuildContext context,
//   required String verificationId,
//   required String userOtp,
//   required Function OnSuccess,
// }) async {
//   _isLoading = true;
//   notifyListeners();

//   print('VERIFY OTP Called - AuthProvider');
//   try {
//     PhoneAuthCredential creds = PhoneAuthProvider.credential(
//       verificationId: verificationId,
//       smsCode: userOtp,
//     );
//     User? user = (await _firebaseAuth.signInWithCredential(creds)).user;
//     if (user != null) {
//       _uid = user.uid;
//       print('OTP Verified Successfully - AuthProvider');
//       OnSuccess();
//     }
//   } on FirebaseAuthException catch (e) {
//     showSnackbar(context, e.message.toString());
//   } finally {
//     _isLoading = false;
//     notifyListeners();
//   }
// }
// Future<bool> checkExistingUser() async {
//   print('Check Existing User Called - AuthProvider');
//   if (_uid == null) {
//     print('ERROR: UID is null');
//     return false;
//   }
//   try {
//     DocumentSnapshot snapshot = await _firebaseFirestore.collection("users").doc(_uid).get();
//     if (snapshot.exists) {
//       print('USER EXISTS');
//       return true;
//     } else {
//       print('NEW USER');
//       return false;
//     }
//   } catch (e) {
//     print('Error checking existing user: $e');
//     return false;
//   } finally {
//     notifyListeners();
//   }
// }


  void verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
    required Function OnSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();

    print('VERIFY OTP Called - AuthProvider');
    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOtp,
      );
      User? user = (await _firebaseAuth.signInWithCredential(creds)).user;
      if (user != null) {
        _uid = user.uid;
        print('OTP Verified Successfully - AuthProvider');
        OnSuccess();
      }
    } on FirebaseAuthException catch (e) {
      showSnackbar(context, e.message.toString());
    } finally {
      _isLoading = false; // Set isLoading back to false after completion
      notifyListeners();
    }
  }

  // DATABASE OPERATIONS
  Future<bool> checkExistingUser() async {
    print('Check Existing User Called - AuthProvider');
    DocumentSnapshot snapshot =
        await _firebaseFirestore.collection("users").doc(_auth.currentUser!.phoneNumber).get();
    if (snapshot.exists) {
      print('USER EXISTS');
      notifyListeners();
      return true;
    } else {
      print('NEW USER');
      notifyListeners();
      return false;
    }
  }

  
  Future saveUserDataToSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString("user_model", jsonEncode(userModel.toMap()));
  }

void saveUserDataToFirebase({
  required BuildContext context,
  required UserModel userModel,
  required File profilePic,
  // ignore: non_constant_identifier_names
  required Function OnSuccess,
}) async {
  try {
    await storeFileToStorage("profilePics/${userModel}.uid", profilePic).then((value) {
      userModel.profilePic = value;
      userModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
      userModel.uid = _firebaseAuth.currentUser!.phoneNumber!;
    });
    _userModel = userModel;
    // Save user data to Firestore
    await _firebaseFirestore
        .collection("users")
        .doc(userModel.uid) // Use uid as document ID
        .set(userModel.toMap())
        .then((value) {
      OnSuccess();
    });
  } catch (e) {
    Navigator.of(context, rootNavigator: true).pop(); // Close loading dialog
    showSnackbar(context, 'Failed to save user data. ${e.toString()}');
  }
}

Future<String> storeFileToStorage(String ref, File file) async {
  try {
    UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  } catch (e) {
    print('Error uploading file to storage: $e');
    throw Exception('File upload failed');
  }
}
}