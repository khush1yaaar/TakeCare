import 'package:flutter/material.dart';
class LoginEmailScreen extends StatefulWidget {
  const LoginEmailScreen({super.key});

  @override
  State<LoginEmailScreen> createState() => _LoginEmailScreenState();
}

class _LoginEmailScreenState extends State<LoginEmailScreen> {
  final _formKey - GlobalKey<FormState>();

  String email = '';
  String password = '';
  String fullname = '';
  bool login = false;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
        padding: const EdgeInsets.all(14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //========Full Name========
            login ? Container() : TextFormField(
              key: const ValueKey('fullname'),
              decoration: const InputDecoration(
                hintText: 'Entre Full Name',
              ),
              validator:(value) {
                if(value!.isEmpty){
                  return 'please Entre full Name';
                }
                else{
                  return null;
                }
              },
              onSaved: (value){
                setState((){
                  fullname = value!;
                });
              },
            ),
            //======= Email ======
            TextFormField(
              key: const ValueKey('email'),
              decoration: const InputDecoration(hintText: 'Entre Email'),
              validator: (value){
                if(value!.isEmpty || value.contains('0')){
                  return 'please Entre valid Emial';
                }
                else{
                  return null;
                }
              },
              onSaved: (value){
                setState((){
                  email = value!;
                });
              },
            ),
            // ======== password ======
            TextFormField(
              key: const ValueKey('password'),
              obscureText: true,
              decoration: const InputDecoration(hintText: 'Entre Password',),
              validator: (value){
                if(value!.length < 6){
                  return 'please entre password with min 6 charaters';
                }else{
                  return null;
                }
              },
              onSaved: (value){
                setState(() {
                  password = value!;
                });
              },
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 55,
              width: double.infinity,
              child: ElevatedButton(onPressed: () async{
                if(_formKey.currentState!.validate()){
                  _formKey.currentState!.save();
                  login ? AuthServices.signinUser(email,password,BuildContext):
                  AuthServices.signupUser(email,password,fullname,context);
                }
              }, child: Text(login?'Login':'SignUp'),),
            )
          ],),
      )),
    );
  }
}
