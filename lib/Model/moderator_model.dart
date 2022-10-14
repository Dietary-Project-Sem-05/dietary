import 'package:dietary_project/Model/account_model.dart';

class ModeratorModel extends AccountModel {
  bool is_active;
  String telephone_no;

  ModeratorModel(
    super.first_name,
    super.last_name,
    super.user_name,
    super.email,
    super.password,
    this.is_active,
    this.telephone_no,
  );
}
