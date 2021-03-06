import 'package:bookifyapp/Design/constants.dart';
import 'package:bookifyapp/LayoutWidgets/Buttons/small_button_underlined.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../widget_test_functions.dart';

void main() {
  group('Default Small Button Underlined Widget Tests', () {
    const double DEFAULT_FONT_SIZE = 24;

    testWidgets('Default SmallButtonUnderlined Test',
        (WidgetTester tester) async {
      final widget = SmallButtonUnderlined(
        "Small Button",
        fontSize: 16,
      );
      await WidgetTestFunctions.pumpWidgetTest(
          tester, widget, SmallButtonUnderlined);

      final buttonTitle = find.text("Small Button");
      // Use the `findsOneWidget` matcher provided by flutter_test to
      // verify that the Text widgets appear exactly once in the widget tree.
      expect(buttonTitle, findsOneWidget);

      //Getting text object
      Text text = tester.firstWidget(buttonTitle);
      //Validating properties
      expect(text.style.color, smallUnderlinedButtonColor);
      expect(text.style.fontSize, 16);
      expect(text.style.decoration, TextDecoration.underline);
      expect(text.style.fontWeight, FontWeight.bold);
    });

    testWidgets('SmallButtonUnderlined test with custom values',
        (WidgetTester tester) async {
      final widget = SmallButtonUnderlined(
        "Small Button",
        fontSize: DEFAULT_FONT_SIZE,
        textColor: Colors.red,
      );
      await WidgetTestFunctions.pumpWidgetTest(
          tester, widget, SmallButtonUnderlined);

      final buttonTitle = find.text("Small Button");
      // Use the `findsOneWidget` matcher provided by flutter_test to
      // verify that the Text widgets appear exactly once in the widget tree.
      expect(buttonTitle, findsOneWidget);

      //Getting text object
      Text text = tester.firstWidget(buttonTitle);
      //Validating properties
      expect(text.style.color, Colors.red);
      expect(text.style.fontSize, 24);
      expect(text.style.decoration, TextDecoration.underline);
      expect(text.style.fontWeight, FontWeight.bold);
    });
  });
}
