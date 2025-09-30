import 'package:taller_pragma_fase_uno/domain/entities/contact.dart';
import 'package:taller_pragma_fase_uno/domain/repositories/contacts_repository.dart';

class DeleteContactUseCase {
  const DeleteContactUseCase({
    required this.contactsRepository,
  });

  final ContactsRepository contactsRepository;

  Future<void> deleteContact(Contact contact) async {
    await contactsRepository.deleteContact(contact);
  }
}
