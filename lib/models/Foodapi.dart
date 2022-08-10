import 'package:everymove/models/nutrients_model.dart';

import 'measures.dart';

class FoodApi{
late String foodid;
late String label;
late Nutrients nur;
late List<Measure> measures;
FoodApi({
  required this.foodid,
  required this.label,
  required this.measures,
  required this.nur,

});
}