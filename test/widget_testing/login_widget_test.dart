import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dietary_project/screens/login_page.dart';

void main() {
  testWidgets("Login User Widget Finder", (WidgetTester tester) async {
    //find widgets
    final username = find.byKey(ValueKey("username"));
    final password = find.byKey(ValueKey("password"));
    final signInBtn = find.byKey(ValueKey("sign_in_btn"));

    //execute
    await tester.pumpWidget(MaterialApp(home: LogInPage()));
    await tester.enterText(username, "Sathira123");
    await tester.enterText(password, "Sathira@123");
    await tester.tap(signInBtn);
    await tester.pump();

    //check output
    expect(username, findsOneWidget);
    expect(password, findsOneWidget);
    expect(signInBtn, findsOneWidget);
  });
}
