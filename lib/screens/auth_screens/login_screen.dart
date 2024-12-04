import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takecare/provider/auth_provider.dart';
import 'package:takecare/widgets/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController phoneController = TextEditingController();
  Country selectedCountry = Country(
    phoneCode: '91', 
    countryCode: 'IN', 
    e164Sc: 0, 
    geographic: true, 
    level: 1, 
    name: 'India', 
    example: 'India', 
    displayName: 'India', 
    displayNameNoCountryCode: 'IN', 
    e164Key: '');

    @override
  void dispose() {
    super.dispose();
    //phoneController.dispose(); 
  }
  
  @override
  Widget build(BuildContext context) {
    phoneController.selection = TextSelection.fromPosition(
      TextPosition(offset: phoneController.text.length),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('lib/images/therapy.png'),
            const Text('OTP Verification',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            const Text('We will send you an One Time Password on \n                      this Mobile Number',style: TextStyle(color: Colors.grey),),
            const SizedBox(
              height: 20,
            ),
            const Text('Entre your Mobile Number'),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15),
              child: TextFormField(
                cursorColor: Colors.blue.shade100,
                controller: phoneController,
                onChanged: (value){
                  setState(() {
                    phoneController.text = value;
                  });
                },
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                decoration: InputDecoration(
                  hintText: 'Entre phone number',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black12)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black)
                  ),
                  prefixIcon: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: (){
                          showCountryPicker(
                            context: context, 
                            countryListTheme: const CountryListThemeData(
                              bottomSheetHeight: 500),
                            onSelect: (value){
                            setState(() {
                              selectedCountry = value;
                            });
                          });
                        },
                        child: Text("${selectedCountry.flagEmoji}  +${selectedCountry.phoneCode}",
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),),
                      ),
                    ),
                  ),
                  suffixIcon: phoneController.text.length == 10? const Icon(Icons.done,color: Colors.green,size: 30,):null,
                  ),
              ), 
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30,right: 30),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                          onPressed: () async{
                            //final ap = Provider.of<AuthProvider>(context,listen: false);
                            if(phoneController.text.length == 10){
                              //storeData();
                              _showLoadingDialog(context);
                              sendPhoneNumber();
                              print('called sendPhone Number');
                            }
                          }, 
                          style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: phoneController.text.length == 10? MaterialStateProperty.all<Color>(Colors.blue.shade100): MaterialStateProperty.all<Color>(Colors.grey),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            ),),
                          ),
                          child: const Text(
                            'Get OTP', 
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold)),),
                            ),
            )
          ],
        ),
      ),
    );
  }
  void sendPhoneNumber(){
    final ap = Provider.of<AuthProvider>(context,listen: false);
    String phoneNumber = phoneController.text.trim();
    ap.signInWithPhone(context,"+91$phoneNumber");
  }

  void _showLoadingDialog(BuildContext context) {
    Dialogs.showLoadingDialog(context, 'Sending OTP...');
  }
}