import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:taller_pragma_fase_uno/presentation/pages/detail/detail_screen.dart';
import 'package:taller_pragma_fase_uno/domain/entities/contact.dart';

void main() {
  testWidgets('DetailScreen renders correctly', (WidgetTester tester) async {
    const contact = Contact(userName: 'Test', userPhone: '123', avatarUrl: '');
    await tester.pumpWidget(const MaterialApp(
      home: DetailScreen(contact: contact),
    ));
    expect(find.byType(DetailScreen), findsOneWidget);
  });
}
