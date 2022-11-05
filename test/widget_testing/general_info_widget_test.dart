import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dietary_project/screens/general_info_page.dart';

void main() {
  testWidgets("General Info Widget Finder", (WidgetTester tester) async {
    //find widgets
    final dob = find.byKey(ValueKey("dob"));
    final weight = find.byKey(ValueKey("weight"));
    final height = find.byKey(ValueKey("height"));
    final activityType = find.byKey(ValueKey("activityType"));
    final genderType = find.byKey(ValueKey("genderType"));
    final exerciseType = find.byKey(ValueKey("exerciseType"));
    final mealPreferenceType = find.byKey(ValueKey("mealPreferenceType"));
    final medicalField = find.byKey(ValueKey("medicalField"));
    final startingDayType = find.byKey(ValueKey("startingDayType"));
    final notificationDayType = find.byKey(ValueKey("notificationDayType"));

    //execute
    await tester.pumpWidget(MaterialApp(home: GeneralInfoPage()));

    await tester.pump();

    //check output
    expect(dob, findsOneWidget);
    expect(weight, findsOneWidget);
    expect(height, findsOneWidget);
    expect(activityType, findsOneWidget);
    expect(genderType, findsOneWidget);
    expect(exerciseType, findsOneWidget);
    expect(dob, findsOneWidget);
    expect(mealPreferenceType, findsOneWidget);
    expect(medicalField, findsOneWidget);
    expect(startingDayType, findsOneWidget);
    expect(notificationDayType, findsOneWidget);

  });
}
