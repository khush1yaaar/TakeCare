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