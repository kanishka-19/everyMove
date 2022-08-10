import 'package:flutter/material.dart';
import 'package:everymove/screens/welcomeScreen.dart';
import 'package:everymove/screens/LoginScreen.dart';
import 'package:everymove/screens/RegistrationScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everymove/screens/HomePage.dart';
import 'package:everymove/screens/UserInfo2-gender.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:everymove/GoogleSignIn.dart';
import 'package:everymove/screens/UserInfo4-goals.dart';
import 'package:everymove/screens/ResetScreen.dart';
import 'package:everymove/screens/UserInfo1-name.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:everymove/screens/UserInfo3-exercise.dart';
import 'package:everymove/screens/UserInfo4-goals.dart';
import 'package:everymove/screens/CaloriesNeeded.dart';
import 'package:everymove/screens/about_us.dart';
import 'package:everymove/screens/about.dart';
import 'package:everymove/screens/BottomNavbar.dart';
import 'package:everymove/screens/playVideo.dart';
import 'package:everymove/screens/showRecipes.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(everyMove());
}

class everyMove extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> GoogleSignInProvider(),
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', 'US'), // English
        ],
        theme: ThemeData.light().copyWith(
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
          ),
          scaffoldBackgroundColor: Colors.white

        ),
        initialRoute: welcomeScreen.id,
        routes: {
          welcomeScreen.id : (context) => welcomeScreen(),
          LoginScreen.id : (context) => LoginScreen(),
          RegistrationScreen.id : (context) => RegistrationScreen(),
          HomePage.id: (context) => HomePage(),
          UserInfo2Gender.id: (context) => UserInfo2Gender(Datetime: DateTime.now(),),
          UserInfo4Goals.id: (context) => UserInfo4Goals(Datetime: DateTime.now(),),
          ResetScreen.id: (context) => ResetScreen(),
          UserInfo1Name.id: (context) => UserInfo1Name(),
          UserInfo3Exercise.id: (context) => UserInfo3Exercise(Datetime: DateTime.now(),),
          CaloriesNeeded.id: (context) => CaloriesNeeded(),
          BottomNavBar.id: (context) => BottomNavBar(),
          PlayVideo.id: (context) => PlayVideo(url: 'none'),
          showRecipes.id: (context) => showRecipes(),


        },
      ),
    );
  }
}