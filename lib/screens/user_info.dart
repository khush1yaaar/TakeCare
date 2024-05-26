import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:takecare/models/user_model.dart';
import 'package:takecare/provider/auth_provider.dart';
import 'package:takecare/screens/bottom_nav.dart';
import 'package:takecare/widgets/utils.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  File? image;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final bioController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    emailController.dispose();
    bioController.dispose();
    super.dispose();
  }

  void selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = File(pickedFile!.path);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.blue.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 50),
            child: Column(
              children: [
                InkWell(
                  onTap: selectImage,
                  child: image == null ?
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.blue.shade700,
                    child: Icon(Icons.account_circle,size: 70, color: Colors.white,),
                  ) :
                  CircleAvatar(
                    backgroundImage: FileImage(image!),
                    radius: 70,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                  margin: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      // name 
                      textField(hintText: "Jon Snow", icon: Icons.person, inputType: TextInputType.name, maxlines: 1, controller: nameController),
                      // email 
                      textField(hintText: "xyz@email.com", icon: Icons.email, inputType: TextInputType.emailAddress, maxlines: 1, controller: emailController),
                      // bio 
                      textField(hintText: "Hey! I'm using TakeCare", icon: Icons.edit, inputType: TextInputType.name, maxlines: 2, controller: bioController)
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                SizedBox(
                  height: 50,
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () => storeData(context),
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.blue.shade700),
                    ),
                    child: const Text('Continue',style: TextStyle(color: Colors.white,fontSize: 17),),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _showLoadingDialog(BuildContext context) {
    Dialogs.showLoadingDialog(context, 'Saving Your Data...');
  }
  void storeData(BuildContext context){
    _showLoadingDialog(context);
    final ap = Provider.of<AuthProvider>(context,listen: false);
    UserModel userModel = UserModel(
      name: nameController.text.trim(),
      bio: bioController.text.trim(),
      email: emailController.text.trim(),
      phoneNumber: '', 
      uid: '',
      profilePic: ''
    );
    if(image != null){
      ap.saveUserDataToFirebase(
        context: context, 
        userModel: userModel, 
        profilePic: image!,
        OnSuccess: () {
          ap.saveUserDataToSP().then((value) {
            ap.setSignIn().then((value) {
              Navigator.pushReplacement(
                context, 
                MaterialPageRoute(builder: (context) => BottomNavBar())
              );
            });
          });
        }
      );
    }
    else{
      showSnackbar(context, "please set a profile....");
    }
  }

  Widget textField({
    required String hintText,
    required IconData icon,
    required TextInputType inputType,
    required int maxlines,
    required TextEditingController controller
  }){
    return Padding(
      padding: EdgeInsets.all(15),
      child: TextFormField(
        cursorColor: Colors.blue.shade800,
        controller: controller,
        keyboardType: inputType,
        maxLines: maxlines,
        decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)
          ),
          focusColor: Colors.blue.shade800,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            
          ),
          prefixIcon: Container(
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.blue.shade800,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: 20,
              color: Colors.white,
            ),
          ),
          alignLabelWithHint: true,
          fillColor: Colors.blue.shade100,
          filled: true,
        ),
      )
    );
  }
}