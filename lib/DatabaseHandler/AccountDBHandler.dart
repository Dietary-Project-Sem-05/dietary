import 'package:dietary_project/Model/account_model.dart';
import 'package:dietary_project/Model/general_user_model.dart';
import 'dart:io' as io;
import 'package:postgres/postgres.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AccountDBHandler {
  var connection = PostgreSQLConnection(
    "dietary.postgres.database.azure.com",
    5432,
    "dietary",
    username: "chamod",
    password: "computer!9",
    timeoutInSeconds: 3600,
    queryTimeoutInSeconds: 3600,
    useSSL: true,
    allowClearTextPassword: true,
  );

  initDatabaseConnection() async {
    await connection.open().then((value) {
      Fluttertoast.showToast(
        msg: "Server Connected!!",
      );
    });
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

  Future<void> saveGeneralInfoData(GeneralUserModel model, int accountNo) async {
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
}
