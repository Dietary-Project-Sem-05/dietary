import 'package:dietary_project/Model/food_item_model.dart';
import 'package:postgres/postgres.dart';
import 'package:dietary_project/DatabaseHandler/DbConnector.dart';

class FoodItemDbHandler {
  late DbConnector dbConn;
  late PostgreSQLConnection connection;

  initDatabaseConnection() async {
    dbConn = await DbConnector();
    connection = await dbConn.getConnection;
    await dbConn.initConnection();
  }

  Future<void> sendFoodRequest(FoodItemModel ftModel) async {
    var conn = await connection;

    await conn.transaction((ctx) async {
      await ctx.query('INSERT INTO "FoodItem"(name, calory, state, "foodCategory") VALUES (@name, @calorie, @state, @food_category)',
      substitutionValues: {
        'name': ftModel.name,
        'calorie' : ftModel.calory_count,
        'state': ftModel.state,
        'food_category': ftModel.category,
      });
    });
  }

  Future<List?> getFoodDetails() async{
    var conn = await connection;

    List<List<dynamic>>? foodResults;
    String foodType;
    List result;

    await conn.transaction((connection) async{
      foodResults = await connection.query(
        'SELECT name, calory, "foodCategory" FROM "FoodItem" WHERE "state" = 1 ORDER BY "name" DESC LIMIT 1'
      );
    });

    Map<String, double> mainFoodItems = {"Rice": 10.0, "Pasta": 11.0};
    Map<String, double> sidesMeatsFoods = {"Chicken": 100.0, "Beef": 200, "Pork": 150};
    Map<String, double> sidesFoods = {"Brocali": 10.0, "Brinjal": 12};
    Map<String, double> deserts = {"Banana": 10.0};

    if ((foodResults?.length)! > 0){
      for(int i = 0; i < foodResults!.length; i++){

        result = foodResults![i];

        foodType = result[2];

        switch(foodType){
          case "MAIN":
            mainFoodItems[result[0]] = double.parse(result[1].toString());
            continue;
          case "MEAT":
            sidesMeatsFoods[result[0]] = double.parse(result[1].toString());
            continue;
          case "SIDE":
            sidesFoods[result[0]] = double.parse(result[1].toString());
            continue;
          case "DESERT":
            deserts[result[0]] = double.parse(result[1].toString());
            continue;
        }


      }

      return [mainFoodItems, sidesMeatsFoods, sidesFoods, deserts];

    } else{

      return null;
    }



  }
}
