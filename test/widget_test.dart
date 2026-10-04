import 'package:flutter_test/flutter_test.dart';
import 'package:paywise/main.dart';

void main() {
  testWidgets('PayWise smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const PayWiseApp());
    expect(find.text('PayWise Initialized'), findsOneWidget);
  });
}
