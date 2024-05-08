import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takecare/models/user_model.dart';
import 'package:takecare/provider/auth_provider.dart';
import 'package:takecare/screens/bottom_nav.dart';

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
  static Future<void> showLoadingDialog(BuildContext context, String message) async {
        
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

  static final TextEditingController userInput = TextEditingController();
  
  static Future<void> inputDialog(BuildContext context, String message) async {
    //final TextEditingController _userInput = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final String name = userInput.text; 
    print(userInput.text);  
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 150,
            child: Column(
              children: [
                TextFormField(
                  style: const TextStyle(color: Colors.black),
                  controller: userInput,
                  cursorColor: Colors.blue.shade700,
                  decoration: InputDecoration(
                    focusColor: Colors.black,
                    fillColor: Colors.black,
                    //labelText: message!,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.blue.shade700, 
                        style: BorderStyle.solid,
                        width: 1.5,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        style: BorderStyle.solid
                      )
                    ),
                    label: Text(message)
                  ),
                ),
                const SizedBox(height: 30,),
                Container(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: (){
                      String storeData(){
                        final ap = Provider.of<AuthProvider>(context,listen: false);
                        //MapScreenState location = MapScreenState();
                        UserModel userModel = UserModel(
                          phoneNumber: phoneController.text.trim(), 
                          name: userInput.text,
                          uid: ""
                        );
                        ap.saveUserDataToFirebase(
                          context: context,
                          userModel: userModel,
                          OnSuccess: (){}
                        );
                        return userInput.text;
                      }
                      storeData();
                      Navigator.pop(context);
                      // Navigator.pushReplacement(
                      //   context, 
                      //   MaterialPageRoute(builder: (context)=>const BottomNavBar())
                      // );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade700),
                    ), 
                    child: const Text('Entre',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                  ),
                )
              ],
              
            ),
          )
          // Row(
          //   children: <Widget>[
          //     CircularProgressIndicator(color: Colors.blue.shade400,),
          //     const SizedBox(width: 20),
          //     Text(message),
          //   ],
          // ),
        );
      },
    );
  }
  
}
