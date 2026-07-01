import 'package:flutter_test/flutter_test.dart';
import 'package:moove/main.dart';

void main() {
  testWidgets('Splash screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the splash screen shows the title "Moore"
    expect(find.text('Moore'), findsOneWidget);

    // Let the timer finish and transition to onboarding to avoid pending timer error
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
  });
}
