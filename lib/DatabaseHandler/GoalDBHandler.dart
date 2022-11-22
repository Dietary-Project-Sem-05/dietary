import 'package:postgres/postgres.dart';
import 'package:dietary_project/DatabaseHandler/DbConnector.dart';
import 'package:dietary_project/Model/user_goal_model.dart';

class GoalDBHandler {
  late DbConnector dbConn;
  late PostgreSQLConnection connection;

  initDatabaseConnection() async {
    dbConn = await DbConnector();
    connection = await dbConn.getConnection;
    await dbConn.initConnection();
  }

  Future<UserGoalModel?> getUserGoal(int accountNo) async {
    var conn = await connection;

    List<List<dynamic>>? goalResults;

    await conn.transaction((ctx) async {
      goalResults = await ctx.query(
          'SELECT * FROM "UserGoal" WHERE "accountNo" = @account_no AND state=@state ORDER BY "accountNo" DESC LIMIT 1',
          substitutionValues: {
            "account_no": accountNo,
            "state": 0,
          });
    });

    if ((goalResults?.length)! > 0) {
      List? firstItem = goalResults?.first;

      UserGoalModel userGoalMdl = UserGoalModel(
        firstItem![0],
        firstItem[1],
        firstItem[2],
        firstItem[3],
        firstItem[4],
        firstItem[5],
        firstItem[6],
      );
      return userGoalMdl;
    } else {
      return null;
    }
  }

  Future<void> saveGoalDetails(UserGoalModel ugModel) async {
    var conn = await connection;

    await conn.transaction((ctx) async {
      await ctx.query(
          'INSERT INTO "UserGoal"("accountNo", "startDate", "startWeight", "endDate", "endWeight", state) VALUES (@account_no, @start_date, @start_weight, @end_date, @end_weight, @state) ON CONFLICT ("accountNo") DO UPDATE SET "startDate"=@start_date, "startWeight"=@start_weight, "endDate"=@end_date, "endWeight"=@end_weight, state=@state',
          substitutionValues: {
            'account_no': ugModel.accountNo,
            'start_date': ugModel.startDate,
            'start_weight': ugModel.startWeight,
            'end_date': ugModel.endDate,
            'end_weight': ugModel.endWeight,
            'state': ugModel.state,
          });
    });
  }

  Future<List?> getWeightAndGoalType(int accountNo) async {
    var conn = await connection;

    List<List<dynamic>>? weightResults;

    await conn.transaction((ctx) async {
      weightResults = await ctx.query(
          'SELECT weight, "goalType"  FROM "GeneralUser" WHERE "id" = @id',
          substitutionValues: {
            "id": accountNo,
          });
    });

    if ((weightResults?.length)! > 0) {

      return weightResults?.first;
    } else {
      return null;
    }
  }
}
