import 'package:flutter/material.dart';

const kinActiveColour= Color(0xFFFCDB4B);
const kActiveColour= Colors.white;
const blueShade = Colors.blue;

var Workout = ['Sedentary (little or no exercise)', 'Lightly active (exercise 1–3 days/week)',
'Moderately active (exercise 3-5 days/week)', 'Active (exercise 6–7 days/week)',
'Very active (hard exercise 6–7 days/week)'];

var WorkoutDetails= {
  'Sedentary (little or no exercise)' : 1.2,
  'Lightly active (exercise 1–3 days/week)': 1.375,
  'Moderately active (exercise 3-5 days/week)': 1.55,
  'Active (exercise 6–7 days/week)': 1.725,
  'Very active (hard exercise 6–7 days/week)': 1.9,
};
var Goals= ['Lose Weight', 'Maintain Weight', 'Gain Weight'];

var GoalsCalories={
  'Lose Weight': -500,
  'Maintain Weight': 0,
  'Gain Weight' : 500,
};

enum boxSelection{
  one,
  two,
  three,
  four,
  five,
}