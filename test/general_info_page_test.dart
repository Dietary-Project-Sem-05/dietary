import 'package:dietary_project/screens/general_info_page.dart';
import 'package:test/test.dart';

void main(){

  test("Empty DoB field returns error string", () {
    var result = HelpValidator.validateDate("");
    expect(result, "Date of Birth cannot be empty");
  });

  test("Empty Weight field returns error string", () {
    var result = HelpValidator.validateWeight("");
    expect(result, "Cannot be empty");
  });

  test("Non-positive Weight field returns error string", () {
    var result = HelpValidator.validateWeight("-56");
    expect(result, "Value must be positive");
  });

  test("Value of Weight more than 600 kg field returns error string", () {
    var result = HelpValidator.validateWeight("800");
    expect(result, "Value is not in range");
  });

  test("Empty Height field returns error string", () {
    var result = HelpValidator.validateHeight("");
    expect(result, "Cannot be empty");
  });

  test("Non-positive Weight field returns error string", () {
    var result = HelpValidator.validateHeight("-56");
    expect(result, "Value must be positive");
  });

  test("Value of Weight more than 800 cm field returns error string", () {
    var result = HelpValidator.validateHeight("800");
    expect(result, "Value is not in range");
  });

  test("NULL Activity field returns error string", () {
    var result = HelpValidator.validateActivity(null);
    expect(result, "Cannot be empty");
  });

  test("NULL gender field returns error string", () {
    var result = HelpValidator.validateGender(null);
    expect(result, "Cannot be empty");
  });

  test("NULL meal preference field returns error string", () {
    var result = HelpValidator.validateMealPreference(null);
    expect(result, "Cannot be empty");
  });

  test("NULL starting day field returns error string", () {
    var result = HelpValidator.validateStartingDay(null);
    expect(result, "Cannot be empty");
  });

  test("NULL notification day field returns error string", () {
    var result = HelpValidator.validateNotificationDay(null);
    expect(result, "Cannot be empty");
  });

  test("Empty Medical conditions field returns error string", () {
    var result = HelpValidator.validateMedicalConditions("");
    expect(result, "Cannot be empty");
  });

}