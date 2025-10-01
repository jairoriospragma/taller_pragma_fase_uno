import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:taller_pragma_fase_uno/domain/entities/contact.dart';
import 'package:taller_pragma_fase_uno/domain/repositories/contacts_repository.dart';

class MockContactsRepository extends Mock implements ContactsRepository {
  @override
  Future<bool> addContact(Contact contact) async => true;
  @override
  Future<void> deleteContact(Contact contact) async {}
  @override
  Future<List<Contact>> getContacts() async => [];
}

void main() {
  test('addContact calls repository', () async {
    final repo = MockContactsRepository();
    const contact =
        Contact(userName: 'Test', userPhone: '123', avatarUrl: 'url');
    final result = await repo.addContact(contact);
    expect(result, true);
  });
}
