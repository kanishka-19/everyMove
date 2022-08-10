import 'package:everymove/screens/HomePage.dart';
import 'package:everymove/screens/UserInfo4-goals.dart';
import 'package:everymove/screens/UserInfo2-gender.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:everymove/constants.dart';
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:everymove/screens/welcomeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:everymove/screens/UserInfo3-exercise.dart';
import 'package:everymove/screens/BottomNavbar.dart';


class CaloriesNeeded extends StatefulWidget {
  static const String id= '/Calories';

  late int ? Calories;
  CaloriesNeeded({this.Calories});

  @override
  State<CaloriesNeeded> createState() => _CaloriesNeededState();
}

class _CaloriesNeededState extends State<CaloriesNeeded> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Text(
                  'Welcome!',
                  style: GoogleFonts.actor(
                    color: Colors.black,
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Center(
              child: Text(" Your custom plan is ready and you're one step \n              closer to a healthier Lifestyle.",
                style: GoogleFonts.actor(
                  color: Colors.black54,
                  fontSize: 15.0,
                ),
              ),
            ),
            SizedBox(height: 50.0),
            Center(
              child: Text(" Your daily net calorie goal is:",
                style: GoogleFonts.actor(
                  color: Colors.black54,
                  fontSize: 15.0,
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Padding(
                padding: const EdgeInsets.only(left: 10, top: 30.0),
                child: Text(this.widget.Calories.toString(),
                  style: TextStyle(
                    color: Colors.blue[700],
                    fontSize: 30.0,
                  ),
                ),
              ),
                SizedBox(width: 10.0),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Text(" Calories",
                    style: GoogleFonts.actor(
                      color: Colors.black54,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ]
            ),
            SizedBox(height: 300),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Reusable(
                  colour: kinActiveColour,
                  onPress: (){
                    Navigator.pushNamed(context, BottomNavBar.id);

                  },
                  text: 'Click to continue'),
            )
          ],
        )
      ),
    );
  }
}
