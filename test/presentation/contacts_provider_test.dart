import 'package:flutter_test/flutter_test.dart';
import 'package:taller_pragma_fase_uno/domain/entities/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taller_pragma_fase_uno/presentation/providers/contacts_provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  test('ContactsNotifier adds and removes contacts', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final notifier = container.read(contactsProvider.notifier);
    const contact = Contact(userName: 'Test', userPhone: '123', avatarUrl: 'url');

    final added = await notifier.add(contact);
    expect(added, true);

    await notifier.remove(contact);
    final state = container.read(contactsProvider);
    expect(state.value?.where((c) => c.userPhone == contact.userPhone).isEmpty, true);
  });
}
