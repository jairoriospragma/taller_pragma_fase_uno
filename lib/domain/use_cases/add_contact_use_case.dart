import 'package:taller_pragma_fase_uno/domain/entities/contact.dart';
import 'package:taller_pragma_fase_uno/domain/repositories/contacts_repository.dart';

class AddContactUseCase {
  const AddContactUseCase({
    required this.contactsRepository,
  });

  final ContactsRepository contactsRepository;

  Future<bool> addContact(Contact contact) async {
    return await contactsRepository.addContact(contact);
  }
}
