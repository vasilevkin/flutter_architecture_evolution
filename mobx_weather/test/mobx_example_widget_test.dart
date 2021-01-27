import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobx_weather/mobx_example/screens/review.dart';

void main() async {
  testWidgets('Test for rendering UI', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: Review())));

    Finder starCardFinder = find.byKey(Key('avgStar'));

    expect(starCardFinder, findsOneWidget);
  });
}
