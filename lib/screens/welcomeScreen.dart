import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:everymove/models/nutrients_model.dart';
import 'package:everymove/screens/LoginScreen.dart';
import 'package:everymove/screens/RegistrationScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:everymove/constants.dart';
import 'package:oauth2_client/oauth2_client.dart';

import '../models/Foodapi.dart';
import '../models/measures.dart';

enum Choice{
  Login,
  Register,
}

class  welcomeScreen extends StatefulWidget {
  static const String id= '/welcome';
  @override
  State<welcomeScreen> createState() => _State();
}

class _State extends State<welcomeScreen> {

  Choice? SelectedChoice;
  var accesstoken='';
//   void getAccessToken()async{
//     final String apiUrl = "https://oauth.fatsecret.com/connect/token";
//
//
//     Map<String, dynamic> map = {
//       'grant_type': 'client_credentials',
//       'scope' : 'basic',
//     };
//     // Map<String, dynamic> map2 = {
//     //
//     //  'user' : '8dd405fefc1f4dbdb659aa0b7444caa2',
//     //   'password' : 'ebe1f7811f81499d9842a029a36e1583'
//     // };
//     String user='8dd405fefc1f4dbdb659aa0b7444caa2';
//     String pass='0ce9a1b6a56d43bca33960edc6fb8570';
//     var dio = Dio();
//     // FormData formdata2 = new FormData.fromMap(map2);
//     // var byteArray = Encoding.ASCII.GetBytes("YOUR_CLIENT_ID:YOUR_CLIENT_SECRET");
//     // client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Basic", Convert.ToBase64String(byteArray));
//
//
//     String basicAuth =
//         'Basic ' + base64.encode(utf8.encode('$user:$pass'));
//     print(basicAuth);
//     dio.options.headers['content-type']='application/x-www/form/urlencoded';
//       dio.options.headers['authorization']=basicAuth;
//     try {
//       FormData formdata = new FormData.fromMap(map);
//       var response = await dio.post(apiUrl, data: formdata,
//
//       );
// print(response);
//       var data = jsonDecode(response.toString());
//
//       accesstoken=data['access_token'];
//       print('----------');
//       recipes(accesstoken);
//       // print(accesstoken);
//     }catch(e){
//       print(e);
//     }
//   }
  // void recipes(String accesstoken)async{
  //   HttpClient httpClient = new HttpClient();
  //   final String apiUrl = "https://platform.fatsecret.com/rest/server.api?method=recipe.get&format=json&Address=103.16.30.240&recipe_id=91";
  //   HttpClientRequest request = await httpClient.getUrl(Uri.parse(apiUrl));
  //   request.headers.set('content-type', 'application/json');
  //   request.headers.set('Authorization', 'Bearer ${accesstoken}');
  //   HttpClientResponse response = await request.close();
  //   response.transform(utf8.decoder).listen((contents) {
  //     print('Reached');
  //     print(contents);
  //   });
  // }
  void logLongString(String s) {
    if (s == null || s.length <= 0) return;
    const int n = 1000;
    int startIndex = 0;
    int endIndex = n;
    while (startIndex < s.length) {
      if (endIndex > s.length) endIndex = s.length;
      print(s.substring(startIndex, endIndex));
      startIndex += n;
      endIndex = startIndex + n;
    }
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 10.0,right: 5.0, left: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ) ,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                      'images/new.webp'),
                ),
              ),
            ),
            SizedBox(height: 50.0),
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    Center(
                      child: Text("      Reach your\n health goals Here",
                        style: GoogleFonts.actor(
                          color: Colors.black,
                          fontSize: 28.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Center(
                      child: Text("   Ensure customized Diet plans, workouts\n and much more based on your fitness goal.",
                        style: GoogleFonts.actor(
                          color: Colors.black54,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 60.0),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        margin: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white,),
                            borderRadius: BorderRadius.circular(8.0)

                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Reusable(text: 'Register',
                                colour: SelectedChoice== Choice.Register
                                    ? kActiveColour
                                    : kinActiveColour,
                                onPress: (){
                                  setState(() {
                                    SelectedChoice= Choice.Register;
                                  });
                                   Navigator.pushNamed(this.context, RegistrationScreen.id);
                                  setState(() {
                                    SelectedChoice= null;
                                  });
                                } ,
                                Radius: 24.0,

                              ),
                            ),
                            SizedBox(width: 10.0),
                            Expanded(
                              child: Reusable(text: 'Login',
                                colour: SelectedChoice== Choice.Login
                                    ? kActiveColour
                                    : kinActiveColour,
                                onPress: (){


                                  setState(() {
                                    SelectedChoice= Choice.Login;
                                  });
                                  Navigator.pushNamed(this.context, LoginScreen.id);
                                  setState(() {
                                    SelectedChoice= null;
                                  });
                                } ,
                                Radius: 24.0,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Reusable extends StatelessWidget {

  late final String text;
  Color TextColor;
  final VoidCallback? onPress;
  late final Color colour;
  late  double Radius;
  Reusable({required this.colour, required this.onPress, required this.text, this.Radius= 16.0, this.TextColor=Colors.black87});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colour,
          borderRadius: BorderRadius.circular(Radius)
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          primary: colour,
        ),
          onPressed: onPress,
          child: Expanded(
            child: Center(
              child: Text(text,
                style: TextStyle(
                  color: TextColor,
                ),
              ),
            ),
          ),
      ),
    );
  }
}
