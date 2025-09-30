import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taller_pragma_fase_uno/domain/entities/contact.dart';
import 'package:taller_pragma_fase_uno/domain/use_cases/add_contact_use_case.dart';
import 'package:taller_pragma_fase_uno/domain/use_cases/delete_contact_use_case.dart';
import 'package:taller_pragma_fase_uno/domain/use_cases/get_contacts_use_case.dart';

class ContactsNotifier extends StateNotifier<AsyncValue<List<Contact>>> {
  ContactsNotifier({
    required this.getContactsUseCase,
    required this.addContactUseCase,
    required this.deleteContactUseCase,
  }) : super(const AsyncValue.loading()) {
    loadContacts();
  }

  final GetContactsUseCase getContactsUseCase;
  final AddContactUseCase addContactUseCase;
  final DeleteContactUseCase deleteContactUseCase;

  Future<void> loadContacts() async {
    state = const AsyncValue.loading();
    try {
      final contacts = await getContactsUseCase.getContacts();
      state = AsyncValue.data(contacts);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<bool> add(Contact contact) async {
   return await addContactUseCase.addContact(contact);
  }

  Future<void> remove(Contact contact) async {
    await deleteContactUseCase.deleteContact(contact);
    await loadContacts();
  }
}
