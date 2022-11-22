import 'package:dietary_project/DatabaseHandler/FoodItemDbHandler.dart';
import 'package:dietary_project/Model/food_item_model.dart';
import 'package:dietary_project/screens/add_food_item.dart';
import 'package:flutter/material.dart';

import '../Model/meal_plan_modal.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({Key? key}) : super(key: key);

  @override
  State<FoodPage> createState() => _FoodPageState();
}


class _FoodPageState extends State<FoodPage> {

  late FoodItemDbHandler dbHandler;
  late List<FoodItemModel> allFoods = [];

  routePage() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => AddFoodItem()));
  }

  // Need to get the food details for this array

  Widget _foodItem(String food_name, String food_catogary, int calorie) {
    return Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 12,
        ),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black.withOpacity(0.85),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Title(
                color: Colors.black,
                child: Text(
                  "$food_name ($food_catogary)",
                  style: const TextStyle(color: Colors.blue),
                ),
              ),
              const SizedBox(height: 10),
              Text("\u2022 Calories : $calorie"),
            ]),
            const Spacer(),
          ],
        ));
  }

  Widget _addNewFood() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black.withOpacity(0),
      ),
      child: ElevatedButton(
        onPressed: () {
          routePage();
        },
        child: const Text(
          "Request New Food",
          style: TextStyle(
            letterSpacing: 6,
            wordSpacing: 5,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String search_string = "";

    return FutureBuilder(
      future: downloadData(),
      builder: (
        BuildContext context,
        AsyncSnapshot<String> snapshot,
      ){
        if (snapshot.connectionState == ConnectionState.waiting){
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
          if (snapshot.hasError){
            print(snapshot.error);
            return Center(
              child: Text(
                'Error: ${snapshot.error}'
              ),
            );
          } else{
            return Scaffold(
                appBar: AppBar(
                  title: const Text('Food Details'),
                  backgroundColor: Colors.black38,
                ),
                body: Container(
                    constraints: const BoxConstraints.expand(),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("lib/assets/images/food_colored.jpg"),
                          repeat: ImageRepeat.repeat,
                        )),
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(
                            //       horizontal: 10.0, vertical: 10),
                            //   child: TextField(
                            //     onChanged: (value) {
                            //       search_string = value.toLowerCase();
                            //     },
                            //     onSubmitted: (value){
                            //       for(int i = 0; i < allFoods.length; i++){
                            //         if(allFoods[i].name == value){
                            //           allFoods = [allFoods[i]];
                            //           print(MealPlanModal.toJson("{'Rice':12.0, 'Milk': 13.9}"));
                            //           break;
                            //         }
                            //       }
                            //     },
                            //     decoration: const InputDecoration(
                            //       labelText: 'Search',
                            //       suffixIcon: Icon(Icons.search),
                            //     ),
                            //   ),
                            // ),
                            Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: allFoods.length,
                                  // TODO: number of items in the db need to be added to here
                                  itemBuilder: (context, index) {
                                    return _foodItem(
                                        allFoods[index].name,
                                        allFoods[index].category,
                                        allFoods[index].calory_count
                                    );
                                  }),
                            ),
                            _addNewFood(),
                            // TODO: add a floating button to add new food
                          ],
                        ),
                      ],
                    )));
          }
        }
      },);
  }

  Future<String> downloadData() async{
    dbHandler = await FoodItemDbHandler();
    await dbHandler.initDatabaseConnection();

    List? foodItems = await dbHandler.getFoodDetails();
    String current;

    Map mainFoods = foodItems![0];
    Map sidesMeatsFoods = foodItems[1];
    Map sidesFoods = foodItems[2];
    Map deserts = foodItems[3];


    allFoods = [];

    for(int i = 0; i < mainFoods.keys.toList().length; i++){
      current = mainFoods.keys.toList()[i];
      allFoods.add(FoodItemModel.withoutFoodId(current, -1, mainFoods[current].toInt(), "Main Food"));
    }

    for(int i = 0; i < sidesMeatsFoods.keys.toList().length; i++){
      current = sidesMeatsFoods.keys.toList()[i];
      allFoods.add(FoodItemModel.withoutFoodId( current, -1, sidesMeatsFoods[current].toInt(), "Side Non Veg Food"));
    }

    for(int i = 0; i < sidesFoods.keys.toList().length; i++){
      current = sidesFoods.keys.toList()[i];
      allFoods.add(FoodItemModel.withoutFoodId(current, -1, sidesFoods[current].toInt(), "Side Veg Food"));
    }

    for(int i = 0; i < deserts.keys.toList().length; i++){
      current = deserts.keys.toList()[i];
      allFoods.add(FoodItemModel.withoutFoodId(current, -1, deserts[current].toInt(), "Desert"));
    }

    return "Data download successful";

  }
}
