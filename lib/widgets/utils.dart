import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

Future<File?> pickImage(BuildContext context) async {
  // ignore: unused_local_variable
  File? image;
  try {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedImage != null){
      image = File(pickedImage.path);
    }
  } catch(e) {
    showSnackbar(context, e.toString());
  }
  return null;
}

// pickImage(ImageSource) async {
//   final ImagePicker _imagepicker = ImagePicker();
//   XFile? file = await _imagepicker.pickImage(source: ImageSource);

//   if(file != null){
//     return await file.readAsBytes();
//   }
//   else{
//     print('NO IMAGE SELECTED');
//   }
// }

// Future<Uint8List?> pickImage(ImageSource source) async {
//   final ImagePicker _imagePicker = ImagePicker();
//   XFile? file = await _imagePicker.pickImage(source: source);

//   if (file != null) {
//     return await file.readAsBytes();
//   } else {
//     print('No image selected');
//     return null;
//   }
// }

class Dialogs {
  static Future<void> showLoadingDialog(BuildContext context, String message) async {
        
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: <Widget>[
              CircularProgressIndicator(color: Color.fromARGB(255, 49, 162, 197)),
              const SizedBox(width: 20),
              Text(message),
            ],
          ),
        );
      },
    );
  }
 }
