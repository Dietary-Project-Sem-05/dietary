import 'dart:collection';

import 'package:flutter/material.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({Key? key}) : super(key: key);

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class FoodItem{

  String name;
  double per_amount;
  String path;
  double calories;
  double carbs;
  double fats;


  FoodItem(
    this.name,
    this.per_amount,
    this.path,
    this.calories,
    this.carbs,
    this.fats
  );

}


class _FoodPageState extends State<FoodPage> {

  // Need to get the food details for this array
  List<FoodItem> food_details = [
  FoodItem("Rice", 100, "food_bg.jpg", 12.5, 20.5, 3.4),
  FoodItem("Hoppers", 100, "food_bg.jpg", 12.5, 20.5, 3.4),
  FoodItem("Pasta", 100, "food_bg.jpg", 12.5, 20.5, 3.4),
  FoodItem("Noodles", 100, "food_bg.jpg", 12.5, 20.5, 3.4),
  FoodItem("Hoppers", 100, "food_bg.jpg", 12.5, 20.5, 3.4),
  FoodItem("Pasta", 100, "food_bg.jpg", 12.5, 20.5, 3.4),
  FoodItem("Noodles", 100, "food_bg.jpg", 12.5, 20.5, 3.4),
  FoodItem("Hoppers", 100, "food_bg.jpg", 12.5, 20.5, 3.4),
  FoodItem("Pasta", 100, "food_bg.jpg", 12.5, 20.5, 3.4),
  FoodItem("Noodles", 100, "food_bg.jpg", 12.5, 20.5, 3.4),
  FoodItem("Hoppers", 100, "food_bg.jpg", 12.5, 20.5, 3.4),
  FoodItem("Pasta", 100, "food_bg.jpg", 12.5, 20.5, 3.4),
  FoodItem("Noodles", 100, "food_bg.jpg", 12.5, 20.5, 3.4),
  FoodItem("Hoppers", 100, "food_bg.jpg", 12.5, 20.5, 3.4),
  FoodItem("Pasta", 100, "food_bg.jpg", 12.5, 20.5, 3.4),
  FoodItem("Noodles", 100, "food_bg.jpg", 12.5, 20.5, 3.4),

  ];


  Widget _foodItem(String food_name, double per_amount, String food_img_path, double calorie, double carbs, double fats){
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
      ),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black54,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Title(
                  color: Colors.black,
                  child: Text(
                    "$food_name ($per_amount g)",
                    style: const TextStyle(color: Colors.blue),
                  ),
                ),
                const SizedBox(height: 10),
                Text("\u2022 Calories : $calorie"),
                Text("\u2022 Carbs : $carbs"),
                Text("\u2022 Fats : $fats"),
              ]
          ),
          const Spacer(),
          Expanded(
              flex: 0,
              child: SizedBox(
                height: 74,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    'assets/images/$food_img_path',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
          ),



        ],
      )

    );
  }

  Widget _addNewFood(){
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black12,
      ),
      child: const Text(
        "+ Request new Food",
        style: TextStyle(
          letterSpacing: 6,
          wordSpacing: 5,
          color: Colors.blue,
        ),),
    );
  }


  @override
  Widget build(BuildContext context) {

    String search_string = "";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Detail'),
        backgroundColor: Colors.black38,
      ),

      body: Column(
          children: [
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: TextField(
              onChanged: (value) {
              setState(() {
                search_string = value.toLowerCase();
                });
                },
                decoration: const InputDecoration(
                labelText: 'Search',
                suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: food_details.length, // TODO: number of items in the db need to be added to here
                  itemBuilder: (context, index){
                    return _foodItem(
                      food_details[index].name,
                      food_details[index].per_amount,
                      food_details[index].path,
                      food_details[index].calories,
                      food_details[index].carbs,
                      food_details[index].fats,
                    );
                  }
              ),
            ),
            _addNewFood(),
          ],
        ),


      // body: SingleChildScrollView(
      //   // TODO: Need to add a fixed search bar in here
      //   child: Column(
      //     children: [
      //       _addNewFood(),
      //       // Load food data from the database to here
      //       _foodItem("Rice", 10, "food_bg.jpg", 12.5, 2.5, 3.5),
      //       _foodItem("Rice", 100, "food_bg.jpg", 12.5, 2.5, 3.5),
      //       _foodItem("Rice", 100, "food_bg.jpg", 12.5, 2.5, 3.5),
      //       _foodItem("Rice", 100, "food_bg.jpg", 12.5, 2.5, 3.5),
      //       _foodItem("Rice", 100, "food_bg.jpg", 12.5, 2.5, 3.5),
      //       _foodItem("Rice", 100, "food_bg.jpg", 12.5, 2.5, 3.5),
      //       _foodItem("Rice", 100, "food_bg.jpg", 12.5, 2.5, 3.5),
      //       _foodItem("Rice", 100, "food_bg.jpg", 12.5, 2.5, 3.5),
      //       _foodItem("Rice", 100, "food_bg.jpg", 12.5, 2.5, 3.5),
      //       _foodItem("Rice", 100, "food_bg.jpg", 12.5, 2.5, 3.5),
      //     ],
      //   ),
      // ),
    );
  }
}
