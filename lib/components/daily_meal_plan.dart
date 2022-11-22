import 'package:dietary_project/screens/real_intake_page.dart';
import 'package:dietary_project/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:dietary_project/utilities/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dark_meal_plan_row.dart';
import 'light_meal_plan_row.dart';

class DailyMealPlan extends StatelessWidget {
  const DailyMealPlan(
      {super.key, this.dayPlan,
      this.buttonLabel,
      this.breakfastMealHeading,
      this.lunchMealHeading,
      this.dinnerMealHeading,
      this.breakfastImage,
      this.lunchImage,
      this.dinnerImage,
      this.breakfastMealItems,
      this.lunchMealItems,
      this.dinnerMealItems});

  final String? dayPlan;
  final String? buttonLabel;
  final String? breakfastMealHeading;
  final String? lunchMealHeading;
  final String? dinnerMealHeading;
  final String? breakfastImage;
  final String? lunchImage;
  final String? dinnerImage;
  final String? breakfastMealItems;
  final String? lunchMealItems;
  final String? dinnerMealItems;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          left: 15.0,
          right: 15.0,
          bottom: 15.0
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF424242).withOpacity(0.8),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: const Color(0xEE0277bd).withOpacity(0.8),
              // borderRadius: BorderRadius.circular(5.0),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5.0),
                topRight: Radius.circular(5.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  dayPlan.toString(),
                  style: GoogleFonts.roboto(
                    textStyle: kMealDayTextStyle,
                  ),
                ),
              ],
            ),
          ),
          // SizedBox(
          //   height: 10.0,
          // ),

          DarkMealPlanRow(
            image: breakfastImage,
            mealHeading: breakfastMealHeading,
            mealItems: breakfastMealItems,
          ),
          LightMealPlanRow(
            image: lunchImage,
            mealHeading: lunchMealHeading,
            mealItems: lunchMealItems,
          ),
          DarkMealPlanRow(
            image: dinnerImage,
            mealHeading: dinnerMealHeading,
            mealItems: dinnerMealItems,
          ),
        ],
      ),
    );
  }
}
