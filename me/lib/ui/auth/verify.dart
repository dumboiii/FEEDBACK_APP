import 'package:flutter/material.dart';

class VerifyScreen extends StatefulWidget {
 final String verification;
   const VerifyScreen({super.key, required this.verification});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VERIFY'),
      ),
      body: Column(
        children: [
          
        ]
      ),
    );
  }
}