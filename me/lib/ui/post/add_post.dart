import 'package:flutter/material.dart';
import 'package:me/utils/utils.dart';
import 'package:me/widgets/round_button.dart';
import 'package:firebase_database/firebase_database.dart';
class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
bool loading=false;
  final Databaseref=FirebaseDatabase.instance.ref("APP DEV");//iss ki wajah se firebase me ek table/node ban jayega
  final postcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Post',style: 
        TextStyle(fontWeight: FontWeight.w600,color: Colors.blueGrey),),
        backgroundColor: Colors.cyan.shade300,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
          const  Text("Say Whatever you want to?",style: TextStyle(
            fontSize: 20,fontWeight: FontWeight.w600,color: Colors.blueGrey),),
          
            const SizedBox(
              height: 30,
            ),

             TextFormField(
              controller: postcontroller,
              maxLines: 5,
                decoration: InputDecoration(
                  labelText: "Whats in your mind?",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                ),
              ),
            
            const SizedBox(height: 30,),
            RoundButton(title: "ADD",
            loading: loading,
             ontap: (){
                if (postcontroller.text .isEmpty) {
                    Utils().loastMessage("Write something");
                  loading=false;
                }
     else{
              setState(() {
                loading=true;
              });
              Databaseref.child(DateTime.now().millisecondsSinceEpoch.toString()).set({
                "title": postcontroller.text.toString()
              }).then((value) {
                setState(() {
                  loading=false;
                });
                  Utils().loastMessage("POST ADDED");
                  postcontroller.clear();
              }).onError((error, stackTrace) {
                setState(() {
                  loading=false;
                });
                Utils().loastMessage(error.toString());
              });
            }
          }
            )
          ]
        ),
      ),
    );
  }
}