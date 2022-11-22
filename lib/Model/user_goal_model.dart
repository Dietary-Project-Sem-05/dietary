class UserGoalModel {
  int? goalId;
  int? accountNo;
  DateTime? startDate;
  int? startWeight;
  DateTime? endDate;
  int? endWeight;
  int? state;

  UserGoalModel(
    this.goalId,
    this.accountNo,
    this.startDate,
    this.startWeight,
    this.endDate,
    this.endWeight,
    this.state,
  );

  UserGoalModel.withoutGoalId(
      this.accountNo,
      this.startDate,
      this.startWeight,
      this.endDate,
      this.endWeight,
      this.state,
      );

  set setGoalId(int goal_id) {
    this.goalId = goal_id;
  }
}
