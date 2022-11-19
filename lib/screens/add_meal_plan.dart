
import 'package:dropdown_search/dropdown_search.dart';
import "package:flutter/material.dart";

class AddMealPlan extends StatefulWidget{

  const AddMealPlan({Key? key}) : super(key: key);

  @override
  State<AddMealPlan> createState() => _AddMealPlanState();
}



class _AddMealPlanState extends State<AddMealPlan>{


  double? total_calories = 2500;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _bmm_intake;

  late Map<String, double> foodItemsMap;
  late List<String> foodItems;

  @override
  void initState() {
    foodItemsMap = {"Rice": 12.2, "Milk": 10.2, "Water": 0, "Watermelon": 11, "Papaya": 3, "Chicken": 45.0, "pork":100};
    foodItems = foodItemsMap.keys.toList();

    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Meal Plan'),
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
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                width: double.infinity,

                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(10)
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const Text("Note",

                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 20,

                      ),
                      textAlign: TextAlign.right,

                    ),
                    Title(
                      color: Colors.blue,
                      child: Text(
                        "You have to take around ${total_calories?.toInt()} calories per day to go for your goal and for a healthy life 😁",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          letterSpacing: 2,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),

                  ],
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              Text(
                  "Total Calories ${total_calories!.toInt()}",
                  textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 17,
                  letterSpacing: 2,
                ),
              ),

              Form(child: Column(
                key: _formKey,
                children: [
                  const SizedBox(
                    height: 10,
                  ),

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      maxLength: 20,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          counterText: "",
                          labelText: "Meal Plan Name",
                          labelStyle: TextStyle(
                            color: Colors.white,
                          )),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      // onSaved: (text) {
                      //   _bmm_intake = text!;
                      // },
                    ),
                  ),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 30),
                    child: Column(
                      children: [
                        Text(
                          "Breakfast Plan ${total_calories! * 30~/100}",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 20,
                            letterSpacing: 2,
                          ),
                        ),


                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 230,
                                  child: DropdownSearch<String>(
                                    mode: Mode.MENU,
                                    showSelectedItems: true,
                                    items: foodItems,
                                    dropdownSearchDecoration: const InputDecoration(
                                      labelText: "Main Meal",
                                      hintText: "Your main food",
                                    ),
                                    showSearchBox: true,
                                    searchFieldProps: const TextFieldProps(
                                      cursorColor: Colors.green,
                                    ),
                                  )
                              ),
                              const SizedBox(width: 10,),
                              SizedBox(
                                width: 100,
                                child: TextFormField(
                                  maxLength: 5,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      counterText: "",
                                      labelText: "Amount (g)",
                                      labelStyle: TextStyle(
                                        color: Colors.white,
                                      )),
                                    style: const TextStyle(
                                    color: Colors.white,
                                  ),

                                  onChanged: (text){
                                    setState(() {

                                      double? prevTotCal = total_calories;

                                      if(text.isEmpty){
                                        total_calories = prevTotCal;
                                      } else{
                                        total_calories = (total_calories! - int.parse(text) * 10);
                                      }



                                    });
                                  }
                                  // onSaved: (text) {
                                  //   _bmm_intake = text!;
                                  // },
                                ),
                              ),

                            ],
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 230,
                                  child: DropdownSearch<String>(
                                    mode: Mode.MENU,
                                    showSelectedItems: true,
                                    items: foodItems,
                                    dropdownSearchDecoration: const InputDecoration(
                                      labelText: "Side 1",
                                      hintText: "Non veg side",
                                    ),
                                    showSearchBox: true,
                                    searchFieldProps: const TextFieldProps(
                                      cursorColor: Colors.green,
                                    ),
                                  )
                              ),
                              const SizedBox(width: 10,),
                              SizedBox(
                                width: 100,
                                child: TextFormField(
                                  maxLength: 5,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      counterText: "",
                                      labelText: "Amount (g)",
                                      labelStyle: TextStyle(
                                        color: Colors.white,
                                      )),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  onSaved: (text) {
                                    _bmm_intake = text!;
                                  },
                                ),
                              ),







                            ],
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,

                          child: Row(
                            children: [
                              SizedBox(
                                  width: 230,
                                  child: DropdownSearch<String>(
                                    mode: Mode.MENU,
                                    showSelectedItems: true,
                                    items: foodItems,
                                    dropdownSearchDecoration: const InputDecoration(
                                      labelText: "Side 2",
                                      hintText: "Veg side option 1",
                                    ),
                                    showSearchBox: true,
                                    searchFieldProps: const TextFieldProps(
                                      cursorColor: Colors.green,
                                    ),
                                  )
                              ),
                              const SizedBox(width: 10,),
                              SizedBox(
                                width: 100,
                                child: TextFormField(
                                  maxLength: 5,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      counterText: "",
                                      labelText: "Amount (g)",
                                      labelStyle: TextStyle(
                                        color: Colors.white,
                                      )),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  onSaved: (text) {
                                    _bmm_intake = text!;
                                  },
                                ),
                              ),







                            ],
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 230,
                                  child: DropdownSearch<String>(
                                    mode: Mode.MENU,
                                    showSelectedItems: true,
                                    items: foodItems,
                                    dropdownSearchDecoration: const InputDecoration(
                                      labelText: "Side 3",
                                      hintText: "Veg option 2",
                                    ),
                                    showSearchBox: true,
                                    searchFieldProps: const TextFieldProps(
                                      cursorColor: Colors.green,
                                    ),
                                  )
                              ),
                              const SizedBox(width: 10,),
                              SizedBox(
                                width: 100,
                                child: TextFormField(
                                  maxLength: 5,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      counterText: "",
                                      labelText: "Amount (g)",
                                      labelStyle: TextStyle(
                                        color: Colors.white,
                                      )),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  onSaved: (text) {
                                    _bmm_intake = text!;
                                  },
                                ),
                              ),







                            ],
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 230,
                                  child: DropdownSearch<String>(
                                    mode: Mode.MENU,
                                    showSelectedItems: true,
                                    items: foodItems,
                                    dropdownSearchDecoration: const InputDecoration(
                                      labelText: "Desert",
                                      hintText: "desert",
                                    ),
                                    showSearchBox: true,
                                    searchFieldProps: const TextFieldProps(
                                      cursorColor: Colors.green,
                                    ),
                                  )
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 30),
                    child: Column(
                      children: [
                        Text(
                          "Lunch Plan ${total_calories! * 45~/100}",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 20,
                            letterSpacing: 2,
                          ),
                        ),


                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 230,
                                  child: DropdownSearch<String>(
                                    mode: Mode.MENU,
                                    showSelectedItems: true,
                                    items: foodItems,
                                    dropdownSearchDecoration: const InputDecoration(
                                      labelText: "Main Meal",
                                      hintText: "Your main food",
                                    ),
                                    showSearchBox: true,
                                    searchFieldProps: const TextFieldProps(
                                      cursorColor: Colors.green,
                                    ),
                                  )
                              ),
                              const SizedBox(width: 10,),
                              SizedBox(
                                width: 100,
                                child: TextFormField(
                                  maxLength: 5,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      counterText: "",
                                      labelText: "Amount (g)",
                                      labelStyle: TextStyle(
                                        color: Colors.white,
                                      )),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  // onSaved: (text) {
                                  //   _bmm_intake = text!;
                                  // },
                                ),
                              ),

                            ],
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 230,
                                  child: DropdownSearch<String>(
                                    mode: Mode.MENU,
                                    showSelectedItems: true,
                                    items: foodItems,
                                    dropdownSearchDecoration: const InputDecoration(
                                      labelText: "Side 1",
                                      hintText: "Non veg side",
                                    ),
                                    showSearchBox: true,
                                    searchFieldProps: const TextFieldProps(
                                      cursorColor: Colors.green,
                                    ),
                                  )
                              ),
                              const SizedBox(width: 10,),
                              SizedBox(
                                width: 100,
                                child: TextFormField(
                                  maxLength: 5,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      counterText: "",
                                      labelText: "Amount (g)",
                                      labelStyle: TextStyle(
                                        color: Colors.white,
                                      )),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  onSaved: (text) {
                                    _bmm_intake = text!;
                                  },
                                ),
                              ),







                            ],
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,

                          child: Row(
                            children: [
                              SizedBox(
                                  width: 230,
                                  child: DropdownSearch<String>(
                                    mode: Mode.MENU,
                                    showSelectedItems: true,
                                    items: foodItems,
                                    dropdownSearchDecoration: const InputDecoration(
                                      labelText: "Side 2",
                                      hintText: "Veg side option 1",
                                    ),
                                    showSearchBox: true,
                                    searchFieldProps: const TextFieldProps(
                                      cursorColor: Colors.green,
                                    ),
                                  )
                              ),
                              const SizedBox(width: 10,),
                              SizedBox(
                                width: 100,
                                child: TextFormField(
                                  maxLength: 5,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      counterText: "",
                                      labelText: "Amount (g)",
                                      labelStyle: TextStyle(
                                        color: Colors.white,
                                      )),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  onSaved: (text) {
                                    _bmm_intake = text!;
                                  },
                                ),
                              ),







                            ],
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 230,
                                  child: DropdownSearch<String>(
                                    mode: Mode.MENU,
                                    showSelectedItems: true,
                                    items: foodItems,
                                    dropdownSearchDecoration: const InputDecoration(
                                      labelText: "Side 3",
                                      hintText: "Veg option 2",
                                    ),
                                    showSearchBox: true,
                                    searchFieldProps: const TextFieldProps(
                                      cursorColor: Colors.green,
                                    ),
                                  )
                              ),
                              const SizedBox(width: 10,),
                              SizedBox(
                                width: 100,
                                child: TextFormField(
                                  maxLength: 5,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      counterText: "",
                                      labelText: "Amount (g)",
                                      labelStyle: TextStyle(
                                        color: Colors.white,
                                      )),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  onSaved: (text) {
                                    _bmm_intake = text!;
                                  },
                                ),
                              ),







                            ],
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 230,
                                  child: DropdownSearch<String>(
                                    mode: Mode.MENU,
                                    showSelectedItems: true,
                                    items: foodItems,
                                    dropdownSearchDecoration: const InputDecoration(
                                      labelText: "Desert",
                                      hintText: "desert",
                                    ),
                                    showSearchBox: true,
                                    searchFieldProps: const TextFieldProps(
                                      cursorColor: Colors.green,
                                    ),
                                  )
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 30),
                    child: Column(
                      children: [
                        Text(
                          "Dinner Plan ${total_calories! * 25~/100}",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 20,
                            letterSpacing: 2,
                          ),
                        ),


                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 230,
                                  child: DropdownSearch<String>(
                                    mode: Mode.MENU,
                                    showSelectedItems: true,
                                    items: foodItems,
                                    dropdownSearchDecoration: const InputDecoration(
                                      labelText: "Main Meal",
                                      hintText: "Your main food",
                                    ),
                                    showSearchBox: true,
                                    searchFieldProps: const TextFieldProps(
                                      cursorColor: Colors.green,
                                    ),
                                    validator: (String? text){
                                      if (text == null){
                                        return "Name Cannot be empty";
                                      } else{
                                        return null;
                                      }
                                    },
                                    onSaved: (text){
                                      _bmm_intake = text;
                                    },
                                  )
                              ),
                              const SizedBox(width: 10,),
                              SizedBox(
                                width: 100,
                                child: TextFormField(
                                  maxLength: 5,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      counterText: "",
                                      labelText: "Amount (g)",
                                      labelStyle: TextStyle(
                                        color: Colors.white,
                                      )),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  // onSaved: (text) {
                                  //   _bmm_intake = text!;
                                  // },
                                ),
                              ),

                            ],
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 230,
                                  child: DropdownSearch<String>(
                                    mode: Mode.MENU,
                                    showSelectedItems: true,
                                    items: foodItems,
                                    dropdownSearchDecoration: const InputDecoration(
                                      labelText: "Side 1",
                                      hintText: "Non veg side",
                                    ),
                                    showSearchBox: true,
                                    searchFieldProps: const TextFieldProps(
                                      cursorColor: Colors.green,
                                    ),
                                  )
                              ),
                              const SizedBox(width: 10,),
                              SizedBox(
                                width: 100,
                                child: TextFormField(
                                  maxLength: 5,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      counterText: "",
                                      labelText: "Amount (g)",
                                      labelStyle: TextStyle(
                                        color: Colors.white,
                                      )),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  onSaved: (text) {
                                    _bmm_intake = text!;
                                  },
                                ),
                              ),







                            ],
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,

                          child: Row(
                            children: [
                              SizedBox(
                                  width: 230,
                                  child: DropdownSearch<String>(
                                    mode: Mode.MENU,
                                    showSelectedItems: true,
                                    items: foodItems,
                                    dropdownSearchDecoration: const InputDecoration(
                                      labelText: "Side 2",
                                      hintText: "Veg side option 1",
                                    ),
                                    showSearchBox: true,
                                    searchFieldProps: const TextFieldProps(
                                      cursorColor: Colors.green,
                                    ),
                                  )
                              ),
                              const SizedBox(width: 10,),
                              SizedBox(
                                width: 100,
                                child: TextFormField(
                                  maxLength: 5,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      counterText: "",
                                      labelText: "Amount (g)",
                                      labelStyle: TextStyle(
                                        color: Colors.white,
                                      )),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  onSaved: (text) {
                                    _bmm_intake = text!;
                                  },
                                ),
                              ),







                            ],
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 230,
                                  child: DropdownSearch<String>(
                                    mode: Mode.MENU,
                                    showSelectedItems: true,
                                    items: foodItems,
                                    dropdownSearchDecoration: const InputDecoration(
                                      labelText: "Side 3",
                                      hintText: "Veg option 2",
                                    ),
                                    showSearchBox: true,
                                    searchFieldProps: const TextFieldProps(
                                      cursorColor: Colors.green,
                                    ),
                                  )
                              ),
                              const SizedBox(width: 10,),
                              SizedBox(
                                width: 100,
                                child: TextFormField(
                                  maxLength: 5,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      counterText: "",
                                      labelText: "Amount (g)",
                                      labelStyle: TextStyle(
                                        color: Colors.white,
                                      )),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  onSaved: (text) {
                                    _bmm_intake = text!;
                                  },
                                ),
                              ),







                            ],
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 230,
                                  child: DropdownSearch<String>(
                                    mode: Mode.MENU,
                                    showSelectedItems: true,
                                    items: foodItems,
                                    dropdownSearchDecoration: const InputDecoration(
                                      labelText: "Desert",
                                      hintText: "desert",
                                    ),
                                    showSearchBox: true,
                                    searchFieldProps: const TextFieldProps(
                                      cursorColor: Colors.green,
                                    ),
                                  )
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          // print(_startingDate);
                          // print(_expectedDate);
                          // print(_expectedWeight);
                          // print(_currentWeight);
                        }
                      },
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Row(
                          children: const [
                            Text(
                              "Confirm Meal Plan",
                              style: TextStyle(
                                  letterSpacing: 3,
                                fontFamily: "Arial"
                              ),
                            ),
                            Icon(Icons.check),
                          ],
                        ),
                      )


                  ),
                ],
              ))








            ],

          ),
        ),
      ),

    );
  }
}