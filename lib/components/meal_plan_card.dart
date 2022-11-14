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
          color: kMealBgColor.withOpacity(0.9),
        ),
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(0.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10)
                ),
              ),

              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10)
                ),
                child: Image.asset(
                  image.toString(),
                ),
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
                style: GoogleFonts.roboto(textStyle: kMealHeadingTextStyle, color: Colors.white),
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
