import 'package:flutter/material.dart';

void showSnackbar(BuildContext context,String content) async {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Color.fromARGB(255, 61, 59, 59).withOpacity(0.6),
      ));
}

void showProgressBar(BuildContext context){
  showDialog(context: context, builder: (_) => const Center(
    child: CircularProgressIndicator()
    )
  );
}

class Dialogs {
  static Future<void> showLoadingDialog(
      BuildContext context, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: <Widget>[
              CircularProgressIndicator(color: Colors.blue.shade400,),
              const SizedBox(width: 20),
              Text(message),
            ],
          ),
        );
      },
    );
  }
}
