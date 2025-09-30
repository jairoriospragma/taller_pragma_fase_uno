import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taller_pragma_fase_uno/data/shared_prefs_contacts_repository.dart';
import 'package:taller_pragma_fase_uno/domain/entities/contact.dart';
import 'package:taller_pragma_fase_uno/domain/use_cases/add_contact_use_case.dart';
import 'package:taller_pragma_fase_uno/domain/use_cases/delete_contact_use_case.dart';
import 'package:taller_pragma_fase_uno/domain/use_cases/get_contacts_use_case.dart';
import 'package:taller_pragma_fase_uno/presentation/providers/contacts_notifier.dart';

final contactsRepositoryProvider = Provider((ref) {
  return SharedPrefsContactsRepository();
});

final contactsProvider =
    StateNotifierProvider<ContactsNotifier, AsyncValue<List<Contact>>>((ref) {
  final repo = ref.read(contactsRepositoryProvider);
  return ContactsNotifier(
    getContactsUseCase: GetContactsUseCase(contactsRepository: repo),
    addContactUseCase: AddContactUseCase(contactsRepository: repo),
    deleteContactUseCase: DeleteContactUseCase(contactsRepository: repo),
  );
});
