import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dietary_project/screens/set_goals.dart';

void main() {
  testWidgets("Registration Widget Finder", (WidgetTester tester) async {
    //find widgets
    final currentWeight = find.byKey(ValueKey("currentWeight"));
    final expectedWeight = find.byKey(ValueKey("expectedWeight"));
    final currentDate = find.byKey(ValueKey("currentDate"));
    final expectedDate = find.byKey(ValueKey("expectedDate"));


    //execute
    await tester.pumpWidget(MaterialApp(home: SetGoalsPage()));

    await tester.pump();

    //check output
    expect(expectedDate, findsOneWidget);
    expect(expectedWeight, findsOneWidget);
    expect(currentDate, findsOneWidget);
    expect(currentWeight, findsOneWidget);

  });
}
