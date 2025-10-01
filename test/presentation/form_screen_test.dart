import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:taller_pragma_fase_uno/presentation/pages/form/form_screen.dart';

void main() {
  testWidgets('FormScreen renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: FormScreen(),
    ));
    expect(find.byType(FormScreen), findsOneWidget);
  });
}
