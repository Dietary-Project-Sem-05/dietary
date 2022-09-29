import 'package:dietary_project/screens/login_page.dart';
import 'package:test/test.dart';

void main() {
  test("Empty username returns error string", () {
    var result = HelpValidator.validateUsername("");
    expect(result, "Username cannot be empty");
  });

  test("Empty password returns error string", () {
    var result = HelpValidator.validatePassword("");
    expect(result, "Password cannot be empty");
  });
}
