import 'package:taller_pragma_fase_uno/domain/entities/contact.dart';
import 'package:taller_pragma_fase_uno/domain/repositories/contacts_repository.dart';

class GetContactsUseCase {
  const GetContactsUseCase({
    required this.contactsRepository,
  });

  final ContactsRepository contactsRepository;

  Future<List<Contact>> getContacts() async {
    return await contactsRepository.getContacts();
  }
}
