import 'package:flutter/material.dart';
import 'package:dietary_project/utilities/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class LightMealPlanRow extends StatelessWidget {
  const LightMealPlanRow({this.image, this.mealHeading, this.mealItems});

  final String? image;
  final String? mealHeading;
  final String? mealItems;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  mealHeading.toString(),
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    textStyle: kMealHeadingTextStyle,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  mealItems.toString(),
                  style: GoogleFonts.roboto(
                    textStyle: kMealListTextStyle,
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: FittedBox(
              fit: BoxFit.fill,
              child: Image.asset(
                image.toString(),
                height: 130.0,
                width: 130.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
