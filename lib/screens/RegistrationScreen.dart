import 'package:everymove/GoogleSignIn.dart';
import 'package:everymove/screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:everymove/screens/welcomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:everymove/constants.dart';
import 'package:everymove/screens/UserInfo2-gender.dart';
import 'package:everymove/screens/HomePage.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:everymove/screens/UserInfo1-name.dart';


class RegistrationScreen extends StatefulWidget {
  static const String id= '/reg';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool showSpinner= false;
  bool passwordVisible= false;
  final _auth= FirebaseAuth.instance;
  late String Email='null';
  late String password;
  late User loggedInUser;
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount ? _user;

  GoogleSignInAccount get user => _user!;


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

  void CheckUser() {
    if (Email == 'null') {
      Fluttertoast.showToast(
          msg: "Please enter a valid email",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.red,
          fontSize: 16.0
      );
    }

    else {
      _auth.fetchSignInMethodsForEmail(Email).then((value) async {
        if (value.length != 0) {
          Fluttertoast.showToast(
              msg: "User already exists",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.white,
              textColor: Colors.red,
              fontSize: 16.0
          );
        }
        else {
          setState(() {
            showSpinner = true;
          });
          try {
            final newUser = await _auth.createUserWithEmailAndPassword(
                email: Email.trim(), password: password);
            if (newUser != null)
              Navigator.pushNamed(context, UserInfo1Name.id);
            setState(() {
              showSpinner = false;
            });
          } catch (e) {
            print(e);
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
       return ModalProgressHUD(
           inAsyncCall: showSpinner,
           color: kinActiveColour,
           child:Scaffold(
         resizeToAvoidBottomInset: false,
         body: SingleChildScrollView(
           child: Column(
             children: [
               SafeArea(
                 child: Center(
                   child: Padding(
                     padding: const EdgeInsets.only(top: 60.0),
                     child: Text(
                       'Create Account',
                       style: GoogleFonts.actor(
                         color: Colors.black,
                         fontSize: 35.0,
                         fontWeight: FontWeight.bold,
                       ),
                     ),
                   ),
                 ),
               ),
               SizedBox(
                 width: 320.0,
                 // child: Padding(
                 //   padding: const EdgeInsets.only(top: 70.0),
                 //   child: TextField(
                 //     keyboardType: TextInputType.emailAddress,
                 //     style: TextStyle(
                 //       fontSize: 15.0, height: 2.5,
                 //       color: Colors.black87,
                 //     ),
                 //
                 //     onChanged: (value) {
                 //       email = value;
                 //     },
                 //     decoration: InputDecoration(
                 //       enabledBorder: UnderlineInputBorder(
                 //         borderSide: BorderSide(color: Colors.black54),
                 //       ),
                 //       focusedBorder: UnderlineInputBorder(
                 //         borderSide: BorderSide(color: Colors.black54),
                 //       ),
                 //       hintText: 'Name',
                 //       hintStyle: TextStyle(
                 //         color: Colors.black26,
                 //       ),
                 //     ),
                 //   ),
                 // ),
               ),
               SizedBox(
                 width: 320.0,
                 child: Padding(
                   padding: const EdgeInsets.only(top: 50.0),
                   child: TextField(
                     keyboardType: TextInputType.emailAddress,
                     style: TextStyle(
                       fontSize: 15.0, height: 2.5,
                       color: Colors.black87,
                     ),

                     onChanged: (value) {
                       Email = value;
                     },
                     decoration: InputDecoration(
                       enabledBorder: UnderlineInputBorder(
                         borderSide: BorderSide(color: Colors.black54),
                       ),
                       focusedBorder: UnderlineInputBorder(
                         borderSide: BorderSide(color: Colors.black54),
                       ),
                       hintText: 'Email or Phone',
                       hintStyle: TextStyle(
                         color: Colors.black26,
                       ),
                     ),
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
                       password= value;
                     },
                     obscureText: !passwordVisible,
                     decoration: InputDecoration(
                       enabledBorder: UnderlineInputBorder(
                         borderSide: BorderSide(color: Colors.black54),
                       ),
                       focusedBorder: UnderlineInputBorder(
                         borderSide: BorderSide(color: Colors.black54),
                       ),
                       suffixIcon: IconButton(
                         icon: Icon(
                           // Based on passwordVisible state choose the icon
                           passwordVisible
                               ? Icons.visibility
                               : Icons.visibility_off,
                         ),
                         color: Colors.white,
                         onPressed: () {
                           setState(() {
                             passwordVisible = !passwordVisible;
                           });
                         },
                       ),

                       hintText: 'Password',
                       hintStyle: TextStyle(
                         color: Colors.black26,
                       ),
                     ),
                   ),
                 ),
               ),
               SizedBox(height: 80),
               Text('__  Or  __',
                 style: TextStyle(
                   fontSize: 15.0,
                   color: Colors.black26,
                 ),
               ),
               SizedBox(height: 30.0),

               TextButton(
                 onPressed: () async {
                      // final provider = Provider.of<GoogleSignInProvider>(
                      // context, listen: false);
                      // await provider.googleLogin();
                   // print(val);
                   final googleUser= await googleSignIn.signIn();


                   if(googleUser==null)
                     return;
                   _user= googleUser;
                   final googleAuth= await googleUser.authentication;

                   final credential=  GoogleAuthProvider.credential(
                     accessToken: googleAuth.accessToken,
                     idToken: googleAuth.idToken,
                   );
                   await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
                     Navigator.push(this.context,
                         MaterialPageRoute
                           (builder: (context) => UserInfo1Name()));
                   });


                      },
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   mainAxisSize: MainAxisSize.min,
                   children: [
                     CircleAvatar(
                       child: Container(
                           height: 20,
                           // decoration: BoxDecoration(color: Colors.blue),
                           child:
                           Image.network(
                               'http://pngimg.com/uploads/google/google_PNG19635.png',
                               fit: BoxFit.cover
                           )
                       ),
                     ),
                     SizedBox(
                       width: 5.0,
                     ),
                      Text('Sign-up with Google',
                       style: TextStyle(
                         fontSize: 15.0,
                         color: Colors.black54,
                       ),
                     ),
                   ],
                     ),
               ),

               Padding(
                 padding: const EdgeInsets.only(top: 40, left: 8, right: 8),
                 child: Container(
                     margin: const EdgeInsets.all(15.0),
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(8.0)

                     ),
                     child: Row(
                       children: [
                         Expanded(
                           child: Reusable(colour: kinActiveColour,
                               onPress: () async {
                                 CheckUser();
                               },

                               text: 'Sign Up',
                             Radius: 24.0,
                           ),
                         ),
                         SizedBox(width: 10.0),
                         Expanded(
                           child: Reusable(colour: kinActiveColour,
                               onPress: () {
                                 Navigator.pushNamed(context, LoginScreen.id);
                               },
                               text: 'Sign in',
                             Radius: 24.0,
                           ),
                         ),
                       ],
                     )
                 ),
               ),
             ],
           ),
         ),

       )
       );
     }
}