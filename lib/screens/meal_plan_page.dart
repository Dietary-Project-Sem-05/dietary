import 'dart:math';

import 'package:dietary_project/DatabaseHandler/AccountDBHandler.dart';
import 'package:dietary_project/DatabaseHandler/FoodItemDbHandler.dart';
import 'package:dietary_project/DatabaseHandler/GoalDBHandler.dart';
import 'package:dietary_project/DatabaseHandler/mealplan_database.dart';
import 'package:dietary_project/Model/user_goal_model.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dietary_project/utilities/constants.dart';
import 'package:dietary_project/components/meal_plan_card.dart';
import 'package:dietary_project/components/daily_meal_plan.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  int calculateGoalType(UserGoalModel usergl){
    int userGoal = 0;

    int? days = usergl.endDate!.difference(usergl.startDate!).inDays;
    int? weightGain = usergl.endWeight!.toInt() - usergl.startWeight!.toInt();

    if(weightGain < 0){
      userGoal = -1;
    } else{
      userGoal = 1;
    }

    if(weightGain.abs() / days < 0.0175){
      userGoal *= 1;
    } else if (weightGain.abs() / days < 0.035){
      userGoal *= 2;
    } else if (weightGain.abs() / days < 0.07){
      userGoal *= 3;
    }


    return userGoal;

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




    String main = mains.keys.toList()[random.nextInt(mains.length)];
    int mainIntake = (calAmount * 50 / 100)~/(mains[main]/100);
    mains.remove(main);



    String side1 = sidesMeat.keys.toList()[random.nextInt(sidesMeat.length)];
    int side1Intake = (calAmount * 30 / 100)~/ (sidesMeat[side1]/100);
    sidesMeat.remove(side1);



    String side2 = sides.keys.toList()[random.nextInt(sides.length)];
    int side2Intake = (calAmount * 10 / 100)~/ (sides[side2]/100);
    sides.remove(side2);



    String side3 = sides.keys.toList()[random.nextInt(sides.length)];

    int side3Intake = (calAmount * 10 / 100)~/ (sides[side3]/100);
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

  late List<MealPlanModal> myMealPlans;
  late MealPlanDatabase db;
  late GoalDBHandler goalDBHandler;
  late AccountDBHandler accountDBHandler;
  late FoodItemDbHandler foodItemDbHandler;
  late Map mealPlans;
  late Map tomorrowMealPlans;

  final storage = GetStorage();

  var _accountNo;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() {
    _accountNo = storage.read("user_no");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: downloadData(),
        builder: (
            BuildContext context,
            AsyncSnapshot<String> snapshot
            ){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Material(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(height: 20,),
                  CircularProgressIndicator(),
                ],
              ),
            );
          } else{
            if(snapshot.hasError){
              print(snapshot.error);
              return Center(
                child: Text(
                  'Error: ${snapshot.error}'
                )
              );
            } else{
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
                        DailyMealPlan(
                          dayPlan: 'Today Plan',
                          buttonLabel: 'Real Intake',
                          breakfastImage: 'lib/assets/images/breakfast-today.jpg',
                          breakfastMealHeading: '${mealPlans["bp"].keys.toList()[0]} with ${mealPlans["bp"].keys.toList()[1]}',
                          breakfastMealItems: '\u2022 ${mealPlans["bp"].keys.toList()[0]} - ${mealPlans["bp"][mealPlans["bp"].keys.toList()[0]]}g\n'
                              '\u2022 ${mealPlans["bp"].keys.toList()[1]} - ${mealPlans["bp"][mealPlans["bp"].keys.toList()[1]]}g\n'
                              '\u2022 ${mealPlans["bp"].keys.toList()[2]} - ${mealPlans["bp"][mealPlans["bp"].keys.toList()[2]]}g\n'
                              '\u2022 ${mealPlans["bp"].keys.toList()[3]} - ${mealPlans["bp"][mealPlans["bp"].keys.toList()[3]]}g\n'
                              '\u2022 ${mealPlans["bp"].keys.toList()[4]} - ${mealPlans["bp"][mealPlans["bp"].keys.toList()[4]]} cal\n'
                          ,
                          lunchImage: 'lib/assets/images/lunch-today.jpg',
                          lunchMealHeading: '${mealPlans["lp"].keys.toList()[0]} with ${mealPlans["lp"].keys.toList()[1]}',
                          lunchMealItems: '\u2022 ${mealPlans["lp"].keys.toList()[0]} - ${mealPlans["lp"][mealPlans["lp"].keys.toList()[0]]}g\n'
                              '\u2022 ${mealPlans["lp"].keys.toList()[1]} - ${mealPlans["lp"][mealPlans["lp"].keys.toList()[1]]}g\n'
                              '\u2022 ${mealPlans["lp"].keys.toList()[2]} - ${mealPlans["lp"][mealPlans["lp"].keys.toList()[2]]}g\n'
                              '\u2022 ${mealPlans["lp"].keys.toList()[3]} - ${mealPlans["lp"][mealPlans["lp"].keys.toList()[3]]}g\n'
                              '\u2022 ${mealPlans["lp"].keys.toList()[4]} - ${mealPlans["lp"][mealPlans["lp"].keys.toList()[4]]} cal\n'
                          ,
                          dinnerImage: 'lib/assets/images/dinner-today.jpg',
                          dinnerMealHeading: '${mealPlans["dp"].keys.toList()[0]} with ${mealPlans["dp"].keys.toList()[1]}',
                          dinnerMealItems: '\u2022 ${mealPlans["dp"].keys.toList()[0]} - ${mealPlans["dp"][mealPlans["dp"].keys.toList()[0]]}g\n'
                              '\u2022 ${mealPlans["dp"].keys.toList()[1]} - ${mealPlans["dp"][mealPlans["dp"].keys.toList()[1]]}g\n'
                              '\u2022 ${mealPlans["dp"].keys.toList()[2]} - ${mealPlans["dp"][mealPlans["dp"].keys.toList()[2]]}g\n'
                              '\u2022 ${mealPlans["dp"].keys.toList()[3]} - ${mealPlans["dp"][mealPlans["dp"].keys.toList()[3]]}g\n'
                              '\u2022 ${mealPlans["dp"].keys.toList()[4]} - ${mealPlans["dp"][mealPlans["dp"].keys.toList()[4]]} cal\n'
                          ,
                        ),
                        DailyMealPlan(
                          dayPlan: 'Tomorrow Plan',
                          buttonLabel: 'Select Plan',
                          breakfastImage: 'lib/assets/images/breakfast-today.jpg',
                          breakfastMealHeading: '${tomorrowMealPlans["bp"].keys.toList()[0]} with ${tomorrowMealPlans["bp"].keys.toList()[1]}',
                          breakfastMealItems: '\u2022 ${tomorrowMealPlans["bp"].keys.toList()[0]} - ${tomorrowMealPlans["bp"][tomorrowMealPlans["bp"].keys.toList()[0]]}g\n'
                              '\u2022 ${tomorrowMealPlans["bp"].keys.toList()[1]} - ${tomorrowMealPlans["bp"][tomorrowMealPlans["bp"].keys.toList()[1]]}g\n'
                              '\u2022 ${tomorrowMealPlans["bp"].keys.toList()[2]} - ${tomorrowMealPlans["bp"][tomorrowMealPlans["bp"].keys.toList()[2]]}g\n'
                              '\u2022 ${tomorrowMealPlans["bp"].keys.toList()[3]} - ${tomorrowMealPlans["bp"][tomorrowMealPlans["bp"].keys.toList()[3]]}g\n'
                              '\u2022 ${tomorrowMealPlans["bp"].keys.toList()[4]} - ${tomorrowMealPlans["bp"][tomorrowMealPlans["bp"].keys.toList()[4]]} cal\n'
                          ,
                          lunchImage: 'lib/assets/images/lunch-today.jpg',
                          lunchMealHeading: '${tomorrowMealPlans["lp"].keys.toList()[0]} with ${tomorrowMealPlans["lp"].keys.toList()[1]}',
                          lunchMealItems: '\u2022 ${tomorrowMealPlans["lp"].keys.toList()[0]} - ${tomorrowMealPlans["lp"][tomorrowMealPlans["lp"].keys.toList()[0]]}g\n'
                              '\u2022 ${tomorrowMealPlans["lp"].keys.toList()[1]} - ${tomorrowMealPlans["lp"][tomorrowMealPlans["lp"].keys.toList()[1]]}g\n'
                              '\u2022 ${tomorrowMealPlans["lp"].keys.toList()[2]} - ${tomorrowMealPlans["lp"][tomorrowMealPlans["lp"].keys.toList()[2]]}g\n'
                              '\u2022 ${tomorrowMealPlans["lp"].keys.toList()[3]} - ${tomorrowMealPlans["lp"][tomorrowMealPlans["lp"].keys.toList()[3]]}g\n'
                              '\u2022 ${tomorrowMealPlans["lp"].keys.toList()[4]} - ${tomorrowMealPlans["lp"][tomorrowMealPlans["lp"].keys.toList()[4]]} cal\n'
                          ,
                          dinnerImage: 'lib/assets/images/dinner-today.jpg',
                          dinnerMealHeading: '${tomorrowMealPlans["dp"].keys.toList()[0]} with ${tomorrowMealPlans["dp"].keys.toList()[1]}',
                          dinnerMealItems: '\u2022 ${tomorrowMealPlans["dp"].keys.toList()[0]} - ${tomorrowMealPlans["dp"][tomorrowMealPlans["dp"].keys.toList()[0]]}g\n'
                              '\u2022 ${tomorrowMealPlans["dp"].keys.toList()[1]} - ${tomorrowMealPlans["dp"][tomorrowMealPlans["dp"].keys.toList()[1]]}g\n'
                              '\u2022 ${tomorrowMealPlans["dp"].keys.toList()[2]} - ${tomorrowMealPlans["dp"][tomorrowMealPlans["dp"].keys.toList()[2]]}g\n'
                              '\u2022 ${tomorrowMealPlans["dp"].keys.toList()[3]} - ${tomorrowMealPlans["dp"][tomorrowMealPlans["dp"].keys.toList()[3]]}g\n'
                              '\u2022 ${tomorrowMealPlans["dp"].keys.toList()[4]} - ${tomorrowMealPlans["dp"][tomorrowMealPlans["dp"].keys.toList()[4]]} cal\n'
                          ,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(
                                "All Plans",
                                style: GoogleFonts.roboto(
                                  textStyle: kMealDayTextStyle,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                height: 150,
                                width: double.infinity,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: myMealPlans.length,
                                  itemBuilder: (context, index){
                                    return MealPlanCard(mealPlan: myMealPlans[index]);
                                  },

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
        });
  }

  Future<String> downloadData() async{
    db = MealPlanDatabase.instance;
    myMealPlans = await db.readMealPlans();

    final prefs = await SharedPreferences.getInstance();

    // await prefs.remove('today_plan_bp');
    // await prefs.remove('today_plan_lp');
    // await prefs.remove('today_plan_dp');
    // await prefs.remove('tomorrow_plan_bp');
    // await prefs.remove('tomorrow_plan_lp');
    // await prefs.remove('tomorrow_plan_dp');
    //
    // await prefs.remove('mp_created_time');

    foodItemDbHandler = await FoodItemDbHandler();
    await foodItemDbHandler.initDatabaseConnection();
    List? foods = await foodItemDbHandler.getFoodDetails();

    Map<String, double> mains = foods![0];
    Map<String, double> sides = foods[2];

    Map<String, double> sides_meat = foods[1];
    Map<String, double> deserts = foods[3];

    if (
        prefs.getString("today_plan_bp") == null ||
        prefs.getString("today_plan_lp") == null ||
        prefs.getString("today_plan_dp") == null ||
        prefs.getString("tomorrow_plan_bp") == null ||
        prefs.getString("tomorrow_plan_lp") == null ||
        prefs.getString("tomorrow_plan_dp") == null
    ){
      // Get user goal info from the db
      goalDBHandler = await GoalDBHandler();
      await goalDBHandler.initDatabaseConnection();
      UserGoalModel? usergl = await goalDBHandler.getUserGoal(_accountNo);

      accountDBHandler = await AccountDBHandler();
      await accountDBHandler.initDatabaseConnection();
      List? userInfo = await accountDBHandler.getProfilePageInfo(_accountNo);


      // This is the conditions for goal

      int userGoal;

      if(usergl == null){
        userGoal = 0;
      } else{
        userGoal = calculateGoalType(usergl);
      }

      int age = userInfo?[0].years;
      int userWeight = userInfo?[1];
      int userHeight = userInfo?[2];
      String userGender = userInfo?[3];
      String activityStatus = userInfo?[4];

      int activityStatusInt;

      //
      // 0 - sedentry - little or no exercise
      // 1 - light - light exercise (1, 3 times a week)
      // 2 - moderate - moderate (3, 5 times a week)
      // 3 - active - daily exercise or intense exersie (3, 4 times a week)
      // 4 - very active - intense workout (6, 7 times a week)

      switch(activityStatus){
        case "Sedentary":
          activityStatusInt = 0;
          break;
        case "Light":
          activityStatusInt = 1;
          break;
        case "Moderate":
          activityStatusInt = 2;
          break;
        case "Active":
          activityStatusInt = 3;
          break;
        case "Extra Active":
          activityStatusInt = 4;
          break;
        default:
          activityStatusInt = 0;
          break;
      }

      double dci = calculateDailyCalIntake(age, userGender, activityStatusInt, userHeight, userWeight, userGoal);


      // mains.addAll({"Rice": 1.3, "noodles": 1.38, "pasta": 1.31, "bread": 2.65, "roti": 2.97});
      // sides.addAll({"carrot": .41, "cabbage": .25, "brinjal": .25, "kankun": .19, "brocali": .34, "potato": .77, "tomato": .18, "cheese": 4.02});
      //
      //
      //
      // sides_meat.addAll({"tuna fish": 1.3, "chicken": 2.39, "pork": 2.42, "egg": 1.55,});
      // deserts.addAll({"cake (100g)": 257, "yoghurt-cup": 59, "bannana 100g": 89, "watermelon 100g": 30});

      print([dci, mains, sides, sides_meat, deserts]);

      mealPlans = getMealPlan(dci, mains, sides, sides_meat, deserts);

      await prefs.setDouble("dci", dci);

      DateTime now = DateTime.now();

      // code to store the meal plan
      await prefs.setString("today_plan_bp", MealPlanModal.fromJson(mealPlans["bp"]));
      await prefs.setString("today_plan_lp", MealPlanModal.fromJson(mealPlans["lp"]));
      await prefs.setString("today_plan_dp", MealPlanModal.fromJson(mealPlans["dp"]));
      await prefs.setString("mp_created_time", DateTime(
        now.year,
        now.month,
        now.day,
      ).toIso8601String());

      tomorrowMealPlans = getMealPlan(dci, mains, sides, sides_meat, deserts);

      await prefs.setString("tomorrow_plan_bp", MealPlanModal.fromJson(tomorrowMealPlans["bp"]));
      await prefs.setString("tomorrow_plan_lp", MealPlanModal.fromJson(tomorrowMealPlans["lp"]));
      await prefs.setString("tomorrow_plan_dp", MealPlanModal.fromJson(tomorrowMealPlans["dp"]));

      print("dg");

    } else{

      mealPlans = {
        "bp": MealPlanModal.toJson(prefs.getString("today_plan_bp")!),
        "lp": MealPlanModal.toJson(prefs.getString("today_plan_lp")!),
        "dp": MealPlanModal.toJson(prefs.getString("today_plan_dp")!),
      };

      tomorrowMealPlans = {
        "bp": MealPlanModal.toJson(prefs.getString("tomorrow_plan_bp")!),
        "lp": MealPlanModal.toJson(prefs.getString("tomorrow_plan_lp")!),
        "dp": MealPlanModal.toJson(prefs.getString("tomorrow_plan_dp")!),
      };

      if(DateTime.now().difference(DateTime.parse(prefs.getString("mp_created_time")!)).inDays > 1){

        mealPlans = tomorrowMealPlans;
        double? dci = prefs.getDouble("dci");

        await prefs.remove('today_plan_bp');
        await prefs.remove('today_plan_lp');
        await prefs.remove('today_plan_dp');
        await prefs.remove('tomorrow_plan_bp');
        await prefs.remove('tomorrow_plan_lp');
        await prefs.remove('tomorrow_plan_dp');

        await prefs.remove('mp_created_time');


        DateTime now = DateTime.now();

        // code to store the meal plan
        await prefs.setString("today_plan_bp", MealPlanModal.fromJson(mealPlans["bp"]));
        await prefs.setString("today_plan_lp", MealPlanModal.fromJson(mealPlans["lp"]));
        await prefs.setString("today_plan_dp", MealPlanModal.fromJson(mealPlans["dp"]));
        await prefs.setString("mp_created_time", DateTime(
          now.year,
          now.month,
          now.day,
        ).toIso8601String());

        tomorrowMealPlans = getMealPlan(dci!, mains, sides, sides_meat, deserts);

        await prefs.setString("tomorrow_plan_bp", MealPlanModal.fromJson(tomorrowMealPlans["bp"]));
        await prefs.setString("tomorrow_plan_lp", MealPlanModal.fromJson(tomorrowMealPlans["lp"]));
        await prefs.setString("tomorrow_plan_dp", MealPlanModal.fromJson(tomorrowMealPlans["dp"]));

      }



    }




    // Generating the meal plans


    return "download successful";
  }

}
