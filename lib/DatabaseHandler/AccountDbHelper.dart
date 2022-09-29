import 'package:dietary_project/Model/account_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class AccountDbHelper {
  static Database? _db;

  static const String DB_Name = 'dietary.db';
  static const String Table_User = 'user';
  static const int Version = 1;

  static const String C_UserID = 'user_id';
  static const String C_UserName = 'user_name';
  static const String C_FirstName = 'first_name';
  static const String C_LastName = 'last_name';
  static const String C_Email = 'email';
  static const String C_Password = 'password';

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_Name);
    var db = await openDatabase(path, version: Version, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int intVersion) async {
    await db.execute("CREATE TABLE $Table_User ("
        " $C_UserID INTEGER PRIMARY KEY AUTOINCREMENT, "
        " $C_UserName TEXT NOT NULL, "
        " $C_FirstName TEXT NOT NULL, "
        " $C_LastName TEXT NOT NULL, "
        " $C_Email TEXT NOT NULL, "
        " $C_Password TEXT NOT NULL, "
        " UNIQUE ($C_UserName) "
        ")");
  }

  Future<int> saveData(AccountModel user) async {
    var dbClient = await db;
    var res = await dbClient!.insert(Table_User, user.toMap());
    return res;
  }

  Future<AccountModel?> getLoginUser(String userName, String password) async {
    var dbClient = await db;
    var res = await dbClient!.rawQuery("SELECT * FROM $Table_User WHERE "
        "$C_UserName = '$userName' AND "
        "$C_Password = '$password'");

    if (res.length > 0) {
      return AccountModel.fromMap(res.first);
    }

    return null;
  }

  Future<String?> checkUserName(String userName) async {
    var dbClient = await db;
    var res = await dbClient!.rawQuery("SELECT * FROM $Table_User WHERE "
        "$C_UserName = '$userName'");

    if (res.length > 0) {
      return "Error";
    }

    return null;
  }

  Future<int> updateUser(AccountModel user) async {
    var dbClient = await db;
    var res = await dbClient!.update(Table_User, user.toMap(),
        where: '$C_UserName = ?', whereArgs: [user.user_id]);
    return res;
  }

  Future<int> deleteUser(String user_id) async {
    var dbClient = await db;
    var res = await dbClient!
        .delete(Table_User, where: '$C_UserName = ?', whereArgs: [user_id]);
    return res;
  }
}