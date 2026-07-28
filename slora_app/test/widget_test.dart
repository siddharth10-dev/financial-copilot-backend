import 'package:flutter_test/flutter_test.dart';
import 'package:slora_app/main.dart';

void main() {
  testWidgets('App initialization test', (WidgetTester tester) async {
    await tester.pumpWidget(const SloraApp());
    expect(find.text('Slora'), findsOneWidget);
  });
}
