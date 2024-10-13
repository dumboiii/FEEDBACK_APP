import 'package:firebase_auth/firebase_auth.dart';  

import 'package:flutter/material.dart';
import 'package:me/utils/utils.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Screen',style: 
        TextStyle(fontWeight: FontWeight.w600,color: Colors.blueGrey),),
        actions: [
          IconButton(onPressed: (){
            auth.signOut().then((value) {
              Navigator.pushReplacementNamed(context, '/LoginScreen');
            }).onError((error, stackTrace)  {
              Utils().loastMessage(error.toString());
            });          
          }, icon:const Icon(Icons.logout_outlined,color: Colors.blueGrey,)),
       const   SizedBox(width: 20,),
        ],
        backgroundColor: Colors.cyan.shade300,
      ),
      floatingActionButton: FloatingActionButton(
        child:const Icon(Icons.add),
        onPressed: (){
          Navigator.pushNamed(context, '/AddPost');
        })
      
      ,
      body: const Center(child:Text("Click below for writing any doubts")),
    ) ;
  }
}