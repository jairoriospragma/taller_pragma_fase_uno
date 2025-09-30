import 'package:taller_pragma_fase_uno/domain/entities/contact.dart';

abstract class ContactsRepository {
  Future<List<Contact>> getContacts();

  Future<bool> addContact(Contact contact);

  Future<void> deleteContact(Contact contact);
}
