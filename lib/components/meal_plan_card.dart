import 'package:flutter/material.dart';
import 'package:dietary_project/utilities/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class MealPlanCard extends StatelessWidget {
  const MealPlanCard({this.onPress, this.image, this.label});

  final VoidCallback? onPress;
  final String? image;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: kContainerColor,
        ),
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: FittedBox(
                child: Image.asset(
                  image.toString(),
                ),
                fit: BoxFit.fill,
              ),
            ),
            const Divider(
              height: 1,
              thickness: 1,
              endIndent: 0,
              color: kListTextColor,
            ),
            SizedBox(
              height: 10.0,
            ),
            Center(
              child: Text(
                label.toString(),
                style: GoogleFonts.roboto(textStyle: kMealTimeTextStyle),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
