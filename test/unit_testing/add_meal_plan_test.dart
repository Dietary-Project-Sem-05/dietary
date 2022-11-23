import 'package:dietary_project/screens/add_food_item.dart';
import 'package:dietary_project/screens/add_meal_plan.dart';
import 'package:test/test.dart';

void main() {
  test("Empty field in Meal plan drop down", () {
    var result = ValidatorHelper.amountFiledMain("");
    expect(result, "Enter amount");
  });

  test("Empty field in Amount", () {
    var result = ValidatorHelper.dropdownMain(null);
    expect(result, "Main meal can't be empty");
  });
}
