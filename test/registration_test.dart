import 'package:dietary_project/screens/registration.dart';
import 'package:test/test.dart';

void main() {

  test("Empty username returns error string", () {
    var result = HelpValidator.validateUsername("");
    expect(result, "Username cannot be empty");
  });

  test("Username should contain at least 8 characters", () {
    //length of the input string is 6
    var result = HelpValidator.validateUsername("Abcdfg");
    expect(result, "Length must be more than 8 characters");
  });

  test("Empty password returns error string", () {
    var result = HelpValidator.validatePassword("");
    expect(result, "Password cannot be empty");
  });

  test("Password should contain at least 8 characters", () {
    //length of the input string is 6
    var result = HelpValidator.validatePassword("Ab@123");
    expect(result, "Length must be more than 8 characters");
  });

  test("Password should contain at least one uppercase character", () {
    var result = HelpValidator.validatePassword("abcde@123");
    expect(result, "Password is not strong");
  });

  test("Password should contain at least one lowercase character", () {
    var result = HelpValidator.validatePassword("ABCDE@123");
    expect(result, "Password is not strong");
  });

  test("Password should contain at least one special character", () {
    var result = HelpValidator.validatePassword("ABcdef123");
    expect(result, "Password is not strong");
  });

  test("Re-enter password field must be non-empty", () {
    var result = HelpValidator.validateAgainPassword("Abcd@1234", "");
    expect(result, "Password cannot be empty");
  });

  test("Re-enter password and password fields must be same", () {
    var result = HelpValidator.validateAgainPassword("UserA@9876", "UserB@1234");
    expect(result, "Password does not match");
  });

  test("First Name field must be non-empty", () {
    var result = HelpValidator.validateFirstName("");
    expect(result, "First Name cannot be empty");
  });

  test("Last Name field must be non-empty", () {
    var result = HelpValidator.validateLastName("");
    expect(result, "Last Name cannot be empty");
  });

  test("Email field must be non-empty", () {
    var result = HelpValidator.validateEmail("");
    expect(result, "Email cannot be empty");
  });

  test("Email should follow correct email address syntax :1", () {
    var result = HelpValidator.validateEmail("supun@124");
    expect(result, "Invalid Email");
  });

  test("Email should follow correct email address syntax: 2", () {
    var result = HelpValidator.validateEmail("supungyt.com");
    expect(result, "Invalid Email");
  });

  test("Email should follow correct email address syntax: 3", () {
    var result = HelpValidator.validateEmail("supungyt15");
    expect(result, "Invalid Email");
  });

}
