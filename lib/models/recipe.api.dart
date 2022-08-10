// import 'dart:convert';
// import 'package:everymove/models/Recipe.dart';
// import 'package:http/http.dart' as http;
// import 'package:everymove/models/Recipe.dart';
//
// class RecipeApi {
//   static Future<List<Recipe>> getRecipe() async {
//     var url = 'https://api.edamam.com/search?q=chicken&app_id=cd66de6e&app_key=eaac5630d2bdaaddb5cee84358918fd7	&from=0&to=100&calories=591-722&health=alcohol-free';
//     final response = await http.get(Uri.parse(url));
//     // headers: {
//     //   "x-rapidapi-key": "a1f1c64d49mshca04fb0353ab1aap1d6035jsn7b000592ae2b",
//     //   "x-rapidapi-host": "yummly2.p.rapidapi.com",
//     //   "useQueryString": "true"
//     // });
//
//     Map data = jsonDecode(response.body);
//     List _temp = [];
//
//     data['hits'].forEach((e) {
//       Recipe recipe = Recipe(
//         image: e['recipe']['image'],
//         url: e['recipe']['uri'],
//         source: e['recipe']['source'],
//         label: e['recipe']['label']
//
//       );
//       setState((){
//
//       });
//       });
//
//     // for (var i in data['feed']) {
//     //   _temp.add(i['content']['details']);
//     // }
//
//     return Recipe.recipesFromSnapshot(_temp);
//   }
// }
