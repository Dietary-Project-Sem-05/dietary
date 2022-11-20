import 'package:dietary_project/Model/meal_plan_modal.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert';

class MealPlanDatabase{
  static final MealPlanDatabase instance = MealPlanDatabase._init();

  static Database? _database;

  MealPlanDatabase._init();

  Future<Database> get database async{
    if (_database != null) return _database!;

    _database = await _initDB('meal_plan.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);

  }

  Future _createDB(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE meal_plan (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      breakfast TEXT NOT NULL,
      lunch TEXT NOT NULL,
      dinner TEXT NOT NULL,
      created_time TEXT NOT NULL
      )
      '''
    );
  }

  Future create(MealPlanModal mealPlan) async {
    final db = await instance.database;
    
    final id = await db.insert("meal_plan",
        {
          "name": mealPlan.plan_name,
          "breakfast" : MealPlanModal.fromJson(mealPlan.breakfast),
          "lunch" : MealPlanModal.fromJson(mealPlan.lunch),
          "dinner": MealPlanModal.fromJson(mealPlan.dinner),
          "created_time": mealPlan.createdTime.toIso8601String(),
        });

    mealPlan.id = id;
  }

  Future<List<MealPlanModal>> readMealPlans() async{
    final db = await instance.database;

    final maps = await db.query("meal_plan", orderBy: "name ASC");

    List<MealPlanModal> outputList = [];
    Map result;
    MealPlanModal tempMealModal;

    print(maps.length);

    for(int i = 0; i < maps.length; i++){


      result = maps[i];
      // db.delete("meal_plan",where: "ID = ${result['id']}");

      tempMealModal = MealPlanModal(
          result["id"],
          result["name"],
          MealPlanModal.toJson(result["breakfast"]),
          MealPlanModal.toJson(result["lunch"]),
          MealPlanModal.toJson(result["dinner"]),
          DateTime.parse(result["created_time"])
      );

      outputList.add(tempMealModal);

    }

    return outputList;


  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

}