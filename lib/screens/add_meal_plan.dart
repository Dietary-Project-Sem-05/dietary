
import 'package:dietary_project/DatabaseHandler/FoodItemDbHandler.dart';
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

  // main states
  var _planName;

  // Breakfast form states
  var _bmmName;
  var _bmmAmount;

  var _bs1Name;
  var _bs1Amount;

  var _bs2Name;
  var _bs2Amount;

  var _bs3Name;
  var _bs3Amount;

  var _bdName;
  var _bdAmount;

  // lunch form states
  var _lmmName;
  var _lmmAmount;

  var _ls1Name;
  var _ls1Amount;

  var _ls2Name;
  var _ls2Amount;

  var _ls3Name;
  var _ls3Amount;

  var _ldName;
  var _ldAmount;

  // dinner form states
  var _dmmName;
  var _dmmAmount;

  var _ds1Name;
  var _ds1Amount;

  var _ds2Name;
  var _ds2Amount;

  var _ds3Name;
  var _ds3Amount;

  var _ddName;
  var _ddAmount;


  late Map<String, double> mainFoods;
  late Map<String, double> sidesMeatsFoods;
  late Map<String, double> sidesFoods;
  late Map<String, double> deserts;

  late FoodItemDbHandler dbHandler;

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context){
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
                  'Error : ${snapshot.error}',
                )
              );
            } else{
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
                                onSaved: (text) {
                                  _planName = text!;
                                  print(_planName);
                                },
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
                                              items: mainFoods.keys.toList(),
                                              dropdownSearchDecoration: const InputDecoration(
                                                labelText: "Main Meal",
                                                hintText: "Your main food",
                                              ),
                                              showSearchBox: true,
                                              searchFieldProps: const TextFieldProps(
                                                cursorColor: Colors.green,
                                              ),
                                              onChanged: (text){
                                                _bmmName = text;
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

                                              onChanged: (text){
                                                _bmmAmount = int.parse(text);
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
                                              items: sidesMeatsFoods.keys.toList(),
                                              dropdownSearchDecoration: const InputDecoration(
                                                labelText: "Side 1",
                                                hintText: "Non veg side",
                                              ),
                                              showSearchBox: true,
                                              searchFieldProps: const TextFieldProps(
                                                cursorColor: Colors.green,
                                              ),
                                              onChanged: (text) {
                                                _bs1Name = text;
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
                                            onChanged: (text) {
                                              _bs1Amount = int.parse(text);
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
                                              items: sidesFoods.keys.toList(),
                                              dropdownSearchDecoration: const InputDecoration(
                                                labelText: "Side 2",
                                                hintText: "Veg side option 1",
                                              ),
                                              showSearchBox: true,
                                              searchFieldProps: const TextFieldProps(
                                                cursorColor: Colors.green,
                                              ),
                                              onChanged: (text){
                                                _bs2Name = text;
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
                                            onSaved: (text) {
                                              _bs2Amount = int.parse(text!);
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
                                              items: sidesFoods.keys.toList(),
                                              dropdownSearchDecoration: const InputDecoration(
                                                labelText: "Side 3",
                                                hintText: "Veg option 2",
                                              ),
                                              showSearchBox: true,
                                              searchFieldProps: const TextFieldProps(
                                                cursorColor: Colors.green,
                                              ),
                                              onChanged: (text){
                                                _bs3Name = text;
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
                                            onSaved: (text) {
                                              _bs3Amount = int.parse(text!);
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
                                              items: deserts.keys.toList(),
                                              dropdownSearchDecoration: const InputDecoration(
                                                labelText: "Desert",
                                                hintText: "desert",
                                              ),
                                              showSearchBox: true,
                                              searchFieldProps: const TextFieldProps(
                                                cursorColor: Colors.green,
                                              ),
                                              onChanged: (text){
                                                _bdName = text;
                                              },
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
                                              items: mainFoods.keys.toList(),
                                              dropdownSearchDecoration: const InputDecoration(
                                                labelText: "Main Meal",
                                                hintText: "Your main food",
                                              ),
                                              showSearchBox: true,
                                              searchFieldProps: const TextFieldProps(
                                                cursorColor: Colors.green,
                                              ),
                                              onChanged: (text){
                                                _lmmName = text;
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
                                            onSaved: (text) {
                                              _lmmAmount = int.parse(text!);
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
                                              items: sidesMeatsFoods.keys.toList(),
                                              dropdownSearchDecoration: const InputDecoration(
                                                labelText: "Side 1",
                                                hintText: "Non veg side",
                                              ),
                                              showSearchBox: true,
                                              searchFieldProps: const TextFieldProps(
                                                cursorColor: Colors.green,
                                              ),
                                              onChanged: (text){
                                                _ls1Name = text;
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
                                            onSaved: (text) {
                                              _ls1Amount = int.parse(text!);
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
                                              items: sidesFoods.keys.toList(),
                                              dropdownSearchDecoration: const InputDecoration(
                                                labelText: "Side 2",
                                                hintText: "Veg side option 1",
                                              ),
                                              showSearchBox: true,
                                              searchFieldProps: const TextFieldProps(
                                                cursorColor: Colors.green,
                                              ),
                                              onChanged: (text){
                                                _ls2Name = text;
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
                                            onSaved: (text) {
                                              _ls2Amount = int.parse(text!);
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
                                              items: sidesFoods.keys.toList(),
                                              dropdownSearchDecoration: const InputDecoration(
                                                labelText: "Side 3",
                                                hintText: "Veg option 2",
                                              ),
                                              showSearchBox: true,
                                              searchFieldProps: const TextFieldProps(
                                                cursorColor: Colors.green,
                                              ),
                                              onChanged: (text){
                                                _ls3Name = text;
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
                                            onSaved: (text) {
                                              _ls3Amount = int.parse(text!);
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
                                              items: deserts.keys.toList(),
                                              dropdownSearchDecoration: const InputDecoration(
                                                labelText: "Desert",
                                                hintText: "desert",
                                              ),
                                              showSearchBox: true,
                                              searchFieldProps: const TextFieldProps(
                                                cursorColor: Colors.green,
                                              ),
                                              onChanged: (text){
                                                _ldName = text;
                                              },
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
                                              items: mainFoods.keys.toList(),
                                              dropdownSearchDecoration: const InputDecoration(
                                                labelText: "Main Meal",
                                                hintText: "Your main food",
                                              ),
                                              showSearchBox: true,
                                              searchFieldProps: const TextFieldProps(
                                                cursorColor: Colors.green,
                                              ),
                                              // validator: (String? text){
                                              //   if (text == null){
                                              //     return "Name Cannot be empty";
                                              //   } else{
                                              //     return null;
                                              //   }
                                              // },
                                              onChanged: (text){
                                                _dmmName = text;
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
                                            onSaved: (text) {
                                              _dmmAmount = int.parse(text!);
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
                                              items: sidesMeatsFoods.keys.toList(),
                                              dropdownSearchDecoration: const InputDecoration(
                                                labelText: "Side 1",
                                                hintText: "Non veg side",
                                              ),
                                              showSearchBox: true,
                                              searchFieldProps: const TextFieldProps(
                                                cursorColor: Colors.green,
                                              ),
                                              onChanged: (text){
                                                _ds1Name = text;
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
                                            onSaved: (text) {
                                              _ds1Amount = int.parse(text!);
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
                                              items: sidesFoods.keys.toList(),
                                              dropdownSearchDecoration: const InputDecoration(
                                                labelText: "Side 2",
                                                hintText: "Veg side option 1",
                                              ),
                                              showSearchBox: true,
                                              searchFieldProps: const TextFieldProps(
                                                cursorColor: Colors.green,
                                              ),
                                              onChanged: (text){
                                                _ds2Name = text;
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
                                            onSaved: (text) {
                                              _ds2Amount = int.parse(text!);
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
                                              items: sidesFoods.keys.toList(),
                                              dropdownSearchDecoration: const InputDecoration(
                                                labelText: "Side 3",
                                                hintText: "Veg option 2",
                                              ),
                                              showSearchBox: true,
                                              searchFieldProps: const TextFieldProps(
                                                cursorColor: Colors.green,
                                              ),
                                              onChanged: (text){
                                                _ds3Name = text;
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
                                            onSaved: (text) {
                                              _ds3Amount = int.parse(text!);
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
                                              items: deserts.keys.toList(),
                                              dropdownSearchDecoration: const InputDecoration(
                                                labelText: "Desert",
                                                hintText: "desert",
                                              ),
                                              showSearchBox: true,
                                              searchFieldProps: const TextFieldProps(
                                                cursorColor: Colors.green,
                                              ),
                                              onChanged: (text){
                                                _ddName = text;
                                              },
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
                                  // if (_formKey.currentState!.validate()) {
                                  //   _formKey.currentState!.save();
                                  //
                                  //   print(_bmmName);
                                  //   print(_bmmAmount);
                                  //   print(_planName);
                                  // }

                                  Map breakfastMeal = {
                                    _bmmName: _bmmAmount,
                                    _bs1Name: _bs1Amount,
                                    _bs2Name: _bs2Amount,
                                    _bs3Name: _bs3Amount,
                                    _bdName: deserts[_bdName]
                                  };

                                  print(breakfastMeal);

                                  _bmmName = null;
                                  _bmmAmount = null;

                                  _bs1Name = null;
                                  _bs1Amount = null;

                                  _bs2Name = null;
                                  _bs2Amount = null;

                                  _bs3Name = null;
                                  _bs3Amount = null;

                                  _bdName = null;
                                  _bdAmount = null;

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
        });
  }

  Future<String> downloadData() async{
    dbHandler = await FoodItemDbHandler();
    await dbHandler.initDatabaseConnection();

    List? foodItems = await dbHandler.getFoodDetails();

    print(foodItems);
    mainFoods = foodItems![0];
    sidesMeatsFoods = foodItems[1];
    sidesFoods = foodItems[2];
    deserts = foodItems[3];

    return "Data download successful";


  }
}