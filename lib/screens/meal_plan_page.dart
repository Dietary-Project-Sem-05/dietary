import 'dart:collection';
import 'dart:ffi';
import 'dart:math';

import 'package:dietary_project/screens/add_meal_plan.dart';
import 'package:dietary_project/screens/real_intake_page.dart';
import 'package:dietary_project/screens/set_goals.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dietary_project/utilities/constants.dart';
import 'package:dietary_project/components/meal_plan_card.dart';
import 'package:dietary_project/components/daily_meal_plan.dart';
import 'package:dietary_project/components/expand_button.dart';

import '../Model/meal_plan_modal.dart';

class MealPlanPage extends StatefulWidget {
  const MealPlanPage({Key? key}) : super(key: key);

  @override
  State<MealPlanPage> createState() => _MealPlanPageState();
}

class _MealPlanPageState extends State<MealPlanPage> {

  // This is the code to generating the meal plan

  double calculateBMR(int weight, int height, int age, String gender){
    if(gender == "FEMALE"){
      return 655.1 + (9.563 * weight) + (1.850 * height) - (4.676 * age);
    }
    else if(gender == "MALE" || gender == "OTHER"){
      return (13.75 * weight) + (5.003 * height) - (6.755 * age);
    }

    else{
      return -1;
    }
  }

  double calculateAMR(int activityStatus,double bmr){
    switch(activityStatus){
      case 0:
        return bmr * 1.2;
      case 1:
        return bmr * 1.375;
      case 2:
        return bmr * 1.55;
      case 3:
        return bmr * 1.725;
      case 4:
        return bmr * 1.9;
      default:
        return -1;
    }
  }

  double calculateDailyCalIntake(int age, String gender, int activityStatus, int height, int weight, int goal){
    double bmr = calculateBMR(weight, height, age, gender);
    double amr = calculateAMR(activityStatus, bmr);

    if(gender == "MALE"){
      switch(goal){
        case 0:
          return amr;
        case -1:
          return amr * 90/100;
        case -2:
          return amr * 79/100;
        case -3:
          return amr * 58/100;
        case 1:
          return amr * 110/100;
        case 2:
          return amr * 121/100;
        case 3:
          return amr * 142/100;
        default:
          return -1;
      }
    }

    if(gender == "FEMALE"){
      switch(goal){
        case 0:
          return amr;
        case -1:
          return amr * 89/100;
        case -2:
          return amr * 77/100;
        case -3:
          return amr * 54/100;
        case 1:
          return amr * 111/100;
        case 2:
          return amr * 123/100;
        case 3:
          return amr * 146/100;
        default:
          return -1;
      }
    }

    else{

      return -1;
    }

  }

  Map getMealForCalAmount(
      double calAmount,
      Map mains,
      Map sides,
      Map sidesMeat,
      Map deserts){

    final random = new Random();

    String desert = deserts.keys.toList()[random.nextInt(deserts.length)];
    calAmount -= deserts[desert];

    String main = mains.keys.toList()[random.nextInt(deserts.length)];
    int mainIntake = (calAmount * 50 / 100)~/mains[main];
    mains.remove(main);

    String side1 = sidesMeat.keys.toList()[random.nextInt(sidesMeat.length)];
    int side1Intake = (calAmount * 30 / 100)~/ sidesMeat[side1];
    sidesMeat.remove(side1);

    String side2 = sides.keys.toList()[random.nextInt(sides.length)];
    int side2Intake = (calAmount * 10 / 100)~/ sides[side2];
    sides.remove(side2);

    String side3 = sides.keys.toList()[random.nextInt(sides.length)];
    int side3Intake = (calAmount * 10 / 100)~/ sidesMeat[side3];
    sides.remove(side3);

    Map mealPlan = {
      main: mainIntake,
      side1: side1Intake,
      side2: side2Intake,
      side3: side3Intake,
      desert: deserts[desert]
    };

    return mealPlan;
  }

  Map getMealPlan(
      double dci,
      Map mains,
      Map sides,
      Map sidesMeat,
      Map deserts){

    double breakfastCalAmount = dci * 30/100;
    double lunchCalAmount = dci * 45/100;
    double dinnerCalAmount = dci * 25/100;

    Map breakfastPlan = getMealForCalAmount(breakfastCalAmount, mains, sides, sidesMeat, deserts);
    Map lunchPlan = getMealForCalAmount(lunchCalAmount, mains, sides, sidesMeat, deserts);
    Map dinnerPlan = getMealForCalAmount(dinnerCalAmount, mains, sides, sidesMeat, deserts);

    Map output = {"bp": breakfastPlan, "lp": lunchPlan, "dp": dinnerPlan};

    return output;

  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   // super.initState();
  //
  //   double dci = calculateDailyCalIntake(23, "male", 2, 178, 76, 0);
  //
  //   Map mains = {"Rice": 1.3, "noodles": 1.38, "pasta": 1.31, "bread": 2.65, "roti": 2.97};
  //   Map sides = {"carrot": .41, "cabbage": .25, "brinjal": .25, "kankun": .19, "brocali": .34, "potato": .77, "tomato": .18, "cheese": 4.02};
  //
  //   Map sides_meat = {"tuna fish": 1.3, "chicken": 2.39, "pork": 2.42, "egg": 1.55,};
  //   Map deserts = {"cake (100g)": 257, "yoghurt-cup": 59, "bannana 100g": 89, "watermelon 100g": 30};
  //
  //   print(getMealPlan(dci, mains, sides, sides_meat, deserts));
  // }

  List myMealPlans = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Plans'),
        backgroundColor: Colors.black38,
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/images/food_colored.jpg"),
            repeat: ImageRepeat.repeat,
          )


        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.8),
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
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      height: 150,
                      width: double.infinity,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Expanded(
                            child: MealPlanCard(

                              mealPlan: MealPlanModal(
                                12,
                                "My Plan",
                                  {"Rice": 100, "Chicken":100, "carrot":200, "leaks": 200, "cake":20},
                                {"Bread": 100, "Fish":100, "carrot":200, "leaks": 200, "cake":20},
                                {"Pasta": 100, "Almond":100, "carrot":200, "leaks": 200, "cake":20},
                                DateTime.now()
                              ),

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
