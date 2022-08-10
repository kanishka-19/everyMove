import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:everymove/models/nutrients_model.dart';
import 'package:everymove/screens/LoginScreen.dart';
import 'package:everymove/screens/RegistrationScreen.dart';
import 'package:everymove/screens/webPage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:everymove/constants.dart';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:everymove/constants.dart';


import '../models/Foodapi.dart';
import '../models/measures.dart';

class Nutrition extends StatefulWidget {

  @override
  State<Nutrition> createState() => _NutritionState();
}

class _NutritionState extends State<Nutrition> {
  // final List<String> items = [
  //   'Whole',
  //   'Serving',
  //   'Gram',
  //   'Ounce',
  //   'Pound',
  //   'Kilogram',
  //   'Millilitre',
  // ];
  bool appRun= false;

 late Measure selectedValue ;

  List<FoodApi> allresults=[];

 late String search;
  void getNutrition(search)async{
    print('Reached');
    HttpClient httpClient = new HttpClient();
    httpClient.badCertificateCallback =
    ((X509Certificate cert, String host, int port) => true);
    final String apiUrl = 'https://api.edamam.com/api/food-database/v2/parser?app_id=82565b7c&app_key=356a53277e736838222b33480aa50964&ingr=$search';
    HttpClientRequest request = await httpClient.getUrl(Uri.parse(apiUrl));
    request.headers.set('content-type', 'application/json');

    HttpClientResponse response = await request.close();

    response.transform(Utf8Decoder()).transform(LineSplitter()).listen((contents) {
      // logLongString(contents);
      List<Measure>mes=[];
      var data=jsonDecode(contents);
      setState((){
        allresults.clear();
      });
      for (var d in data['hints']) {
        mes.clear();
        if (d['food']['categoryLabel'] == 'meal') {
          for (var e in d['measures']) {
            setState(() {
              mes.add(Measure(
                  uri: e['uri'],
                  weight: e['weight'],
                  label: e['label']

              ));
            });
          }

          setState(() {
            allresults.add(FoodApi(
                foodid: d['food']['foodId'],
                label: d['food']['label'],
                nur: Nutrients(
                    energy: d['food']['nutrients']["ENERC_KCAL"],
                    protein: d['food']['nutrients']["PROCNT"],
                    fat: d['food']['nutrients']["FAT"],
                    carbs: d['food']['nutrients']["CHOCDF"],
                    fibre: d['food']['nutrients']["FIBTG"]
                ),
                measures: mes
            ));

          });
        }

      }
      print(allresults.length);
      print(allresults[0].measures.length);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch ,
            children: [ SafeArea(
        child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: TextField(
          onChanged: (value){
            setState(() {
              search = value;
            });
          },
          decoration: InputDecoration(
            suffixIcon: IconButton(onPressed: (){
              getNutrition(search);
              setState((){
                appRun=true;
              });
             },
              icon: Icon(Icons.search),),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
            ),
            hintText: 'Search for nutrition analysis',
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ),
    ),
    SizedBox(height: 20,),
              Column(
                children: [
                  Container(
                    height: 750,
                    width: 500,
                    child: ListView.builder(
                        shrinkWrap: true,
                      itemCount: allresults.length,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (context,i){
                      final x= allresults[i];
                      selectedValue=x.measures[0];
                      return Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                        child: Container(
                          height: 170,
                          width: 480,
                          decoration: BoxDecoration(
                            color: Colors.white,

                            borderRadius: BorderRadius.circular(8),
                              boxShadow:[ BoxShadow(
                                color: Colors.grey.withOpacity(0.5), //color of shadow
                                spreadRadius: 3, //spread radius
                                blurRadius: 2, // blur radius
                              )
                              ]
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                           children: [

                             Padding(
                               padding: const EdgeInsets.only(top: 15,left: 10),
                               child: Text(x.label,style: GoogleFonts.actor(
                                 color: kinActiveColour,
                                 fontSize: 18.0,
                                 fontWeight: FontWeight.bold
                               ),),
                             ),
                             SizedBox(height: 10),
                             Padding(
                               padding: const EdgeInsets.only(left: 8, right: 8),
                               child: Row(
                                 children: [
                                   Row(
                                     children: [
                                       Icon(FontAwesomeIcons.fish,
                                           color: Colors.black38,
                                       size: 15,),
                                       Text(' Protein: ', style: TextStyle(color: Colors.black38, fontSize: 10),),
                                       Text(double.parse(x.nur.protein.toString()).toStringAsFixed(2), style: TextStyle(color: Colors.black38, fontSize: 12),)
                                     ],
                                   ),
                                   Padding(
                                     padding: const EdgeInsets.only(left: 5),
                                     child: Row(
                                       children: [
                                         Icon(FontAwesomeIcons.wheatAwn,
                                           color: Colors.black38,
                                           size: 15,),
                                         Text(' Fibre: ', style: TextStyle(color: Colors.black38, fontSize: 10),),
                                         Text(double.parse(x.nur.fibre.toString()).toStringAsFixed(2), style: TextStyle(color: Colors.black38, fontSize: 12),)
                                       ],
                                     ),
                                   ),
                                   Padding(
                                     padding: const EdgeInsets.only(left: 5),
                                     child: Row(
                                       children: [
                                         Icon(FontAwesomeIcons.cheese,
                                           color: Colors.black38,
                                           size: 15,),
                                         Text(' Fat: ', style: TextStyle(color: Colors.black38, fontSize: 10),),
                                         Text(double.parse(x.nur.fat.toString()).toStringAsFixed(2), style: TextStyle(color: Colors.black38, fontSize: 12),)
                                       ],
                                     ),
                                   ),
                                   Padding(
                                     padding: const EdgeInsets.only(left: 5),
                                     child: Row(
                                       children: [
                                         Icon(FontAwesomeIcons.breadSlice,
                                           color: Colors.black38,
                                           size: 15,),
                                         Text(' Carbs: ', style: TextStyle(color: Colors.black38, fontSize: 10),),
                                         Text(double.parse(x.nur.carbs.toString()).toStringAsFixed(2), style: TextStyle(color: Colors.black38, fontSize: 12),)
                                       ],
                                     ),
                                   ),

                                 ],
                               ),
                             ),
                             SizedBox(height: 15),
                             Padding(
                               padding: const EdgeInsets.only(top: 8,left: 8),
                               child: Text('The total calories in your meal is: ' + double.parse(x.nur.energy.toString()).toStringAsFixed(2) + '. Select your '+
                                   'food measure from the dropdown to get more info.',
                               style: TextStyle(color: Colors.black87,
                               fontSize: 12),
                               ),
                             ),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Padding(
                                 padding: EdgeInsets.only(left: 8),
                                 child: DropdownButtonHideUnderline(
                                   child: SizedBox(
                                     width: 110,
                                     child: DropdownButtonFormField2(
                                       hint: Padding(
                                         padding: const EdgeInsets.only(left: 5),
                                         child: Text(
                                           'Select Item',
                                           style: TextStyle(
                                             fontSize: 14,

                                           ),
                                         ),
                                       ),
                                       items: x.measures
                                           .map((item) =>
                                           DropdownMenuItem<Measure>(
                                             value: item,
                                             child: Padding(
                                               padding: const EdgeInsets.only(left: 5),
                                               child: Text(
                                                 item.label,
                                                 style: const TextStyle(
                                                   fontSize: 14,
                                                     color: Colors.black87
                                                 ),
                                               ),
                                             ),
                                           ))
                                           .toList(),
                                       value: selectedValue,
                                       onSaved: (value){
                                         setState((){
                                         print(value);

                                         });
                                       },
                                       onChanged: (value) {
                                         setState(() {



                                           print(selectedValue);

                                         });
                                       },
                                       buttonHeight: 20,
                                       buttonWidth: 110,
                                       itemHeight: 20,
                                       iconEnabledColor: Colors.black87 ,
                                       decoration: InputDecoration(
                                         border: InputBorder.none,
                                       ),
                                       buttonDecoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(8),
                                         border: Border.all(
                                           color: Colors.black26,
                                         ),
                                         color: Colors.black12
                                       ),
                                     ),
                                   ),
                                 ),
                                   ),

                             Padding(
                               padding: const EdgeInsets.only( left: 8,right: 8),
                               child: Expanded(
                                 child: Container(
                                   height: 30,
                                   width: 70,
                                   decoration: BoxDecoration(
                                       color: kinActiveColour,
                                       borderRadius: BorderRadius.circular(8)
                                   ),
                                   child: TextButton(
                                     style: TextButton.styleFrom(
                                       padding: EdgeInsets.only(left: 5, right: 5),
                                       primary: kinActiveColour,
                                     ),
                                     onPressed: (){
                                       print(selectedValue.uri);
                                      Navigator.push(context,MaterialPageRoute(builder:(context)=>WebPage(url:selectedValue.uri)));
                                     },
                                     child: Expanded(
                                       child: Center(
                                         child: Text('more info',
                                           style: TextStyle(
                                               color: Colors.black87,
                                               fontSize: 10
                                           ),
                                         ),
                                       ),
                                     ),
                                   ),
                                 ),
                               ),
                             ),
                           ],
                          ),
                        ],
                          ),

    ),
                      );

    }
                    ),
                  ),
                  SizedBox(height: 500,),
                ],
              ),


    ]
    ),
      ),

    );
  }
}
