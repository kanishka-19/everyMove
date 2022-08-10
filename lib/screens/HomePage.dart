import 'dart:async';
import 'dart:convert';
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

String formatDate(DateTime d) {
  return d.toString().substring(0, 19);
}



class HomePage extends StatefulWidget {
  static const String id= '/Start';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Recipe> recipes;
  bool isLoading= true;
  int waterGlasses=0;
  late User loggedInUser;
  final _auth= FirebaseAuth.instance;
  late String firstName= 'null';


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
              });
            });

      });
      }
  }


  @override
  void initState() {
   getFirstName();
    // SetUpPedometer();
    super.initState();
   initPlatformState();
  }

  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = '?';


  void onStepCount(StepCount event) {
    print(event);
    setState(() {
      _steps = event.steps.toString();
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  ListView(
            shrinkWrap: true,
          children: [ SafeArea(child:
                  Padding(
                  padding: const EdgeInsets.only(top: 30.0, right: 230,left: 10),
                  child: firstName!= 'null'?
                    Text('Hi, $firstName!',
                     style: GoogleFonts.actor(
                        color: Colors.black,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                    ),): Text('Hi', style: TextStyle(
                    color: Colors.black,
                  ),
                  ),
                    ),
                ),
                    SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.only(right: 100, left: 15),
                      child: Text('Select a workout from below and start your fitness journey.',
                        style: GoogleFonts.actor(
                          color: Colors.black54,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
            SizedBox(height: 40),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 200,
                    width: 400,
                    child: Expanded(
                      child: ListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                        children:<Widget> [
                         Container(
                              height: 190,
                              width: 320,
                              decoration: BoxDecoration(
                                boxShadow: [BoxShadow(
                                  color: Colors.grey.withOpacity(0.5), //color of shadow
                                  spreadRadius: 5, //spread radius
                                  blurRadius: 7, // blur radius
                                  offset: Offset(0, 2), // changes position of shadow
                                  //first paramerter of offset is left-right
                                  //second parameter is top to down
                                ),
                                ],
                                borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                              image: AssetImage(
                              'images/10_min_hiit.jpeg'),
                              fit: BoxFit.fill,
                              ),
                      ),
                         child: GestureDetector(
                            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) =>
              PlayVideo(url: 'https://www.youtube.com/watch?v=xqeEtRuGKXg',)
              ));
              },
                          ),
                        ),

                          SizedBox(width: 20),
                          Container(
                            height: 190,
                            width: 320,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12) ,
                              image: DecorationImage(
                                image: AssetImage(
                                    'images/10_min_fullBody.jpeg'),
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    PlayVideo(url: 'https://www.youtube.com/watch?v=CUNwlVnrStc',)
                                ));
                              },
                            ),
                          ),
                          SizedBox(width: 20),
                          Container(
                            height: 190,
                            width: 320,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12) ,
                              image: DecorationImage(
                                image: AssetImage(
                                    'images/15_min_arms.jpeg'),
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    PlayVideo(url: 'https://www.youtube.com/watch?v=X6gWQ1Lcvjg&t=379s',)
                                ));
                              },
                            ),
                          ),
    ]
            ),
                    ),
                  ),
                ),
            Expanded(
              child: GestureDetector(
                onTap: ()
                {
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>
                      showRecipes()
                  ));
                },
                child: Container(
                  child: RecipeCard(
                    title: 'My Recipe',
                    cookTime: '30 mins',
                    rating: '4.3',
                    thumbnailUrl: 'https://lh3.googleusercontent.com/ei5eF1LRFkkcekhjdR_8XgOqgdjpomf-rda_vvh7jIauCgLlEWORINSKMRR6I6iTcxxZL9riJwFqKMvK0ixS0xwnRHGMY4I5Zw=s360',

                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                        height: 160,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius: BorderRadius.circular(16),
                          boxShadow:[ BoxShadow(
                            color: Colors.grey.withOpacity(0.5), //color of shadow
                            spreadRadius: 5, //spread radius
                            blurRadius: 7, // blur radius
                            offset: Offset(0, 2), // changes position of shadow
                            //first paramerter of offset is left-right
                            //second parameter is top to down
                          )
                          ]
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                    RawMaterialButton(
                                    fillColor: Colors.grey,
                                    shape: CircleBorder(),
                                    constraints: BoxConstraints(
                                    minHeight: 20,
                                    minWidth: 20
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Icon( FontAwesomeIcons.minus,
                                      size: 10,
                                      color: Colors.white,
                                      ),
                                    ),
                                    onPressed: (){
                                      setState(() {
                                        waterGlasses--;
                                      });
                                    },
                                    ),

                                CircularPercentIndicator(
                                   radius: 30,
                                 center: Icon(FontAwesomeIcons.glassWater,
                                 color: Colors.blue[300],
                                 size: 20,),
                                 progressColor: Colors.blue.shade300,
                                 backgroundColor: Colors.grey.shade300,
                                 percent: (waterGlasses/7) <1 ? (waterGlasses/7): 1,
                                 animation: true,
                                 animationDuration: 800,
                                  circularStrokeCap: CircularStrokeCap.round,
                                  animateFromLastPercent: true,
                                  onAnimationEnd: (){
                                     setState(){
                                       waterGlasses=0;
                                     }
                                  },

                               ),
                                RawMaterialButton(
                                  fillColor: Color(0xFF4C4F5E),
                                  shape: CircleBorder(),
                                  constraints: BoxConstraints(
                                      minHeight: 20,
                                      minWidth: 20
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Icon( FontAwesomeIcons.plus,
                                      size: 10,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: (){
                                    setState(()
                                        {
                                          waterGlasses++;
                                        });
                                  },
                                ),

                            ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Center(child: Text(waterGlasses==0? 'Drink 7 glasses' : '$waterGlasses of 7',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                              ),
                              ),
                              ),
                            ),
                            Center(child: Text(waterGlasses==0? 'of water' : 'Glasses',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 10.0,
                              ),
                            ),
                            )
                          ],
                        ),
                      ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 160,
                      width: 30,
                      decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius: BorderRadius.circular(16),
                          boxShadow:[ BoxShadow(
                            color: Colors.grey.withOpacity(0.5), //color of shadow
                            spreadRadius: 5, //spread radius
                            blurRadius: 7, // blur radius
                            offset: Offset(0, 2), // changes position of shadow
                            //first paramerter of offset is left-right
                            //second parameter is top to down
                          )
                          ]
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // RawMaterialButton(
                              //   fillColor: Colors.grey,
                              //   shape: CircleBorder(),
                              //   constraints: BoxConstraints(
                              //       minHeight: 20,
                              //       minWidth: 20
                              //   ),
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(3.0),
                              //     child: Icon( FontAwesomeIcons.minus,
                              //       size: 10,
                              //       color: Colors.white,
                              //     ),
                              //   ),
                              //   onPressed: (){
                              //     setState(() {
                              //       waterGlasses--;
                              //     });
                              //   },
                              // ),

                              CircularPercentIndicator(
                                radius: 30,

                                center: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(FontAwesomeIcons.personWalking,
                                        color: Colors.teal[600],
                                        size: 20,),
                                    ),
                                    Text(_steps,
                                    style: TextStyle(color: Colors.black, fontSize: 5),),

                                  ],
                                ),
                                progressColor: Colors.teal[600],
                                backgroundColor: Colors.grey.shade300,
                                percent: (waterGlasses/7) < 1? (waterGlasses/7): 1,
                                animation: true,
                                animationDuration: 800,
                                circularStrokeCap: CircularStrokeCap.round,
                                animateFromLastPercent: true,

                                onAnimationEnd: (){
                                  setState(){
                                    waterGlasses=0;
                                  }
                                },

                              ),
                              // RawMaterialButton(
                              //   fillColor: Color(0xFF4C4F5E),
                              //   shape: CircleBorder(),
                              //   constraints: BoxConstraints(
                              //       minHeight: 20,
                              //       minWidth: 20
                              //   ),
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(3.0),
                              //     child: Icon( FontAwesomeIcons.plus,
                              //       size: 10,
                              //       color: Colors.white,
                              //     ),
                              //   ),
                              //   onPressed: (){
                              //     setState(()
                              //     {
                              //       waterGlasses++;
                              //     });
                              //   },
                              // ),

                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Center(child: Text(waterGlasses==0? 'Drink 7 glasses' : '$waterGlasses of 7',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                              ),
                            ),
                            ),
                          ),
                          Center(child: Text('of water',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 10.0,
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
            SizedBox(height: 50),


                    ]
                  ),
              );
            }
          }
