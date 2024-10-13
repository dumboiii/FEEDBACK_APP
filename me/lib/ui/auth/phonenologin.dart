import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:me/ui/auth/verify.dart';
import 'package:me/utils/utils.dart';
import 'package:me/widgets/round_button.dart';

class LoginPhoneNumber extends StatefulWidget {
  const LoginPhoneNumber({super.key});

  @override
  State<LoginPhoneNumber> createState() => _LoginPhoneNumberState();
}

class _LoginPhoneNumberState extends State<LoginPhoneNumber> {
bool loading=false;
final _auth=FirebaseAuth.instance;
final phonenumbercontroller= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.cyan,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                controller: phonenumbercontroller,
                
                decoration: const InputDecoration(
                  labelText: 'Enter your phone number with +91',
                  border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.phone),
                )
              ),
            ),
            const SizedBox(
              height: 50,

            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: RoundButton(title: "GET OTP", 
              loading: loading,
              ontap: (){
                setState(() {
                  loading=true;
                });
                  _auth.verifyPhoneNumber(
                    phoneNumber: phonenumbercontroller.text,
                    verificationCompleted: (_){
                      setState(() {
                        loading=false;
                      });
                    },
                   verificationFailed: (e){
                    Utils().loastMessage(e.toString());
                    setState(() {
                      loading=false;
                    });
                   },
                    codeSent: (String verification, int? token){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
                      VerifyScreen(verification: verification)));
                    },
                     codeAutoRetrievalTimeout: (e){
                      setState(() {
                        loading=false;
                      });
                    Utils().loastMessage(e.toString());
                   },);
              }),
            )
        ]
      ),
    );
  }
}