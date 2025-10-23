import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:partner/app/common_widgets/buttons/CustomButton.dart';
import 'package:partner/core/constants/enum.dart';

void main() {
  group('CustomButton Widget Tests', () {
    testWidgets('renders title text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: CustomButton(title: 'Test Button')),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
    });

    testWidgets('calls onPressed when tapped', (WidgetTester tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              title: 'Press Me',
              onPressed: () {
                pressed = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(pressed, isTrue);
    });

    testWidgets('displays loading spinner when isLoading is true', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: CustomButton(title: 'Loading', isLoading: true)),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Loading'), findsNothing);
    });

    testWidgets('renders leading and trailing icons', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              title: 'Icon Button',
              leadingIcon: const Icon(Icons.add),
              trailingIcon: const Icon(Icons.arrow_forward),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
    });

    testWidgets('applies correct size mapping', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: ButtonSize.values.map((size) {
                return CustomButton(title: size.toString(), size: size);
              }).toList(),
            ),
          ),
        ),
      );

      for (final size in ButtonSize.values) {
        expect(find.text(size.toString()), findsOneWidget);
      }
    });

    testWidgets('disables button when onPressed is null', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(title: 'Disabled', onPressed: null),
          ),
        ),
      );

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('renders different variants correctly', (
      WidgetTester tester,
    ) async {
      for (final variant in ButtonVariant.values) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomButton(title: variant.toString(), variant: variant),
            ),
          ),
        );

        expect(find.text(variant.toString()), findsOneWidget);
      }
    });
  });
}
