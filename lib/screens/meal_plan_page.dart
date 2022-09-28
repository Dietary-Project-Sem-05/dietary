import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dietary_project/utilities/constants.dart';

class MealPlanPage extends StatefulWidget {
  const MealPlanPage({Key? key}) : super(key: key);

  @override
  State<MealPlanPage> createState() => _MealPlanPageState();
}

class _MealPlanPageState extends State<MealPlanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App BarM'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                child: Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: kContainerColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text('Tip!',
                          style: GoogleFonts.robotoMono(
                            textStyle: kTipHeadTextStyle,
                          )),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                          'Add your target, profile information and dietary requirements for precise dietary plans.',
                          style: GoogleFonts.roboto(
                            textStyle: kTipTextStyle,
                          )),
                    ],
                  ),
                ),
              ),
              Container(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF424242),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: Color(0xEE0277bd),
                          // borderRadius: BorderRadius.circular(5.0),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5.0),
                            topRight: Radius.circular(5.0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Today Plan',
                              style: GoogleFonts.roboto(
                                textStyle: kMealDayTextStyle,
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue,
                                onSurface: Colors.red,
                              ),
                              onPressed: () {},
                              child: Text('Real Intake'),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: 10.0,
                      // ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        color: kMealBgColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: FittedBox(
                                child: Image.asset(
                                  'lib/assets/images/breakfast-today.jpg',
                                  width: 120.0,
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                            Container(
                              // padding: EdgeInsets.only(top: 5.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Bread with Fish Salads',
                                    style: GoogleFonts.roboto(
                                      textStyle: kMealHeadingTextStyle,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    '\u2022 Bread slice x 2\n'
                                    '\u2022 Fish salads - 250g\n'
                                    '\u2022 Glass of milk\n'
                                    '\u2022 Yoghurt\n',
                                    style: GoogleFonts.roboto(
                                      textStyle: kMealListTextStyle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Rice and Curry',
                                    style: GoogleFonts.roboto(
                                      textStyle: kMealHeadingTextStyle,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    '\u2022 Rice - 200g\n'
                                    '\u2022 Dhal -50g\n'
                                    '\u2022 Fish slice - 100g\n'
                                    '\u2022 Carrot - 50g\n',
                                    style: GoogleFonts.roboto(
                                      textStyle: kMealListTextStyle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: FittedBox(
                                child: Image.asset(
                                  'lib/assets/images/lunch-today.jpg',
                                  width: 120.0,
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: kMealBgColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(5.0),
                            bottomRight: Radius.circular(5.0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: FittedBox(
                                child: Image.asset(
                                  'lib/assets/images/dinner-today.jpg',
                                  width: 120.0,
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    'Pasta and Cheese',
                                    style: GoogleFonts.roboto(
                                      textStyle: kMealHeadingTextStyle,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    '\u2022 Glass of wine\n'
                                    '\u2022 Pasta and Cheese - 500g\n'
                                    '\u2022 Fruit plate\n',
                                    style: GoogleFonts.roboto(
                                      textStyle: kMealListTextStyle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15.0),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF424242),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: Color(0xEE0277bd),
                          // borderRadius: BorderRadius.circular(5.0),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5.0),
                            topRight: Radius.circular(5.0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Tomorrow Plan',
                              style: GoogleFonts.roboto(
                                textStyle: kMealDayTextStyle,
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue,
                                onSurface: Colors.red,
                              ),
                              onPressed: () {},
                              child: Text('Select Plan'),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: 10.0,
                      // ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        color: kMealBgColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: FittedBox(
                                child: Image.asset(
                                  'lib/assets/images/breakfast-today.jpg',
                                  width: 120.0,
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                            Container(
                              // padding: EdgeInsets.only(top: 5.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Pan Cake with Honey',
                                    style: GoogleFonts.roboto(
                                      textStyle: kMealHeadingTextStyle,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    '\u2022 Pan cakes x 2\n'
                                    '\u2022 Honey - 200ml\n'
                                    '\u2022 Glass of milk\n'
                                    '\u2022 Yoghurt\n',
                                    style: GoogleFonts.roboto(
                                      textStyle: kMealListTextStyle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Rice and Curry',
                                    style: GoogleFonts.roboto(
                                      textStyle: kMealHeadingTextStyle,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    '\u2022 Rice - 200g\n'
                                    '\u2022 Dhal -50g\n'
                                    '\u2022 Chicken - 150g\n'
                                    '\u2022 Carrot - 50g\n',
                                    style: GoogleFonts.roboto(
                                      textStyle: kMealListTextStyle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: FittedBox(
                                child: Image.asset(
                                  'lib/assets/images/lunch-today.jpg',
                                  width: 120.0,
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: kMealBgColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(5.0),
                            bottomRight: Radius.circular(5.0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: FittedBox(
                                child: Image.asset(
                                  'lib/assets/images/dinner-today.jpg',
                                  width: 120.0,
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    'Bread and Cheese',
                                    style: GoogleFonts.roboto(
                                      textStyle: kMealHeadingTextStyle,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    '\u2022 Glass of wine\n'
                                    '\u2022 Bread slice x 2\n'
                                    '\u2022 Banana - 250g\n',
                                    style: GoogleFonts.roboto(
                                      textStyle: kMealListTextStyle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'All Plans',
                      style: GoogleFonts.roboto(
                        textStyle: kMealDayTextStyle,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: kContainerColor,
                              ),
                              margin: EdgeInsets.only(right: 10.0),
                              // padding: EdgeInsets.all(10.0),
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      '\u2022 List 01\n'
                                      '\u2022 List 02\n'
                                      '\u2022 List 03\n'
                                      '\u2022 List 04\n',
                                      style: GoogleFonts.roboto(
                                        textStyle: kPlanListTextStyle,
                                      ),
                                    ),
                                  ),
                                  const Divider(
                                    height: 20,
                                    thickness: 1,
                                    endIndent: 0,
                                    color: kListTextColor,
                                  ),
                                  Center(
                                    child: Text(
                                      'Breakfast',
                                      style: GoogleFonts.roboto(
                                          textStyle: kMealTimeTextStyle),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              color: Colors.red,
                              child: Text('Chamod'),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 10.0),
                              color: Colors.red,
                              child: Text('Chamod'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
