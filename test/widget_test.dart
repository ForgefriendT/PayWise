import 'package:flutter_test/flutter_test.dart';
import 'package:paywise/main.dart';

void main() {
  testWidgets('PayWise smoke test and navigation shell', (WidgetTester tester) async {
    await tester.pumpWidget(const PayWiseApp());
    await tester.pumpAndSettle();
    expect(find.text('Home Screen'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('History'), findsOneWidget);
  });
}
