import 'package:dietary_project/Model/account_model.dart';

class GeneralUserModel {
  String? dob;
  String? gender;
  int? weight;
  int? height;
  String? activityType;
  String? exerciseType;
  String? preferenceType;
  String? medicalCondition;
  String? notificationDay;
  String? startingDay;

  GeneralUserModel(
    this.dob,
    this.gender,
    this.weight,
    this.height,
    this.activityType,
    this.exerciseType,
    this.preferenceType,
    this.medicalCondition,
    this.notificationDay,
    this.startingDay,
  );
}
