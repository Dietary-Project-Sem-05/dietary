class MealPlanModal {
  String? plan_name;
  Map breakfast;
  Map lunch;
  Map dinner;
  String? breakfastTitle;
  String? lunchTitle;
  String? dinnerTitle;

  int? id;
  final DateTime createdTime;


  MealPlanModal(
      this.id,
      this.plan_name,
      this.breakfast,
      this.lunch,
      this.dinner,
      this.createdTime){
    breakfastTitle = "${breakfast.keys.toList()[0]} with ${breakfast.keys.toList()[1]}";
    lunchTitle = "${lunch.keys.toList()[0]} with ${lunch.keys.toList()[1]}";
    dinnerTitle = "${dinner.keys.toList()[0]} with ${dinner.keys.toList()[1]}";

  }


}
