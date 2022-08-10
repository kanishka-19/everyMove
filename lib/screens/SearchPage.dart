import 'package:flutter/material.dart';
import 'package:everymove/models/Recipe.dart';
import 'package:http/http.dart' as http;
import 'package:everymove/screens/webPage.dart';
import 'dart:convert';

class SearchPage extends StatefulWidget {
  late String ? search;
  SearchPage({this.search});


  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late List<Recipe> _recipes;
  List<Recipe> list= <Recipe> [];
  bool _isLoading = true;
  late String? search;

  @override
  void initState() {
    super.initState();
    getApiData(widget.search);
  }

  getApiData(search) async{
    var url = 'https://api.edamam.com/search?q=$search&app_id=cd66de6e&app_key=eaac5630d2bdaaddb5cee84358918fd7	&from=0&to=100&calories=591-722&health=alcohol-free';
    final response = await http.get(Uri.parse(url));

    Map data = jsonDecode(response.body);

    data['hits'].forEach((e) {
      Recipe recipe = Recipe(
          image: e['recipe']['image'],
          url: e['recipe']['url'],
          source: e['recipe']['source'],
          label: e['recipe']['label']

      );
      setState((){
        list.add(recipe);
        _isLoading= false;

      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch ,
              children: [
                _isLoading
                    ? Center(child: CircularProgressIndicator()):
                GridView.builder(
                    shrinkWrap: true,
                    primary: true,
                    physics: ScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      // childAspectRatio: 3 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,

                    ),
                    itemCount: list.length,
                    itemBuilder: (context,i){
                      final x= list[i];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:  GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => WebPage(
                              url: x.url,
                            )));
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(

                                    image: NetworkImage(x.image.toString()),

                                  ),
                                  borderRadius: BorderRadius.circular(16),

                                  boxShadow:[ BoxShadow(
                                    color: Colors.grey.withOpacity(0.5), //color of shadow
                                    spreadRadius: 3, //spread radius
                                    blurRadius: 2, // blur radius
                                    // changes position of shadow
                                    //first paramerter of offset is left-right
                                    //second parameter is top to down
                                  )
                                  ]
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                    padding: EdgeInsets.all(3),


                                    child: Text(x.label.toString(),style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(height: 40),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                    padding: EdgeInsets.all(3),


                                    child: Text('source: '+x.source.toString(),style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
                              )
                            // Card(
                            //
                            //   clipBehavior: Clip.antiAlias,
                            //   child: Image.network(x.image.toString()),
                            //   shape: RoundedRectangleBorder(
                            //
                            //     borderRadius: BorderRadius.circular(20.0), //<-- SEE HERE
                            //   ),
                            // )
                          ),
                        ),
                      );
                    }

                )
              ]
          ),
        ),
      ),
    );
  }
}