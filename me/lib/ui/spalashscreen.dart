import 'package:flutter/material.dart';
import 'package:me/firebase_services/splash_services.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 SplashServices splashservices =SplashServices();
  
  void initState() {
    // TODO: implement initState
    super.initState();
    splashservices.login(context);
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  Center(

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Image.asset("assets/images/splash.gif",height: 700,width: 400,),
            const SizedBox(height: 30,),
            
            ]),
          ),
        ),
      
    );
  }
}