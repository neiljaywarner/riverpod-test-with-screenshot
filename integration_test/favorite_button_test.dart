import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:riverpod_test/main.dart' as app;

void main() async {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('FavoriteButton', (tester) async {
    String prefix = '';
    if (Platform.isAndroid) {
      prefix = 'AndroidScreenshots';
    } else if (Platform.isIOS) {
      prefix = 'iOSScreenshots';
    } else {
      prefix = 'OtherScreenshots';
    }
    String dir = '$prefix${tester.testDescription.replaceAll(' ', '_')}';
    // (Optional): It helps to take screenshots
    await binding.convertFlutterSurfaceToImage();

    // runs the app
    app.main();

    // awaits to settle the widgets
    await tester.pumpAndSettle();
    // (Optional): takes a screenshot
    await binding.takeScreenshot('$dir/screenshot');

    // if finds a [ListView]
    expect(find.byType(ListView), findsOneWidget);

    // gets the first favorite
    final button = find.byType(IconButton).first;

    // and expect its color is grey
    expect(tester.widget<Icon>(find.byType(Icon).first).color, Colors.grey);

    // then clicks on it
    await tester.tap(button);
    await tester.pumpAndSettle();
    // (Optional): takes a screenshot
    await binding.takeScreenshot('$dir/screenshot2');

    // then expect the color is turned to red
    expect(tester.widget<Icon>(find.byType(Icon).first).color, Colors.red);

    // clicks again
    await tester.tap(button);
    await tester.pumpAndSettle();
    // (Optional): takes a screenshot
    await binding.takeScreenshot('$dir/screenshot3');

    // and expect again it turns back to grey
    expect(tester.widget<Icon>(find.byType(Icon).first).color, Colors.grey);
  });
}
