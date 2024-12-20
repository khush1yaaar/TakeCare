import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:takecare/provider/auth_provider.dart';
import 'package:takecare/screens/bottom_nav_screens/bottom_nav.dart';
import 'package:takecare/screens/user_info.dart';
import 'package:takecare/widgets/utils.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  const OtpScreen({super.key, required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? otpcode;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isLoading = Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: theme.scaffoldBackgroundColor,
              ),
            )
          : Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset('lib/images/teen_image.png'),
                    const Text(
                      'OTP Verification',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      'Enter the OTP sent to the given Number',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Pinput(
                      length: 6,
                      showCursor: true,
                      defaultPinTheme: PinTheme(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: theme.scaffoldBackgroundColor)),
                          textStyle: const TextStyle(fontSize: 28, color: Colors.black)),
                      onCompleted: (value) {
                        setState(() {
                          otpcode = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    RichText(
                        text: const TextSpan(children: [
                      TextSpan(
                          text: "Didn't receive OTP?   ",
                          style: TextStyle(color: Colors.black)),
                      TextSpan(
                          text: "Resend OTP",
                          style: TextStyle(color: Colors.red)),
                    ])),
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          if (otpcode != null) {
                            print('OTP Code Entered: $otpcode');
                            verifyOtp(context, otpcode!);
                          } else {
                            showSnackbar(context, 'Enter 6-Digit Code');
                          }
                        },
                        style: ButtonStyle(
                          foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                          backgroundColor: otpcode != null && otpcode!.length == 6 ? 
                          WidgetStateProperty.all<Color>(
                            theme.scaffoldBackgroundColor,
                          ) : 
                          WidgetStateProperty.all<Color>(
                            Colors.blueGrey,
                          ),
                          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                        ),
                        child: const Text('Verify',
                            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  void verifyOtp(BuildContext context, String userOtp) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    print('VERIFY OTP Called - OTP Screen');
    ap.verifyOtp(
      context: context,
      verificationId: widget.verificationId,
      userOtp: userOtp,
      OnSuccess: () {
        print('OTP Verified Successfully');
        ap.checkExistingUser().then((value) async {
          print('Check Existing User Called');
          if (value == true) {
            // User Already Exists in our app
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const BottomNavBar()),
              (route) => false,
            );
          } else {
            // New User
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const UserInfo()),
              (route) => false,
            );
          }
        });
      },
    );
  }
}
