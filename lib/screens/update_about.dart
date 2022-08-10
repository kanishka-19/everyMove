import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
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
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';
import 'package:everymove/constants.dart';
import 'package:horizontal_picker/horizontal_picker.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:everymove/screens/BottomNavbar.dart';



class updateAbout extends StatefulWidget {
 late String firstName;
 late String lastName;
 late String Age;
 late String Gender;
 late String Birthdate;
 late String height;
 late String weight;
 late String email;

 updateAbout({
   required this.firstName,
   required this.lastName,
   required this.Gender,
   required this.email,
   required this.weight,
   required this.height,
   required this.Age,
   required this.Birthdate,
 });


  @override
  State<updateAbout> createState() => _updateAboutState();
}

class _updateAboutState extends State<updateAbout> {

  TextEditingController controller_FN = TextEditingController();
  TextEditingController controller_LN = TextEditingController();
  TextEditingController controller_Age = TextEditingController();
  TextEditingController controller_BD = TextEditingController();
  TextEditingController controller_email = TextEditingController();
  TextEditingController controller_gender = TextEditingController();
  TextEditingController controller_height = TextEditingController();
  TextEditingController controller_weight = TextEditingController();
  String? SelectedChoice ;


  Color birthdateColor= Colors.black26;
  var bday;
  late DateTime Datetime;
 late DateFormat formatter;
 late DateTime newBirthdate;
  late String formatted;
  late User loggedInUser;
  final _auth= FirebaseAuth.instance;
  final DetailsCollection= FirebaseFirestore.instance.collection('Details');


  @override
  void initState() {
    controller_FN.text=this.widget.firstName;
    controller_LN.text=this.widget.lastName;
    controller_Age.text= this.widget.Age;
    controller_BD.text= this.widget.Birthdate;
    controller_email.text= this.widget.email;
    controller_gender.text= this.widget.Gender;
    controller_height.text= this.widget.height;
    controller_weight.text= this.widget.weight;
    bday=widget.Birthdate;
    Datetime = DateTime.parse(bday);
     formatter = DateFormat('yyyy-MM-dd');
     formatted =formatter.format(Datetime);
     SelectedChoice= this.widget.Gender;
    super.initState();
  }
late String id;
  Future<void> getFirstName()async {
    print(Datetime);
    print(this.widget.Birthdate);
    print(formatted);
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
     await DetailsCollection.where( 'user', isEqualTo: loggedInUser.email).get().then((value) {
       value.docs.forEach((element) {
         id=element.id;
         print(element.id);
       });
     });

      await DetailsCollection.doc(id).update({
        'Gender': this.widget.Gender,
        'user': loggedInUser.email,
        'Age': (DateTime.now().year - Datetime.year).toString(),
        'weight': this.widget.weight.toString(),
        'firstname': controller_FN.text,
        'lastname': controller_LN.text,
        'Birthdate':formatted,
        'height': this.widget.height.toString(),

      }).then((value)  {
        Navigator.of(context, rootNavigator: true)
               .pushAndRemoveUntil(
             MaterialPageRoute(
               builder: (BuildContext context) {
                 return BottomNavBar();
               },
             ),
                 (_) => false,
           );
      });


    }

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
                'Update your "about"',
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
            child: Text("we're happy to know if you're \n a little closer to your goal ❤️",
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
                fontSize: 18.0,
              ),
            ),
          ),
          SizedBox(
            width: 320,
            child: TextField(
              controller: controller_FN,
              style: TextStyle(
                fontSize: 15.0, height: 2.5,
                color: Colors.black87,
              ),


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
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 40.0,right: 260.0),
            child: Text('Last Name',
              style: GoogleFonts.actor(
                color: Colors.blue[700],
                fontSize: 18.0,
              ),
            ),
          ),
          SizedBox(
            width: 320,
            child: TextField(
              controller: controller_LN,
              style: TextStyle(
                fontSize: 15.0, height: 2.5,
                color: Colors.black87,
              ),


              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black54),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black54),
                ),
                hintText: 'Enter your Last Name',
                hintStyle: TextStyle(
                  color: Colors.black26,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 30.0,right: 160.0),
            child: Text('Select your Birth Date',
              style: GoogleFonts.actor(
                color: Colors.blue[700],
                fontSize: 18.0,
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
                        formatted= formatter.format(Datetime as DateTime);
                        this.widget.Birthdate= formatted;
                        birthdateColor= Colors.black87;
                      });
                      print(formatted);
                    },
                    child: Text(formatted.toString(),
                      style: TextStyle(
                        fontSize: 15.0, height: 2.5,
                        color: Colors.black87,
                      ),
                    ),

                  ),
                ),
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
                          this.widget.Gender='Male';
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
                          this.widget.Gender='Female';
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
                fontSize: 18.0,
              ),
            ),
          ),
          SizedBox(height: 20.0),
          HorizontalPicker(
            height: 90,
            minValue: 100,
            maxValue: 200,
            divisions: 100,
            showCursor: false,
            backgroundColor: Colors.white12,
            activeItemTextColor: Colors.black87,
            passiveItemsTextColor:Colors.black54,
            onChanged: (value) {
              this.widget.height= value.toString();

            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 20.0,right: 300.0),
            child: Text('Weight',
              style: GoogleFonts.actor(
                color: Colors.blue[700],
                fontSize: 18.0,
              ),
            ),
          ),
          SizedBox(height: 20),
          NumberPicker(
            value: int.parse(this.widget.weight),
            minValue: 30,
            maxValue: 100,
            itemHeight: 40,
            axis: Axis.horizontal,
            onChanged: (value) =>
                setState(() => this.widget.weight=value.toString()),
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
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Reusable(
                colour: kinActiveColour,
                onPress: (){
                  getFirstName();
                },
                text: 'Save your details'),
          ),
          SizedBox(height: 100,),


    ],
        ),
    ),
    )
    );
  }
}
