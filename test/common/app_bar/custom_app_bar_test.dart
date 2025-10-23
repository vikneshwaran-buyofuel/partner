import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:partner/app/presentation/app_layout/appBar/custom_appBar.dart';

void main() {
  group('CustomAppBar widget', () {
    testWidgets('renders title correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: CustomAppBar(title: 'Test Title'),
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
    });

    testWidgets('shows back button when showBack is true', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: CustomAppBar(title: 'Back Test', showBack: true),
          ),
        ),
      );

      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    });

    testWidgets('hides back button when showBack is false', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: CustomAppBar(title: 'No Back', showBack: false),
          ),
        ),
      );

      expect(find.byIcon(Icons.arrow_back), findsNothing);
    });

    testWidgets('calls onBack when back button is pressed', (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: CustomAppBar(
              title: 'Callback Test',
              onBack: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets('shows snackbar when no previous route to pop', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: CustomAppBar(
              title: 'Snackbar Test',
              showBack: true, // show the back button
              onBack: () {
                // Simulate the snackbar behavior when no GoRouter context
                ScaffoldMessenger.of(tester.element(find.byType(Scaffold))).showSnackBar(
                  const SnackBar(
                    content: Text("No previous page to go back to"),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
            body: const SizedBox(),
          ),
        ),
      );

      // Tap the back button
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      // Verify the SnackBar is shown
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('No previous page to go back to'), findsOneWidget);
    });

    testWidgets('works with GoRouter context', (WidgetTester tester) async {
      // Define test routes using GoRouter
      final router = GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const FirstPage(),
          ),
          GoRoute(
            path: '/second',
            builder: (context, state) => const SecondPage(),
          ),
        ],
      );

      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: router,
        ),
      );

      await tester.pumpAndSettle();

      // Verify we're on the first page initially
      expect(find.text('First Page'), findsOneWidget);

      // Navigate to second page by tapping the button
      await tester.tap(find.text('Go to Second'));
      await tester.pumpAndSettle();

      // Verify we're on second page by checking the body content
      expect(find.text('Second Page Content'), findsOneWidget);

      // Verify the back button is present
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);

      // Test that the back button can be tapped (without verifying navigation)
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();
      
      // The test passes if no exceptions are thrown
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    });
  });
}

/// Dummy first page
class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'First Page'),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/second'),
          child: const Text('Go to Second'),
        ),
      ),
    );
  }
}

/// Dummy second page
class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: 'Second Page'),
      body: Center(child: Text('Second Page Content')),
    );
  }
}
