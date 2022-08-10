import 'package:flutter/material.dart';

class aboutUs extends StatefulWidget {


  @override
  State<aboutUs> createState() => _aboutUsState();
}

class _aboutUsState extends State<aboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text('about',
        style: TextStyle(
          color: Colors.black,
        ),),
      ),
    );
  }
}
