import 'package:flutter_test/flutter_test.dart';
import 'package:al_qalam_school/main.dart';

void main() {
  testWidgets('Al-Qalam School App initial smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const AlQalamSchoolApp());
    expect(find.byType(AlQalamSchoolApp), findsOneWidget);
    // Allow splash screen timer and fade animation to settle
    await tester.pumpAndSettle(const Duration(seconds: 4));
  });
}
