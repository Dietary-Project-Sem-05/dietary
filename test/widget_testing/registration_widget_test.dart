import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dietary_project/screens/registration.dart';

void main() {
  testWidgets("Registration Widget Finder", (WidgetTester tester) async {
    //find widgets
    final firstName = find.byKey(ValueKey("firstName"));
    final lastName = find.byKey(ValueKey("lastName"));
    final username = find.byKey(ValueKey("username"));
    final email = find.byKey(ValueKey("email"));
    final password = find.byKey(ValueKey("password"));
    final againPassword = find.byKey(ValueKey("againPassword"));


    //execute
    await tester.pumpWidget(MaterialApp(home: RegisterPage()));

    await tester.pump();

    //check output
    expect(firstName, findsOneWidget);
    expect(lastName, findsOneWidget);
    expect(username, findsOneWidget);
    expect(email, findsOneWidget);
    expect(password, findsOneWidget);
    expect(againPassword, findsOneWidget);

  });
}
