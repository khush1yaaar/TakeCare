import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:takecare/models/user_model.dart';
import 'package:takecare/screens/get_started.dart';
import 'package:takecare/screens/otp_screen.dart';
import 'package:takecare/widgets/utils.dart';

class AuthProvider extends ChangeNotifier{
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

  // AuthProvider(){
  //   checkSignIn();
  // }
  // Future<bool> checkSignIn() async {
  //   final SharedPreferences s = await SharedPreferences.getInstance();
  //   notifyListeners();
  //   return _isSignedIn = s.getBool("is_signed_in") ?? false;
  // }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  Future<bool> checkLoggedIn() async {
    final user = _auth.currentUser;
    return user != null;
  }

  void checkSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool('is_signed_in') ?? false;
    notifyListeners();
  }

//   Future<bool> checkSignIn() async {
//   try {
//     final SharedPreferences s = await SharedPreferences.getInstance();
//     bool isSignedIn = s.getBool("is_signed_in") ?? false;
//     print('isSignedIn: $isSignedIn');
//     _isSignedIn = isSignedIn;
//     notifyListeners();
//     return _isSignedIn;
//   } catch (e) {
//     print('Error checking sign-in: $e');
//     return false;
//   }
// }
  Future<void> signOut(BuildContext context) async {
    try {
      await _firebaseAuth.signOut();
      _uid = null;
      _isSignedIn = false;
      final SharedPreferences s = await SharedPreferences.getInstance();
      await s.setBool('is_signed_in', false);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> GetStartedScreen())); // Replace '/login' with your login screen route
    } catch (e) {
      showSnackbar(context, 'Failed to sign out. ${e.toString()}');
    }
  }

  // Future<void> signOut(BuildContext context) async {
  //   try {
  //     await FirebaseAuth.instance.signOut();

  //     // Clear user session data
  //     final SharedPreferences prefs = await SharedPreferences.getInstance();
  //     await prefs.setBool("is_signed_in", false);
  //     //await prefs.remove("is_signed_in");

  //     // Reset properties
  //     _isSignedIn = false;
  //     _uid = null;
  //     _userModel = null;

  //     // Notify listeners about the sign-out
  //     notifyListeners();

  //     // Navigate to the sign-in screen or any other desired screen
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context)=> const GetStartedScreen())
  //     );
  //   } catch (e) {
  //     // Handle sign-out errors, if any
  //     print("Error signing out: $e");
  //   }
  // }
  void signInWithPhone(BuildContext context,String phoneNumber) async{
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async{
          _isSignedIn = true;
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool("is_signed_in", true);
          await _firebaseAuth.signInWithCredential(phoneAuthCredential);// only when the OTP is completed
        }, 
        verificationFailed: (error){
          print('VERIFICATION FAILED');
          throw Exception(error.message);// in case of any error
        }, 
        codeSent: (verificationId, forceResendingToken) {
          print('EXECUTED CODE SENT');
          _isSignedIn = true;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => OtpScreen(verificationId: verificationId,)),
          );
        }, 
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } on FirebaseAuthException catch(e){
      showSnackbar(context, e.message.toString());
    }
  }
  void verifyOtp({
  required BuildContext context,
  required String verificationId,
  required String userOtp,
  required Function OnSuccess,
}) async {
  _isLoading = true;
  notifyListeners();

  print('CALLED VERIFY OTP- AUTH SCREEN');
  try {
    PhoneAuthCredential creds = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: userOtp,
    );
    User? user = (await _firebaseAuth.signInWithCredential(creds)).user;
    if (user != null) {
      _uid = user.uid;
      OnSuccess();
    }
  } on FirebaseAuthException catch (e) {
    showSnackbar(context, e.message.toString());
  } finally {
    _isLoading = false; // Set isLoading back to false after completion
    notifyListeners();
  }
}


  // DATA BASE OPERATION
  Future<bool> checkExistingUser() async {
    DocumentSnapshot snapshot = await _firebaseFirestore.collection("users").doc(userModel.phoneNumber).get();
    if(snapshot.exists){
      print('USER EXISTS');
      notifyListeners();
      return true;
    }
    else{
      print('NEW USER');
      notifyListeners();
      return false;
    }
  }

  void saveUserDataToFirebase({
    required BuildContext context,
    required UserModel userModel,
    required Function OnSuccess,
  }) async {
    print('SAVE USER DATA TO FIREBASE');
    _isLoading = false;
    notifyListeners();
    try{
      userModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
      //userModel.location = _firebaseAuth.currentUser!.location!;
      userModel.uid = _firebaseAuth.currentUser!.uid;
      _userModel = userModel;

      print(userModel.phoneNumber);
      //uploading to data base
      await _firebaseFirestore
      .collection("users")
      .doc(userModel.phoneNumber)
      .set(userModel.toMap())
      .then((value) => {
        OnSuccess(),
        _isLoading = false,
        notifyListeners(),
      });
    } on FirebaseAuthException catch(e){
      showSnackbar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }
}