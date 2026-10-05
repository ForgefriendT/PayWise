import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:paywise/core/theme/app_theme.dart';
import 'package:paywise/features/auth/login_screen.dart';

void main() {
  testWidgets('Login screen renders with demo user access', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const LoginScreen(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('PayWise'), findsOneWidget);
    expect(find.text('Smart, calm payments'), findsOneWidget);
    expect(find.text('Continue as demo user'), findsOneWidget);
  });
}
