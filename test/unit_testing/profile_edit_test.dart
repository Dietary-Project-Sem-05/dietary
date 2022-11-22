import 'package:dietary_project/screens/profile_edit.dart';
import 'package:test/test.dart';

void main() {
  test("Weight cannot be Empty", () {
    var result = HelpValidator.validateWeight("");
    expect(result, "Cannot be empty");
  });

  test("Weight cannot be 0", () {
    var result = HelpValidator.validateWeight("0");
    expect(result, "Value must be positive");
  });

  test("Weight cannot be negative", () {
    var result = HelpValidator.validateWeight("-3");
    expect(result, "Value must be positive");
  });

  test("Weight not in range", () {
    var result = HelpValidator.validateWeight("650");
    expect(result, "Value is not in range");
  });

  test("Height cannot be Empty", () {
    var result = HelpValidator.validateHeight("");
    expect(result, "Cannot be empty");
  });

  test("Height cannot be 0", () {
    var result = HelpValidator.validateHeight("0");
    expect(result, "Value must be positive");
  });

  test("Height cannot be negative", () {
    var result = HelpValidator.validateHeight("-3");
    expect(result, "Value must be positive");
  });

  test("Height is not in range", () {
    var result = HelpValidator.validateHeight("650");
    expect(result, "Value is not in range");
  });
}
