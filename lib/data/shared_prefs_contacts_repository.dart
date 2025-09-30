import 'dart:convert';

import 'package:taller_pragma_fase_uno/domain/entities/contact.dart';
import 'package:taller_pragma_fase_uno/domain/repositories/contacts_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsContactsRepository implements ContactsRepository {
  static const String _contactsKey = 'contacts';
  final String _userNameKey = 'userName';
  final String _userPhoneKey = 'userPhone';
  final String _avatarUrlKey = 'avatarUrl';

  @override
  Future<bool> addContact(Contact contact) async {
    final prefs = await SharedPreferences.getInstance();
    final contacts = await getContacts();

    final contactExists =
        contacts.any((element) => element.userPhone == contact.userPhone);
    if (contactExists) {
      return false;
    }
    final updated = [...contacts, contact];
    await prefs.setString(
      _contactsKey,
      json.encode(updated
          .map((c) => {
                _userNameKey: c.userName,
                _userPhoneKey: c.userPhone,
                _avatarUrlKey: c.avatarUrl,
              })
          .toList()),
    );
    return true;
  }

  @override
  Future<void> deleteContact(Contact contact) async {
    final prefs = await SharedPreferences.getInstance();
    final contacts = await getContacts();
    final updated = List<Contact>.from(contacts)
      ..removeWhere((element) => element.userPhone == contact.userPhone);
    await prefs.setString(
      _contactsKey,
      json.encode(updated
          .map((c) => {
                _userNameKey: c.userName,
                _userPhoneKey: c.userPhone,
                _avatarUrlKey: c.avatarUrl,
              })
          .toList()),
    );
  }

  @override
  Future<List<Contact>> getContacts() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_contactsKey);
    if (data != null) {
      final list = jsonDecode(data) as List;
      return list
          .map((e) => Contact(
                userName: e[_userNameKey],
                userPhone: e[_userPhoneKey],
                avatarUrl: e[_avatarUrlKey],
              ))
          .toList();
    }
    return [];
  }
}
