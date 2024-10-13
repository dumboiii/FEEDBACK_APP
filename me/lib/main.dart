import 'package:flutter/material.dart';
  import 'package:firebase_core/firebase_core.dart';
import 'package:me/ui/auth/log.dart';
import 'package:me/ui/auth/phonenologin.dart';
import 'package:me/ui/post/add_post.dart';

import 'package:me/ui/post/post_screen.dart';
import 'package:me/ui/spalashscreen.dart';

void main() async{
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      color: Colors.cyan,
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/LoginScreen': (context) => const LoginScreen(),
        '/PostScreen':(context)=> const PostScreen(),
        '/LoginPhone':(context) => const LoginPhoneNumber(),
        '/AddPost':(context)=> const AddPost(),
      },

      
      home: const SplashScreen(),
    );
  }
}

