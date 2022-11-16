import 'package:dietary_project/Model/account_model.dart';

class GeneralUserModel extends AccountModel {
  DateTime? dob;
  String? gender;
  int? weight;
  int? height;
  String? activity_time;
  String? goal_type;
  String? diet_goal;
  String? medical_conditions;

  GeneralUserModel(
    super.first_name,
    super.last_name,
    super.user_name,
    super.email,
    super.password,
    this.dob,
    this.gender,
    this.weight,
    this.height,
    this.activity_time,
    this.goal_type,
    this.diet_goal,
    this.medical_conditions,
  );
}
