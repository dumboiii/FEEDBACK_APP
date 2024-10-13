import 'package:firebase_auth/firebase_auth.dart';   
import 'package:flutter/material.dart';  
import 'package:me/ui/auth/signup_screen.dart';  
import 'package:me/utils/utils.dart';  
import 'package:me/widgets/round_button.dart';  

class LoginScreen extends StatefulWidget {  
  const LoginScreen({super.key});  

  @override  
  State<LoginScreen> createState() => _LoginScreenState();  
}  

class _LoginScreenState extends State<LoginScreen> {  
  bool loading = false;  
  final emailController = TextEditingController();  
  final passwordController = TextEditingController();  
  final _formKey = GlobalKey<FormState>();  
  final _auth = FirebaseAuth.instance;  

  void login() {  
    setState(() {  
      loading = true;  
    });  

    _auth.signInWithEmailAndPassword(  
      email: emailController.text,  
      password: passwordController.text.toString(),  
    ).then((value) {  
      Utils().loastMessage("Welcome back, ${value.user!.email}");  
      Navigator.pushReplacementNamed(context, '/PostScreen');  
      setState(() {  
        loading = false;  
      });  
    }).catchError((error) {  
      setState(() {  
        loading = false;  
      });  

      // Handle various Firebase exceptions  
      if (error is FirebaseAuthException) {  
        switch (error.code) {  
          case 'user-not-found':  
            Utils().loastMessage("No user found for that email.");  
            break;  
          case 'wrong-password':  
            Utils().loastMessage("Wrong password. Please try again.");  
            break;  
          case 'invalid-email':  
            Utils().loastMessage("The email address is badly formatted.");  
            break;  
          case 'too-many-requests':  
            Utils().loastMessage("Too many requests. Please try again later.");  
            break;  
          default:  
            Utils().loastMessage("An error occurred: ${error.message}");  
        }  
      } else {  
        Utils().loastMessage("An unexpected error occurred.");  
      }  
    });  
  }  

  @override  
  void dispose() {  
    emailController.dispose();  
    passwordController.dispose();  
    super.dispose();  
  }  

  @override  
  Widget build(BuildContext context) {  
    return WillPopScope(  
      onWillPop: () async {  
        return true;  
      },  
      child: Scaffold(  
        appBar: AppBar(  
          backgroundColor: Colors.cyan,  
          automaticallyImplyLeading: false,  
          title: Center(child: const Text('Login')),  
        ),  
        body: Padding(  
          padding: const EdgeInsets.symmetric(horizontal: 20),  
          child: SingleChildScrollView(
            child: Column(  
              mainAxisAlignment: MainAxisAlignment.center,  
              crossAxisAlignment: CrossAxisAlignment.center,  
              children: [  
                const SizedBox(height: 50),
                  Image.asset("assets/images/login.gif",height: 250,width: 200,),
            
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
                          } else {  
                            return null;  
                          }  
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
                          } else {  
                            return null;  
                          }  
                        },  
                        obscureText: true,  
                        obscuringCharacter: '*',  
                        controller: passwordController,  
                        decoration: const InputDecoration(  
                          
                          labelText: "Password",  
                          prefixIcon: Icon(Icons.security_outlined),  
                        ),  
                      ),  
                    ],  
                  ),  
                ),  
                const SizedBox(height: 30),  
                RoundButton(  
                  title: "LOGIN",  
                  loading: loading,  
                  ontap: () {  
                    if (_formKey.currentState!.validate()) {  
                      login();  
                    }  
                  },  
                ),  
                const SizedBox(height: 30),  
                Row(  
                  mainAxisAlignment: MainAxisAlignment.center,  
                  children: [  
                    const Text("Don't have an account?", style: TextStyle(fontSize: 16)),  
                    TextButton(  
                      onPressed: () {  
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupScreen()));  
                      },  
                      child: const Text("Sign up", style: TextStyle(fontSize: 16)),  
                    ),  
                  ],  
                ),  
                const SizedBox(height: 30,),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/LoginPhone');
                  },
                  child: Container(
                    height: 50,
                    
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                    child: const Center(
                      child: Text("LOGIN WITH PHONENO", style: TextStyle(fontWeight: FontWeight.w200,
                            color: Colors.black,fontSize: 15),)
                    ),
                  ),
                )
              ],  
            ),
          ),  
        ),  
      ),  
    );  
  }  
}