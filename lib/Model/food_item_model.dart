class FoodItemModel {
  int? food_id;
  String name;
  int state;
  int calory_count;
  String category;

  FoodItemModel(
    this.food_id,
    this.name,
    this.state,
    this.calory_count,
    this.category,
  );

  FoodItemModel.withoutFoodId(
    this.name,
    this.state,
    this.calory_count,
    this.category,
  );

  set setFoodId(int food_id) {
    this.food_id = food_id;
  }
}
