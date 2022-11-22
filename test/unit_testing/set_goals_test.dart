import 'package:dietary_project/screens/set_goals_edit.dart';
import 'package:test/test.dart';

void main(){

  test("Empty starting weight field returns error string", () {
     var result = HelpValidator.validateStartingWeight("");
     expect(result, "Weight cannot be empty");
   });

  test("Non-positive starting weight field returns error string: 1", () {
    var result = HelpValidator.validateStartingWeight("-56");
    expect(result, "Weight must be positive");
  });

  test("Non-positive starting weight field returns error string: 2", () {
    var result = HelpValidator.validateStartingWeight("0");
    expect(result, "Weight must be positive");
  });

  test("Empty expected weight field returns error string", () {
    var result = HelpValidator.validateExpectedWeight("");
    expect(result, "Weight cannot be empty");
  });

  test("Non-positive expected weight field returns error string: 1", () {
    var result = HelpValidator.validateExpectedWeight("-56");
    expect(result, "Weight must be positive");
  });

  test("Non-positive expected weight field returns error string: 2", () {
    var result = HelpValidator.validateExpectedWeight("0");
    expect(result, "Weight must be positive");
  });

  test("Non-empty starting date field returns error string", () {
    var result = HelpValidator.validateStartingDate("");
    expect(result, "Date cannot be empty");
  });

  test("Non-empty expected date field returns error string", () {
    var result = HelpValidator.validateExpectedDate("");
    expect(result, "Expected date cannot be empty");
  });

  test("Non-empty starting date field returns error string", () {
    var result = HelpValidator.validateExpectedDate("2022-10-10 00:00:00.000");
    expect(result, "Invalid Date");
  });

  test("Future expected date for starting date returns error string", () {
    var result = HelpValidator.validateExpectedDate("2022-10-10 00:00:00.000");
    expect(result, "Invalid Date");
  });

  test("Future expected date for starting date returns error string", () {
    var result = HelpValidator.validateExpectedDate("2023-12-10 00:00:00.000");
    expect(result, "More than 30 days diff");
  });


}