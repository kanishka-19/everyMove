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




class UserInfo3Exercise extends StatefulWidget {

  static const String id= '/info3';
  late String ? firstname;
  late String ? lastname;
  late String ? formatted;
  late DateTime  Datetime;
  late String ? user;
  late double ?  height;
  late int?  weight;
  late String ? Gender;

  UserInfo3Exercise({
    this.firstname,
    this.lastname,
    this.formatted,
    required this.Datetime,
    this.user, this.Gender,
    this.height,
    this.weight});



  @override
  State<UserInfo3Exercise> createState() => _UserInfo3ExerciseState();
}

class _UserInfo3ExerciseState extends State<UserInfo3Exercise> {
  boxSelection ? SelectedBox;
  late String ? WorkoutText;
  String ? SelectedWorkout;
  void PrintDic(){
    print(WorkoutDetails['Moderately active (exercise 3-5 days/week)']);
    print(Workout[3]);
    print(WorkoutDetails[Workout[0]]);
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
              child: Text('Select your activity level',
              style: GoogleFonts.actor(
              color: Colors.blue[700],
              fontSize: 20.0,
              ),
              ),
              ),

              SizedBox(
                width: 360,
                child: WorkoutBox(WorkoutText: Workout[0],
                  BorderColour: SelectedBox == boxSelection.one ?
                  kinActiveColour
                      : Colors.black54,
                  onpress: (){
                  setState(() {
                    SelectedWorkout= Workout[0];
                    SelectedBox= boxSelection.one;
                  });
                  },

                ),
              ),

         SizedBox(
           width: 360,
           child:WorkoutBox(WorkoutText: Workout[1],
             BorderColour: SelectedBox == boxSelection.two ?
             kinActiveColour
                 : Colors.black54,
             onpress: (){
               setState(() {
                 SelectedWorkout= Workout[1];
                 SelectedBox= boxSelection.two;
               });
             },

           ),
         ),

         SizedBox(
           width: 360,
           child: WorkoutBox(WorkoutText: Workout[2],
             BorderColour: SelectedBox == boxSelection.three ?
             kinActiveColour
                 : Colors.black54,
             onpress: (){
               setState(() {
                 SelectedWorkout= Workout[2];
                 SelectedBox= boxSelection.three;
               });
             },

           ),
         ),

         SizedBox(
           width: 360,
           child: WorkoutBox(WorkoutText: Workout[3],
             BorderColour: SelectedBox == boxSelection.four ?
             kinActiveColour
                 : Colors.black54,
             onpress: (){
               setState(() {
                 SelectedWorkout= Workout[3];
                 SelectedBox= boxSelection.four;
               });
             },

           ),
         ),

         SizedBox(
           width: 360,
           child: WorkoutBox(WorkoutText: Workout[4],
             BorderColour: SelectedBox == boxSelection.five ?
             kinActiveColour
                 : Colors.black54,
             onpress: (){
               setState(() {
                 SelectedWorkout= Workout[4];
                 SelectedBox= boxSelection.five;
               });
             },

           ),
         ),
         Padding(
           padding: const EdgeInsets.all(16),
           child: Reusable(colour: kinActiveColour,
             onPress: (){
               // _firestore.collection('Details').add({
               //   'Gender': SelectedChoice,
               //   'user': loggedInUser.email,
               //   'Age': DateTime.now().year - this.widget.Datetime.year,
               //   'weight': weight,
               //   'firstname': this.widget.firstname,
               //   'lastname': this.widget.lastname,
               //   'Birthdate': this.widget.formatted,
               // } );
               Navigator.push(context, MaterialPageRoute(builder: (context)=>
                   UserInfo4Goals(
                     firstname: this.widget.firstname,
                     lastname: this.widget.lastname,
                     formatted: this.widget.formatted,
                     Datetime: this.widget.Datetime,
                     user: loggedInUser.email,
                     Gender: this.widget.Gender,
                     height: this.widget.height,
                     weight: this.widget.weight,
                     SelectedWorkout: SelectedWorkout,
                       )
               ));
             },
             text: 'Click to continue',
             Radius: 24.0,
           ),
         ),
       ],
     )

    ),
    );
  }
}

class WorkoutBox extends StatelessWidget {
  late VoidCallback onpress;
  final String WorkoutText;
  late Color BorderColour;
  WorkoutBox({required this.WorkoutText, required this.onpress, required this.BorderColour});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Container(

        margin: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            border: Border.all(color: BorderColour),
          borderRadius: BorderRadius.circular(4)

        ),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: TextButton(
          onPressed: onpress,

          child: Text(WorkoutText,
          style: TextStyle(
            color: Colors.black87,
          ),
          ),
          ),
      ),
                  ),
    );
  }
}
