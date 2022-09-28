import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dietary_project/utilities/constants.dart';
import 'package:dietary_project/components/meal_plan_card.dart';
import 'package:dietary_project/components/daily_meal_plan.dart';
import 'package:dietary_project/components/expand_button.dart';

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
              const DailyMealPlan(
                dayPlan: 'Today Plan',
                buttonLabel: 'Real Intake',
                breakfastImage: 'lib/assets/images/breakfast-today.jpg',
                breakfastMealHeading: 'Bread with Fish Salads',
                breakfastMealItems: '\u2022 Bread slice x 2\n'
                    '\u2022 Fish salads - 250g\n'
                    '\u2022 Glass of milk\n'
                    '\u2022 Yoghurt\n',
                lunchImage: 'lib/assets/images/lunch-today.jpg',
                lunchMealHeading: 'Rice and Curry',
                lunchMealItems: '\u2022 Rice - 200g\n'
                    '\u2022 Dhal -50g\n'
                    '\u2022 Fish slice - 100g\n'
                    '\u2022 Carrot - 50g\n',
                dinnerImage: 'lib/assets/images/lunch-today.jpg',
                dinnerMealHeading: 'Pasta and Cheese',
                dinnerMealItems: '\u2022 Glass of wine\n'
                    '\u2022 Pasta and Cheese - 500g\n'
                    '\u2022 Fruit plate\n',
              ),
              const DailyMealPlan(
                dayPlan: 'Tomorrow Plan',
                buttonLabel: 'Select Plan',
                breakfastImage: 'lib/assets/images/breakfast-today.jpg',
                breakfastMealHeading: 'Pan Cake with Honey',
                breakfastMealItems: '\u2022 Pan cakes x 2\n'
                    '\u2022 Honey - 200ml\n'
                    '\u2022 Glass of milk\n'
                    '\u2022 Yoghurt\n',
                lunchImage: 'lib/assets/images/lunch-today.jpg',
                lunchMealHeading: 'Rice and Curry',
                lunchMealItems: '\u2022 Rice - 200g\n'
                    '\u2022 Dhal -50g\n'
                    '\u2022 Chicken - 150g\n'
                    '\u2022 Carrot - 50g\n',
                dinnerImage: 'lib/assets/images/dinner-today.jpg',
                dinnerMealHeading: 'Bread and Cheese',
                dinnerMealItems: '\u2022 Glass of wine\n'
                    '\u2022 Bread slice x 2\n'
                    '\u2022 Banana - 250g\n',
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
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
                            child: MealPlanCard(
                              onPress: () {
                                print('Breakfast');
                              },
                              image: 'lib/assets/images/breakfast-plans.jpeg',
                              label: 'Breakfast',
                            ),
                          ),
                          Expanded(
                            child: MealPlanCard(
                              onPress: () {
                                print('Lunch');
                              },
                              image: 'lib/assets/images/lunch-plans.png',
                              label: 'Lunch',
                            ),
                          ),
                          Expanded(
                            child: MealPlanCard(
                              onPress: () {
                                print('Dinner');
                              },
                              image: 'lib/assets/images/dinner-plans.jpg',
                              label: 'Dinner',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 10.0,
                ),
                child: ExpandButton(
                  labelText: 'ADD NEW MEAL PLAN',
                  icon: Icons.add,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
