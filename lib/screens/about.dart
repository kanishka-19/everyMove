import 'dart:async';
import 'dart:convert';
import 'package:everymove/constants.dart';
import 'package:flutter/material.dart';
import 'package:everymove/screens/welcomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:everymove/screens/playVideo.dart';
import 'package:everymove/screens/welcomeScreen.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pedometer/pedometer.dart';
import 'package:http/http.dart';
import 'package:everymove/Recipe_card.dart';
import 'package:everymove/models/Recipe.dart';
import 'package:everymove/models/recipe.api.dart';
import 'package:everymove/screens/showRecipes.dart';
import 'package:hive/hive.dart';
import 'package:everymove/screens/update_about.dart';

class about extends StatefulWidget {

  @override
  State<about> createState() => _aboutState();
}

class _aboutState extends State<about> {
  late User loggedInUser;
  final _auth= FirebaseAuth.instance;
  late String firstName= 'null';
  late String lastName='null';
  String  Age='null';
  late String Gender='null';
  late String Birthdate='null';
  late String height='null';
  late String weight='null';
  late String user='null';
  late String email='null';

  final DetailsCollection= FirebaseFirestore.instance.collection('Details');
  Future<String?> getCurrentUser() async {
    final user= await _auth.currentUser;
    try {
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
        return(loggedInUser.email);
      }
    } catch(e) {
      print(e);
    }
  }
  Future<void> getFirstName()async {
    final user= await _auth.currentUser;
    try {
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch(e) {
      print(e);
    }
    if(loggedInUser.email!=null){

      await DetailsCollection.where(
          'user', isEqualTo: loggedInUser.email).get().then((QuerySnapshot value) async{
        value.docs.forEach((DocumentSnapshot doc) {
          setState((){
            firstName= doc['firstname'];
            lastName=doc['lastname'];
            Age=doc['Age'];
            Gender=doc['Gender'];
            height=doc['height'];
            weight=doc['weight'];
            Birthdate= doc['Birthdate'];
            email=doc['user'];

          });
        });
      });
    }
  }
@override
  void initState() {
   getFirstName();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset : false,
        body: SingleChildScrollView(
        child: SafeArea(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Text(
                  'About Me',
                  style: GoogleFonts.actor(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Center(
              child: Text("we hope you're enjoying the recipes. ❤️",
                style: GoogleFonts.actor(
                  color: Colors.black54,
                  fontSize: 15.0,
                ),
              ),
            ),
            SizedBox(height: 40,),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.person_pin, color: Colors.blue[700], size: 30,),
                  SizedBox(width: 8,),
                  Container(
                    height: 60,
                    width: 320,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54,),
                      borderRadius: BorderRadius.circular(8),
                    ) ,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10,top: 5),
                          child: Text('First Name', style: TextStyle(color: Colors.black54),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10,top: 6),
                          child: Text(firstName, style: TextStyle(color: Colors.black87),),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.person_pin, color: Colors.blue[700], size: 30,),
              SizedBox(width: 8,),
              Container(
                height: 60,
                width: 320,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54,),
                  borderRadius: BorderRadius.circular(8),
                ) ,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10,top: 5),
                      child: Text('Last Name', style: TextStyle(color: Colors.black54),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10,top: 6),
                      child: Text(lastName, style: TextStyle(color: Colors.black87),),
                    ),
                  ],
                ),
              ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(FontAwesomeIcons.venusMars, color: Colors.red[300] ,size: 25,),
                      SizedBox(width: 18,),
                      Text('Gender',  style: TextStyle(color: Colors.black54),)
                    ],
                  ),


                               Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Container(
                                    height: 30,
                                    width: 160,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.black54),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              color: Gender=='Male' ? Colors.black38: Colors.white,
                                            ),
                                            child: Center(child: Text('Male', style: TextStyle(color: Colors.black12),)),
                                          ),
                                        ),

                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(8),
                                              color: Gender=='Female' ? Colors.black38 : Colors.white,
                                            ),
                                            child: Center(child: Text('Female', style: TextStyle(color: Colors.black12),)),
                                          ),
                                        ),

                ],
              ),
                                  ),
                               ),

                ],
                              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.email, color: Colors.teal[200], size: 26,),
                  SizedBox(width: 10,),
                  Container(
                    height: 60,
                    width: 320,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54,),
                      borderRadius: BorderRadius.circular(8),
                    ) ,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10,top: 5),
                          child: Text('Email', style: TextStyle(color: Colors.black54),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10,top: 6),
                          child: Text(email, style: TextStyle(color: Colors.black87),),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(FontAwesomeIcons.birthdayCake, color: Colors.orange, size: 25,),
                  SizedBox(width: 10,),
                  Container(
                    height: 60,
                    width: 320,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54,),
                      borderRadius: BorderRadius.circular(8),
                    ) ,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10,top: 5),
                          child: Text('Birthdate', style: TextStyle(color: Colors.black54),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10,top: 6),
                          child: Text(Birthdate, style: TextStyle(color: Colors.black87),),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(FontAwesomeIcons.weightScale, color: Colors.deepPurple[300], size: 30,),
                  SizedBox(width: 8,),
                  Container(
                    height: 60,
                    width: 320,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54,),
                      borderRadius: BorderRadius.circular(8),
                    ) ,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10,top: 5),
                          child: Text('Weight (in Kg)', style: TextStyle(color: Colors.black54),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10,top: 6),
                          child: Text(weight, style: TextStyle(color: Colors.black87),),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(FontAwesomeIcons.tape, color: kinActiveColour, size: 26,),
                  SizedBox(width: 10,),
                  Container(
                    height: 60,
                    width: 320,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54,),
                      borderRadius: BorderRadius.circular(8),
                    ) ,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10,top: 5),
                          child: Text('Height (in cm)', style: TextStyle(color: Colors.black54),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10,top: 6),
                          child: Text(height, style: TextStyle(color: Colors.black87),),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // TextButton(
            //     onPressed: (){
            //       Navigator.push(context, MaterialPageRoute(builder: (context)=>
            //           updateAbout(
            //           firstName: firstName,
            //           lastName: lastName,
            //           Gender: Gender,
            //           email: email,
            //           weight: weight,
            //           height: height,
            //           Age: Age,
            //           Birthdate: Birthdate)));
            //     },
            //     child: Text('on click',
            //        style: TextStyle(color: Colors.black),
            //     ),
            // )
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Reusable(
                  colour: kinActiveColour,
                  onPress: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>
                              updateAbout(
                              firstName: firstName,
                              lastName: lastName,
                              Gender: Gender,
                              email: email,
                              weight: weight,
                              height: height,
                              Age: Age,
                              Birthdate: Birthdate)));
                  },
                  text: 'Edit your details'),
            ),
            SizedBox(height: 100,),
          ],
        ),
      ),
    )
    );
  }
}
