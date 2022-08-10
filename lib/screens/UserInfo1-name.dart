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


final _firestore= FirebaseFirestore.instance;
late User loggedInUser;

class UserInfo1Name extends StatefulWidget {
  static const String id= 'info1';

  @override
  State<UserInfo1Name> createState() => _UserInfo1NameState();
}

class _UserInfo1NameState extends State<UserInfo1Name> {
  Color birthdateColor= Colors.black26;
 DateTime Datetime = DateTime.now();
 DateFormat formatter = DateFormat('yyyy-MM-dd');
  late String formatted =formatter.format(Datetime);
 String ? firstName;
 String ? lastName;
 final _auth= FirebaseAuth.instance;

 @override
 void initState() {
   super.initState();
   getCurrentUser();
 }


 void getCurrentUser() async {
   final user= await _auth.currentUser;
   try {
     if (user != null) {
       loggedInUser = user;
       print(loggedInUser.email);
     }
   } catch(e) {
     print(e);
   }
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child:Column(
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
                padding: const EdgeInsets.only(left: 10, top: 40.0,right: 260.0),
                child: Text('First Name',
                  style: GoogleFonts.actor(
                    color: Colors.blue[700],
                    fontSize: 20.0,
                  ),
                ),
              ),
              SizedBox(
                width: 320.0,
                child: Padding(
                  padding: const EdgeInsets.only(),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      fontSize: 15.0, height: 2.5,
                      color: Colors.black87,
                    ),

                    onChanged: (value) {
                      firstName = value;
                    },
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54),
                      ),
                      hintText: 'Enter your first name',
                      hintStyle: TextStyle(
                        color: Colors.black26,
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 10, top: 30.0,right: 260.0),
                child: Text('Last Name',
                  style: GoogleFonts.actor(
                    color: Colors.blue[700],
                    fontSize: 20.0,
                  ),
                ),
              ),
              SizedBox(
                width: 320.0,
                child: Padding(
                  padding: const EdgeInsets.only(),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      fontSize: 15.0, height: 2.5,
                      color: Colors.black87,
                    ),

                    onChanged: (value) {
                      lastName = value;
                    },
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54),
                      ),
                      hintText: 'Enter your last name',
                      hintStyle: TextStyle(
                        color: Colors.black26,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 30.0,right: 160.0),
                child: Text('Select your Birth Date',
                  style: GoogleFonts.actor(
                    color: Colors.blue[700],
                    fontSize: 20.0,
                  ),
                ),
              ),

              SizedBox(
                width: 320.0,
                child: Padding(
                  padding: const EdgeInsets.only(),
                  child:Container(
                      decoration: BoxDecoration(
                        border: Border(
                        bottom: BorderSide(width: 0.5,)
                        ),
                        ),
                                        child: Padding(
                      padding: const EdgeInsets.only(right: 150),
                      child: TextButton(
                            onPressed: ()async {
                             DateTime? newDateTime = await showRoundedDatePicker(
                                context: this.context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(DateTime.now().year - 90),
                                lastDate: DateTime(DateTime.now().year+1),
                                borderRadius: 16,
                                imageHeader:AssetImage('images/calenderImage.jpeg')as ImageProvider,
                                theme: ThemeData(
                                  primaryColor: kinActiveColour,
                                ),
                                styleDatePicker: MaterialRoundedDatePickerStyle(
                                  decorationDateSelected: BoxDecoration(
                                    color: kinActiveColour,
                                    shape: BoxShape.circle,
                                  ),
                                  textStyleButtonPositive: TextStyle(
                                    color: kinActiveColour
                                  ),
                                  textStyleButtonNegative: TextStyle(
                                    color: kinActiveColour
                                  ),
                                ),
                                styleYearPicker: MaterialRoundedYearPickerStyle(
                                  textStyleYearSelected: TextStyle(
                                    color: kinActiveColour,
                                  ),

                                ),
                              );
                              setState(() {
                                Datetime= newDateTime as DateTime;
                               formatted= formatter.format(newDateTime as DateTime);
                               birthdateColor= Colors.black87;
                              });
                              print(formatted);
                            },
                          child: Text(formatted.toString(),
                          style: TextStyle(
                            fontSize: 15.0, height: 2.5,
                            color: birthdateColor,
                          ),
    ),

                        ),
                    ),
                  ),
                  ),
                ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Reusable(
                    colour: kinActiveColour,
                    onPress: (){
                      // _firestore.collection('Details').add({
                      //   'firstname': firstName,
                      //   'lastname': lastName,
                      //   'Age': Datetime.year - DateTime.now().year,
                      //   'birthdate': formatted,
                      // } );
                      Navigator.push(this.context, MaterialPageRoute( builder: (context) => UserInfo2Gender(
                          firstname: firstName,
                          lastname: lastName,
                          formatted: formatted,
                        Datetime: Datetime,),
                      ),
                      );

                    },
                    text: 'Click to continue'),
              )
    ]
    ),
    ),

    );
  }
}

