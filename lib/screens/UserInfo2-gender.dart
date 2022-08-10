import 'package:flutter/material.dart';
import 'package:everymove/screens/welcomeScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:everymove/constants.dart';
import 'package:everymove/screens/welcomeScreen.dart';
import 'package:horizontal_picker/horizontal_picker.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:everymove/screens/UserInfo4-goals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:everymove/screens/UserInfo3-exercise.dart';


final _firestore= FirebaseFirestore.instance;
late User loggedInUser;

class UserInfo2Gender extends StatefulWidget {
  late String ? firstname;
  late String ? lastname;
  late String ? formatted;
  late DateTime  Datetime;
  static const String id= '/info2';
  @override
  State<UserInfo2Gender> createState() => _UserInfo2GenderState();
  UserInfo2Gender({this.firstname, this.lastname,  this.formatted, required this.Datetime});
}

class _UserInfo2GenderState extends State<UserInfo2Gender> {
  final _auth= FirebaseAuth.instance;
  double? height;
  int weight=40;
 String? SelectedChoice;


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
          padding: const EdgeInsets.only(left: 10, top: 20.0,right: 300.0),
          child: Text('Gender',
          style: GoogleFonts.actor(
            color:Colors.blue[700],
            fontSize: 20.0,
          ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            margin: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFA49FBE),),
                borderRadius: BorderRadius.circular(24.0)

            ),
            child: Row(
              children: [
                Expanded(
                  child: Reusable(text: 'Male',
                    colour: SelectedChoice== 'Male'
                        ? Colors.black54
                        : kActiveColour,
                    onPress: (){
                      setState(() {
                        SelectedChoice= 'Male';
                      });
                    } ,
                    Radius: 24.0,
                    TextColor: Colors.black12,

                  ),
                ),

                Expanded(
                  child: Reusable(text: 'Female',
                    colour: SelectedChoice== 'Female'
                        ? Colors.black54
                        : kActiveColour,
                    onPress: (){
                      setState(() {
                        SelectedChoice= 'Female';
                      });
                    } ,
                    Radius: 24.0,
                    TextColor: Colors.black12,
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 20.0,right: 300.0),
          child: Text('Height',
            style: GoogleFonts.actor(
              color: Colors.blue[700],
              fontSize: 20.0,
            ),
          ),
        ),
        SizedBox(height: 20.0),
        HorizontalPicker(
          height: 90.0,
          minValue: 100,
          maxValue: 200,
          divisions: 100,
          showCursor: false,
          backgroundColor: Colors.white12,
          activeItemTextColor: Colors.black87,
          passiveItemsTextColor:Colors.black54,
          onChanged: (value) {
            height= value;

          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 20.0,right: 300.0),
          child: Text('Weight',
            style: GoogleFonts.actor(
              color: Colors.blue[700],
              fontSize: 20.0,
            ),
          ),
        ),
        SizedBox(height: 20),
        NumberPicker(
         value: weight,
          minValue: 30,
          maxValue: 100,
          itemHeight: 40,
          axis: Axis.horizontal,
          onChanged: (value) =>
               setState(() => weight=value),
          decoration:
          BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: TextStyle(
            color: Colors.black54,
          ),
          selectedTextStyle: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
          itemWidth: 100,
          itemCount: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 115),
          child: Icon(Icons.arrow_drop_up_outlined,
          color: Colors.black,
          ),
        ),
        SizedBox(height: 40.0),

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
                UserInfo3Exercise(
                  firstname: this.widget.firstname,
                    lastname: this.widget.lastname,
                    formatted: this.widget.formatted,
                    Datetime: this.widget.Datetime,
                  user: loggedInUser.email,
                  Gender: SelectedChoice,
                  height: height,
                  weight: weight,
                )
                ));
              },
              text: 'Click to continue',
            Radius: 24.0,
          ),
        ),



      ],
    ),
    ),
    );
  }
}
