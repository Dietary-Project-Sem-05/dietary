import 'package:dietary_project/screens/home_page.dart';
import 'package:test/test.dart';

void main() {

  test("Weight cannot be empty", () {
    var result = HelpValidator.validateWeight("");
    expect(result, "Weight cannot be empty");
  });

  test("Weight cannot be 0", () {
    var result = HelpValidator.validateWeight("0");
    expect(result, "Weight cannot be 0");
  });

  test("Weight cannot be negative", () {
    var result = HelpValidator.validateWeight("-3");
    expect(result, "Weight cannot be negative");
  });

  test("Weight not in range", () {
    var result = HelpValidator.validateWeight("650");
    expect(result, "Weight is out of range");
  });

  test("Height cannot be empty", () {
    var result = HelpValidator.validateHeight("");
    expect(result, "Height cannot be empty");
  });

  test("Height cannot be 0", () {
    var result = HelpValidator.validateHeight('0');
    expect(result, "Height cannot be 0");
  });

  test("Height cannot be negative", () {
    var result = HelpValidator.validateHeight("-3");
    expect(result, "Height cannot be negative");
  });

  test("Height is not in range", () {
    var result = HelpValidator.validateHeight("650");
    expect(result, "Height is out of range");
  });
}
