import 'package:flutter_test/flutter_test.dart';

import 'package:pink_ui_kit/main.dart';

void main() {
  testWidgets('welcome screen is shown first', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Отдых с душой'), findsOneWidget);
  });
}
