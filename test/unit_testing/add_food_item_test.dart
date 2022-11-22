import 'package:dietary_project/screens/add_food_item.dart';
import 'package:test/test.dart';

void main() {

  test("Empty name returns error string", () {
    var result = HelpValidator.validateName("");
    expect(result, "Name cannot be empty");
  });

  test("Name cannot contain chars other than simple and block letters", () {
    var result = HelpValidator.validateName("Abcf#12_");
    expect(result, "Name contains invalid chars");
  });

  test("Calorie count cannot be empty", () {
    var result = HelpValidator.validateWeight("");
    expect(result, "Calorie count cannot be empty");
  });

  test("Calorie count must be positive", () {
    var result = HelpValidator.validateWeight("-89");
    expect(result, "Calorie count must be positive");
  });

  test("Calorie count cannot be 0", () {
    var result = HelpValidator.validateWeight("0");
    expect(result, "Calorie count cannot be 0");
  });

  test("Calorie count cannot be 0", () {
    var result = HelpValidator.validateType(null);
    expect(result, "Food type cannot be empty");
  });
}