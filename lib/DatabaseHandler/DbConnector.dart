import 'package:postgres/postgres.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DbConnector{
  PostgreSQLConnection connection = PostgreSQLConnection(
    
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