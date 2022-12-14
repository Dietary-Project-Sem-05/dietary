import 'package:flutter/material.dart';
import 'package:dietary_project/utilities/constants.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Model/meal_plan_modal.dart';

class MealPlanCard extends StatelessWidget {
  const MealPlanCard({super.key, required this.mealPlan});

  final MealPlanModal mealPlan;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
            height: 100,
            width: 350,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: kMealBgColor.withOpacity(0.9),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Container(
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  Center(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            mealPlan.plan_name.toString(),
                            style: GoogleFonts.roboto(
                              fontSize: 17,
                                textStyle: kMealHeadingTextStyle,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        "Breakfast : ${mealPlan.breakfastTitle}",
                        style: GoogleFonts.roboto(
                          fontSize: 13,
                            textStyle: kMealHeadingTextStyle,
                            color: Colors.white),
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        "Lunch : ${mealPlan.lunchTitle}",
                        style: GoogleFonts.roboto(
                          fontSize: 13,
                            textStyle: kMealHeadingTextStyle,
                            color: Colors.white),
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        "Dinner : ${mealPlan.dinnerTitle}",
                        style: GoogleFonts.roboto(
                          fontSize: 13,
                            textStyle: kMealHeadingTextStyle,
                            color: Colors.white),
                      )),
                    ],
                  ),
                ],
              ),
            )));
  }
}
