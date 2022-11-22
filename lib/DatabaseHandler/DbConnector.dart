import 'package:postgres/postgres.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DbConnector{
  PostgreSQLConnection connection = PostgreSQLConnection(
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

  PostgreSQLConnection get getConnection{
    return connection;
  }

  initConnection() async {
    await connection.open().then((value) {
      Fluttertoast.showToast(
        msg: "Server Connected!!",
      );
    });
  }
}