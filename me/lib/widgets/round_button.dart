import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
final String title;
final VoidCallback ontap;
final bool loading;
  const RoundButton({super.key, required this.title,required this.ontap,this.loading=false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.cyan.shade200,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: loading ? CircularProgressIndicator(
            strokeWidth: 4,
            color: Colors.white,
          )   :
          Text(title,
          style:const TextStyle(fontWeight: FontWeight.bold,
          color: Colors.white,fontSize: 20),),
        ) ,
      ),
    );
  }
}