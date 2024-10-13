import 'dart:async';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:me/ui/auth/log.dart';
import 'package:me/ui/post/post_screen.dart';

class SplashServices{


  void login(BuildContext context){
    final auth =FirebaseAuth.instance;
    final user= auth.currentUser;
    if(user!=null){
       Timer(const Duration(seconds: 5), () { 
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const PostScreen()));
    });
    }
    else{
       Timer(const Duration(seconds: 5), () { 
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
    });
    }
   
  }
}