import 'package:dietary_project/DatabaseHandler/GoalDBHandler.dart';
import 'package:dietary_project/Model/user_goal_model.dart';
import 'package:dietary_project/screens/set_goals_edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:get_storage/get_storage.dart';

class SetGoalsPage extends StatefulWidget {
  const SetGoalsPage({Key? key}) : super(key: key);

  @override
  State<SetGoalsPage> createState() => _SetGoalsPageState();
}

class _SetGoalsPageState extends State<SetGoalsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final box = GetStorage();

  late GoalDBHandler dbHandler;

  var _accountNo;
  var _currentWeight;
  var _expectedWeight;
  var _startingDate;
  var _expectedDate;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() {
    _accountNo = box.read("user_no");
  }

  editGoal(){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => SetGoalsEditPage()
        ));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: downloadData(),
        builder: (
          BuildContext context,
          AsyncSnapshot<String> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Material(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  SizedBox(height: 20),
                  CircularProgressIndicator()
                ],
              ),
            );
          } else {
            if (snapshot.hasError) {
              print(snapshot.error);
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                ),
              );
            } else {
              return Scaffold(
                  appBar: AppBar(
                    title: Text('Set Goal'),
                    backgroundColor: Colors.black38,
                  ),
                  body: Container(
                      constraints: const BoxConstraints.expand(),
                      decoration: const BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage("lib/assets/images/back.jpg"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              height: 400.0,
                              width: 350.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 45.0, vertical: 145.0),
                              padding: const EdgeInsets.all(20.0),
                              child: Form(
                                key: _formKey,
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        children: [
                                          const Text("Current Weight"),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: TextFormField(
                                              initialValue:
                                                  _currentWeight.toString(),
                                              autofocus: false,
                                              enabled: false,
                                              style:
                                                  const TextStyle(fontSize: 14),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text("Starting Date  "),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: TextFormField(
                                              initialValue:
                                                  _startingDate.toString(),
                                              autofocus: false,
                                              enabled: false,
                                              style:
                                                  const TextStyle(fontSize: 14),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text("Expected Weight"),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: TextFormField(
                                              initialValue:
                                                  _expectedWeight.toString(),
                                              autofocus: false,
                                              enabled: false,
                                              style:
                                                  const TextStyle(fontSize: 14),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text("Expected Date  "),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: TextFormField(
                                              initialValue:
                                                  _expectedDate.toString(),
                                              autofocus: false,
                                              enabled: false,
                                              style:
                                                  const TextStyle(fontSize: 14),
                                            ),
                                          )
                                        ],
                                      ),

                                      const SizedBox(
                                        height: 50,
                                      ),

                                      Container(
                                        child: ElevatedButton(
                                            onPressed: () {
                                              editGoal();
                                            },
                                            child: FittedBox(
                                              fit: BoxFit.fill,
                                              child: Row(
                                                children: const [
                                                  Text(
                                                    "Set Goal",
                                                    style: TextStyle(
                                                        letterSpacing: 3),
                                                  ),
                                                  Icon(Icons.flag),
                                                ],
                                              ),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )));
            }
          }
        });
  }

  Future<String> downloadData() async {
    dbHandler = await GoalDBHandler();
    await dbHandler.initDatabaseConnection();
    UserGoalModel? userGl = await dbHandler.getUserGoal(_accountNo);

    if(userGl == null){
      _startingDate = "NULL";
      _currentWeight = "NULL";
      _expectedDate = "NULL";
      _expectedWeight = "NULL";
      return "NULL";
    }else{
      _startingDate = await userGl.startDate;
      _currentWeight = await userGl.startWeight;
      _expectedDate = await userGl.endDate;
      _expectedWeight = await userGl.endWeight;
    }

    var formattedDateStart =
        await DateFormat('yyyy-MM-dd').format(_startingDate);
    var formattedDateEnd = await DateFormat('yyyy-MM-dd').format(_expectedDate);

    _startingDate = await formattedDateStart;
    _expectedDate = await formattedDateEnd;
    return "Data downloaded successfully!!";
  }
}
