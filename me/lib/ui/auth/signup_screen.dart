import 'package:firebase_auth/firebase_auth.dart';  
import 'package:flutter/material.dart';  
import 'package:me/ui/auth/log.dart';  
import 'package:me/utils/utils.dart';  
import 'package:me/widgets/round_button.dart';  

class SignupScreen extends StatefulWidget {  
  const SignupScreen({super.key});  

  @override  
  State<SignupScreen> createState() => _SignupScreenState();  
}  

class _SignupScreenState extends State<SignupScreen> {  
  final emailController = TextEditingController();  
  final passwordController = TextEditingController();  
  final _formKey = GlobalKey<FormState>();  
  final FirebaseAuth _auth = FirebaseAuth.instance;  
  bool loading = false;  

  @override  
  void dispose() {  
    super.dispose();  
    emailController.dispose();  
    passwordController.dispose();  
  }  

  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(  
        backgroundColor: Colors.cyan,  
        title: const Text('SIGN UP'),  
      ),  
      body: Padding(  
        padding: const EdgeInsets.symmetric(horizontal: 20),  
        child: SingleChildScrollView(
          child: Column(  
            mainAxisAlignment: MainAxisAlignment.center,  
            crossAxisAlignment: CrossAxisAlignment.center,  
            children: [  
            const  SizedBox(height: 50,),
             Image.asset("assets/images/signup.gif",height: 250,width: 200,),
              
              Form(  
                key: _formKey,  
                child: Column(  
                  children: [  
          
                    TextFormField(  
                      keyboardType: TextInputType.emailAddress,  
                      controller: emailController,  
                      validator: (value) {  
                        if (value == null || value.isEmpty) {  
                          return 'Please enter your email';  
                        } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)) {  
                          return 'Please enter a valid email address';  
                        }  
                        return null; // Valid email  
                      },  
                      decoration: const InputDecoration(  
                        helperText: "eg adarsh@gmail.com",  
                        labelText: "Email",  
                        prefixIcon: Icon(Icons.alternate_email_outlined),  
                      ),  
                    ),  
                    const SizedBox(height: 15),  
                    TextFormField(  
                      validator: (value) {  
                        if (value == null || value.isEmpty) {  
                          return 'Please enter your password';  
                        } else if (value.length < 6) {  
                          return 'Password should be at least 6 characters';  
                        }  
                        return null; // Valid password  
                      },  
                      obscureText: true,  
                      obscuringCharacter: '*',  
                      controller: passwordController,  
                      decoration: const InputDecoration(  
                        helperText: "make a strong password",  
                        labelText: "Password",  
                        prefixIcon: Icon(Icons.security_outlined),  
                      ),  
                    ),  
                  ],  
                ),  
              ),  
              const SizedBox(height: 30),  
              RoundButton(  
                title: "SIGN UP",  
                loading: loading,  
                ontap: () {  
                  if (_formKey.currentState!.validate()) {  
                    setState(() {  
                      loading = true;  
                    });  
                    
                    _auth.createUserWithEmailAndPassword(  
                      email: emailController.text.trim(),  
                      password: passwordController.text.trim(),  
                    ).then((value) {  
                      // User successfully created  
                      setState(() {  
                        loading = false;  
                        Navigator.pushReplacementNamed(context, '/LoginScreen');
                      });  
                      // You can navigate to the homepage or a different screen here.  
                    }).catchError((error) {  
                      setState(() {  
                        loading = false;  
                      });  
                      if (error is FirebaseAuthException) {  
                        if (error.code == 'email-already-in-use') {  
                          Utils().loastMessage("The email address is already in use. Please use a different email.");  
                        } else {  
                          Utils().loastMessage("An error occurred, please try again.");  
                        }  
                      }  
                    });  
                  }  
                },  
              ),  
              const SizedBox(height: 30),  
              Row(  
                mainAxisAlignment: MainAxisAlignment.center,  
                children: [  
                  const Text(  
                    "Already have an account?",  
                    style: TextStyle(fontSize: 16),  
                  ),  
                  TextButton(  
                    onPressed: () {  
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));  
                    },  
                    child: const Text(  
                      "Login",  
                      style: TextStyle(fontSize: 16),  
                    ),  
                  ),  
                ],  
              ),  
            ],  
          ),
        ),  
      ),  
    );  
  }  
}