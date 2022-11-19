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
}
