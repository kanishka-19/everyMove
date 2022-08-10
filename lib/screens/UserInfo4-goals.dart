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
import 'package:everymove/screens/CaloriesNeeded.dart';


final _firestore= FirebaseFirestore.instance;

class UserInfo4Goals extends StatefulWidget {
  static const String id= '/Goal';
  late String ? firstname;
  late String ? lastname;
  late String ? formatted;
  late DateTime  Datetime;
  late String ? user;
  late var height;
   late var weight;
  late String ? Gender;
  late String ? SelectedWorkout;

  UserInfo4Goals({
    this.firstname,
    this.lastname,
    this.formatted,
    required this.Datetime,
    this.user, this.Gender,
    this.height,
    this.weight,
  this.SelectedWorkout});

  @override
  State<UserInfo4Goals> createState() => _UserInfo4GoalsState();
}

class _UserInfo4GoalsState extends State<UserInfo4Goals> {
  String ? SelectedGoal;
  boxSelection ? SelectedBox;


  double GetCaloriesRequired(var Age){
    double Calories;
    num  ? WorkoutNum= WorkoutDetails[this.widget.SelectedWorkout];
    int ? GoalNum=  GoalsCalories[SelectedGoal];
    print(this.widget.height);
    print(this.widget.weight);
    print(Age);
    print(WorkoutNum);
    print(GoalNum);
   if(this.widget.Gender== 'Female')
     {
       Calories= (655.1 + (9.563 * this.widget.weight) + (1.850 * this.widget.height) -
           (4.676 * Age))* WorkoutNum!.toDouble() + GoalNum!.toDouble();
       print(Calories);
       return Calories;
     }
   else{
     Calories= (66.47 + (13.65 * this.widget.weight) + (5.003* this.widget.height) -
         (6.755 * Age))*  WorkoutNum!.toDouble() + GoalNum!.toDouble();
     print(Calories);
     return Calories;
   }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
            children: [
        SafeArea(
        child: Center(
        child: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Text(
          'About Me',
          style: GoogleFonts.actor(
            color: Colors.black,
            fontSize: 35.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
    ),
                SizedBox(height: 20.0),
                Center(
                child: Text("   So we can get to know you! ❤️",
                style: GoogleFonts.actor(
                color: Colors.black54,
                fontSize: 15.0,
                ),
                ),
                ),
                Padding(
                padding: const EdgeInsets.only(left: 10, top: 40.0,right: 150.0),
                child: Text('Select your Goal',
                style: GoogleFonts.actor(
                color: Colors.blue[700],
                fontSize: 20.0,
                ),
                ),
                ),
              SizedBox(
                width: 360,
                child: WorkoutBox(WorkoutText: Goals[0],
                  BorderColour: SelectedBox == boxSelection.one ?
                  kinActiveColour
                      : Colors.black54,
                  onpress: (){
                    setState(() {
                      SelectedGoal= Goals[0];
                      SelectedBox= boxSelection.one;
                    });
                  },

                ),
              ),
              SizedBox(
                width: 360,
                child: WorkoutBox(WorkoutText: Goals[1],
                  BorderColour: SelectedBox == boxSelection.two ?
                  kinActiveColour
                      : Colors.black54,
                  onpress: (){
                    setState(() {
                      SelectedGoal= Goals[1];
                      SelectedBox= boxSelection.two;
                    });
                  },
                ),
              ),
              SizedBox(
                width: 360,
                child: WorkoutBox(WorkoutText: Goals[2],
                  BorderColour: SelectedBox == boxSelection.three ?
                  kinActiveColour
                      : Colors.black54,
                  onpress: (){
                    setState(() {
                      SelectedGoal= Goals[2];
                      SelectedBox= boxSelection.three;
                    });
                  },
                ),
              ),
    SizedBox(height: 160),
    Padding(
    padding: const EdgeInsets.all(16),
    child: Reusable(colour: kinActiveColour,
    onPress: (){

    _firestore.collection('Details').add({
      'Gender': this.widget.Gender,
      'user': loggedInUser.email,
      'Age': (DateTime.now().year - this.widget.Datetime.year).toString(),
      'weight': this.widget.weight.toString(),
      'firstname': this.widget.firstname,
      'lastname': this.widget.lastname,
      'Birthdate': this.widget.formatted,
      'height': this.widget.height.toString(),

    } );
    double Needed_Calories= GetCaloriesRequired( DateTime.now().year - this.widget.Datetime.year);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>
        CaloriesNeeded(Calories: Needed_Calories.toInt())
      ));

    },
    text: 'Click to continue',
    Radius: 24.0,
    ),
    ),
                ]
                ),

    ),
    );
  }
}
