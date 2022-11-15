import 'package:dietary_project/Model/account_model.dart';
import 'package:dietary_project/Model/general_user_model.dart';
import 'dart:io' as io;
import 'package:postgres/postgres.dart';
import 'package:dietary_project/DatabaseHandler/DbConnector.dart';

class AccountDBHandler {
  late DbConnector dbConn;
  late PostgreSQLConnection connection;

  initDatabaseConnection(){
    dbConn = DbConnector();
    connection = dbConn.getConnection;
    dbConn.initConnection();
  }

  Future<String?> checkUserName(String username) async {
    var conn = await connection;

    List<List<dynamic>> results = await conn.query(
        'SELECT * FROM "Account" WHERE username= @usernameValue',
        substitutionValues: {
          'usernameValue': username,
        });

    if (results.length > 0) {
      return "Error";
    }

    return null;
  }

  Future<int?> saveRegistrationData(AccountModel user) async {
    var conn = await connection;
    List<List<dynamic>>? gUserResults;
    int? accountNo;

    await conn.transaction((ctx) async {
      gUserResults = await ctx.query(
          'INSERT INTO "GeneralUser"(gender) VALUES (@gender) RETURNING id',
          substitutionValues: {
            "gender": 'Temp',
          });

      accountNo = await gUserResults![0][0];

      await ctx.query(
          'INSERT INTO "Account"("accountNo", "firstName", "lastName", username, email, password) VALUES '
          '(@accountNo, @firstName, @lastName, @username, @email, @password);',
          substitutionValues: {
            "accountNo": accountNo,
            "firstName": user.first_name,
            "lastName": user.last_name,
            "username": user.user_name,
            "email": user.email,
            "password": user.password,
          });
    });

    return accountNo;
  }

  Future<void> saveGeneralInfoData(
      GeneralUserModel model, int accountNo) async {
    var conn = await connection;

    await conn.transaction((ctx) async {
      await ctx.query(
          'UPDATE "GeneralUser" SET "dateOfBirth"=@dateOfBirth, weight=@weight, height=@height, "activityTime"=@activityTime, "goalType"=@goalType, "dietGoal"=@dietGoal, "medicalConditions"=@medicalConditions, gender=@gender WHERE id=@id;',
          substitutionValues: {
            "dateOfBirth": model.dob,
            "weight": model.weight,
            "height": model.height,
            "activityTime": model.activityType,
            "goalType": model.exerciseType,
            "dietGoal": model.preferenceType,
            "medicalConditions": model.medicalCondition,
            "gender": model.gender,
            "id": accountNo,
          });
    });
  }

  Future<AccountModel?> getLoginUser(String userName, String password) async {
    var conn = await connection;

    List<List<dynamic>>? loginResults;

    await conn.transaction((ctx) async {
      loginResults = await ctx.query(
          'SELECT * FROM "Account" WHERE username = @usernameValue AND password = @passwordValue',
          substitutionValues: {
            "usernameValue": userName,
            "passwordValue": password,
          });
    });

    if ((loginResults?.length)! > 0) {
      List? firstItem = loginResults?.first;

      AccountModel accMdl = AccountModel(
        firstItem![3],
        firstItem[4],
        firstItem[5],
        firstItem[6],
        firstItem[7],
      );

      accMdl.setUserId = firstItem[0];
      accMdl.setUserNo = firstItem[1];

      return accMdl;
    } else {
      return null;
    }
  }
}
