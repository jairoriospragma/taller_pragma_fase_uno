import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taller_pragma_fase_uno/data/shared_prefs_contacts_repository.dart';
import 'package:taller_pragma_fase_uno/domain/entities/contact.dart';

void main() {
  late SharedPrefsContactsRepository repository;
  late Contact contact;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    repository = SharedPrefsContactsRepository();
    contact = const Contact(userName: 'Test', userPhone: '123', avatarUrl: 'url');
  });

  test('addContact adds a new contact', () async {
    final result = await repository.addContact(contact);
    expect(result, true);
    final contacts = await repository.getContacts();
    expect(contacts.length, 1);
    expect(contacts.first.userPhone, '123');
  });

  test('addContact does not add duplicate contact', () async {
    await repository.addContact(contact);
    final result = await repository.addContact(contact);
    expect(result, false);
  });

  test('deleteContact removes a contact', () async {
    await repository.addContact(contact);
    await repository.deleteContact(contact);
    final contacts = await repository.getContacts();
    expect(contacts.isEmpty, true);
  });
}
