import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:chabo/main.dart' as app;

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    return Future(() async {
      WidgetsApp.debugAllowBannerOverride = false;
      if (Platform.isAndroid) {
        await binding.convertFlutterSurfaceToImage();
      }
    });
  });

  testWidgets('Screenshot - Main Page', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey<String>('statusWidget')), findsOneWidget);
    await binding.takeScreenshot('screenshot-0');
  });

  testWidgets('Screenshot - Main Page', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    expect(find.byKey(const GlobalObjectKey('forecast-0')), findsOneWidget);
    await tester.tap(find.byIcon(Icons.access_alarm));
    await binding.takeScreenshot('screenshot-1');
  });
}
