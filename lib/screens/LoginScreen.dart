import 'package:everymove/screens/ResetScreen.dart';
import 'package:everymove/screens/UserInfo2-gender.dart';
import 'package:flutter/material.dart';
import 'package:everymove/screens/welcomeScreen.dart';
import 'package:everymove/screens/RegistrationScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:everymove/constants.dart';
import 'package:everymove/screens/HomePage.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:everymove/GoogleSignIn.dart';
import 'package:provider/provider.dart';
import 'package:everymove/screens/UserInfo1-name.dart';
import 'package:everymove/screens/BottomNavbar.dart';


class LoginScreen extends StatefulWidget {
static const String id= '/login';
@override
_LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth= FirebaseAuth.instance;
  bool showSpinner= false;
  late String email='null';
  late String password;
  bool passwordVisible= false;
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount ? _user;

  GoogleSignInAccount get user => _user!;

  void CheckUser(){
    if(email=='null'){
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
      _auth.fetchSignInMethodsForEmail(email).then((value) async {
        if (value.length != 0) {
          FirebaseFirestore.instance.collection('Details').where(
              'user', isEqualTo: email).get().then((value) async {
            if (value.docs.length != 0) {
              setState(() {
                showSpinner = true;
              });
              final user = await _auth.signInWithEmailAndPassword(
                  email: email.trim(), password: password);
              try {
                if (user != null) {
                  Navigator.pushNamed(context, BottomNavBar.id);
                  setState(() {
                    showSpinner = false;
                  });
                }
              } catch (e) {
                print(e);
              }
            }
            else {
              setState(() {
                showSpinner = true;
              });
              final user = await _auth.signInWithEmailAndPassword(
                  email: email.trim(), password: password);
              try {
                if (user != null) {
                  Navigator.pushNamed(context, UserInfo1Name.id);
                  setState(() {
                    showSpinner = false;
                  });
                }
              } catch (e) {
                print(e);
              }
            }
          });
        }
        else {
          Fluttertoast.showToast(
              msg: "User doesn't exist",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.white,
              textColor: Colors.red,
              fontSize: 16.0
          );
        }
      });
    }
        }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: SingleChildScrollView(
        child: Column(
            children: [
              SafeArea(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60.0),
                    child: Text(' Let\'s sign you in.',
                      style: GoogleFonts.actor(
                          color: Colors.black,
                          fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                    ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Text('     Welcome back.\n You\'ve been missed! ',
                style: GoogleFonts.actor(
                  color: Colors.black54,
                  fontSize: 26.0,
                ),
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
                  color: Colors.black12,
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

          Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: Text('Forgot Password?',
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black54,
                ),
    ),
                  onPressed: (){
                    Navigator.pushNamed(context, ResetScreen.id);
                  },
                ),
              ],

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

              GestureDetector(
                onTap: ()async {
                 //  final provider = Provider.of<GoogleSignInProvider>(
                 //      context, listen: false);
                 //
                 // var val= provider.googleLogin();
                 // print(provider);
                 print('-----------------------');
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
                    await FirebaseAuth.instance.signInWithCredential(credential)
                        .then((val) {
                      FirebaseFirestore.instance.collection('Details').where(
                          'user', isEqualTo: googleUser.email).get().then((
                          value) async {
                        if (value.docs.length != 0) {
                          Navigator.pushNamed(context, HomePage.id);
                        }
                        else
                          Navigator.pushNamed(context, UserInfo1Name.id);
                      });
                    });


                 // if(val!=null){
                 //   Navigator.pushNamed(context, UserInfo2Gender.id);
                 // }
                  print(googleSignIn.currentUser);

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
                            fit:BoxFit.cover
                        )
                    ),
                  ),
                SizedBox(
                  width: 5.0,
                ),
                Text('Sign-in with Google',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black54,
                  ),
                ),
    ], ),
              ),
              SizedBox(height: 40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      'Don\'t have an account? ',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black54,
                    ),
                  ),
                  GestureDetector(
                    child: Text
                      (
                      'Register',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: Colors.black54,
                      ),
                    ),
                    onTap:()
                    {
                      Navigator.pushNamed(context, RegistrationScreen.id);
                    }
                  )
                ],
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                child: Reusable(
                    colour: kinActiveColour,
                    onPress: (){
                 CheckUser();
                    }, text: 'Sign in',
                Radius: 24.0,
                ),
              ),

            ],
          ),
      ),
    );
  }
}