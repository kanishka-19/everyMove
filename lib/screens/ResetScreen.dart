import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:everymove/screens/welcomeScreen.dart';
import 'package:everymove/constants.dart';
import 'package:google_fonts/google_fonts.dart';
class ResetScreen extends StatefulWidget {
  static const String id= '/reset';

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  late String email;
  final _auth= FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Text(
                  'Forgot Password?',
                  style: GoogleFonts.actor(
                    color: Colors.black,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top:10),
              child: Text(
                'No worries, we\'ll send you reset instructions.',
                style: GoogleFonts.actor(
                  color: Colors.black54,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  fontSize: 15.0, height: 2.5,
                  color: Colors.black87,
                ),

                onChanged: (value) {
                  email= value;
                },
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54),
                  ),
                  hintText: 'Email',
                  hintStyle: TextStyle(
                    color: Colors.black26,
                  ),
                ),
              ),
            ),
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: Reusable(colour: kinActiveColour ,
                onPress: (){
              _auth.sendPasswordResetEmail(email: email);
              Navigator.pop(context);
                },
                text: 'Send Request ',
            Radius: 24.0,
            ),
          )


        ],
      ),
    );
  }
}
