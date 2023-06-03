import 'package:chabo/extensions/boats_extension.dart';
import 'package:chabo/models/boat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'localized_testable_widget.dart';

void main() {
  final boats1 = [Boat(name: 'TEST_BOAT', isLeaving: false)];
  final boats2 = [...boats1, Boat(name: 'TEST_BOAT_2', isLeaving: true)];
  final boats3 = [
    ...boats2,
    Boat(name: 'TEST_BOAT_3', isLeaving: false),
  ];

  group('toNames', () {
    testWidgets('1 Boat', (WidgetTester tester) async {
      await tester.pumpWidget(
        localizedTestableWidget(
          child: Builder(
            builder: (BuildContext context) {
              var names = boats1.getNames(context);
              expect(names, 'TEST_BOAT');

              return const Placeholder();
            },
          ),
        ),
      );
    });

    testWidgets('2 Boats', (WidgetTester tester) async {
      await tester.pumpWidget(
        localizedTestableWidget(
          child: Builder(
            builder: (BuildContext context) {
              var names = boats2.getNames(context);
              expect(names, 'TEST_BOAT and TEST_BOAT_2');

              return const Placeholder();
            },
          ),
        ),
      );
    });

    testWidgets('3 Boats', (WidgetTester tester) async {
      await tester.pumpWidget(
        localizedTestableWidget(
          child: Builder(
            builder: (BuildContext context) {
              var names = boats3.getNames(context);
              expect(names, 'TEST_BOAT, TEST_BOAT_2 and TEST_BOAT_3');

              return const Placeholder();
            },
          ),
        ),
      );
    });
  });

  group('toLocalizedString', () {
    testWidgets('1 Boat', (WidgetTester tester) async {
      await tester.pumpWidget(
        localizedTestableWidget(
          child: Builder(
            builder: (BuildContext context) {
              var names = boats1.toLocalizedString(context);
              expect(names, 'the arrival of the TEST_BOAT');

              return const Placeholder();
            },
          ),
        ),
      );
    });

    testWidgets('2 Boats', (WidgetTester tester) async {
      await tester.pumpWidget(
        localizedTestableWidget(
          child: Builder(
            builder: (BuildContext context) {
              var names = boats2.toLocalizedString(context);
              expect(names,
                  'the arrival of the TEST_BOAT and the departure of the TEST_BOAT_2');

              return const Placeholder();
            },
          ),
        ),
      );
    });

    testWidgets('3 Boats', (WidgetTester tester) async {
      await tester.pumpWidget(
        localizedTestableWidget(
          child: Builder(
            builder: (BuildContext context) {
              var names = boats3.toLocalizedString(context);
              expect(names,
                  'the arrival of the TEST_BOAT, the departure of the TEST_BOAT_2 and the arrival of the TEST_BOAT_3');

              return const Placeholder();
            },
          ),
        ),
      );
    });
  });
}
