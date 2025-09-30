import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:taller_pragma_fase_uno/presentation/pages/home/card_information.dart';
import 'package:taller_pragma_fase_uno/presentation/providers/contacts_provider.dart';
import 'package:taller_pragma_fase_uno/presentation/route/string_rout_names.dart';
import 'package:taller_pragma_fase_uno/presentation/widgets/text_widget.dart';
import 'package:taller_pragma_fase_uno/utils/size_constants.dart';
import 'package:taller_pragma_fase_uno/utils/string_constants.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactsAsync = ref.watch(contactsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const TextWidget(text: StringConstants.constHomeTitle),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: SizeConstants.spacingSize16,
              bottom: SizeConstants.spacingSize8,
            ),
            child: ElevatedButton.icon(
              onPressed: () async {
                await context.push<bool>(StringRoutNames.formScreen);
                await ref.read(contactsProvider.notifier).loadContacts();
              },
              icon: const Icon(Icons.add),
              label: const TextWidget(
                text: StringConstants.addContact,
                fontSize: SizeConstants.fontSizeCardDescription,
              ),
            ),
          ),
          Expanded(
            child: contactsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) =>
                  Center(child: Text('${StringConstants.errorTitle}: $e')),
              data: (contacts) {
                if (contacts.isEmpty) {
                  return const Center(child: Text(StringConstants.notContacts));
                }
                return ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    final contact = contacts[index];
                    return InkWell(
                      onTap: () {
                        context.push(
                          StringRoutNames.detailScreen,
                          extra: contact,
                        );
                      },
                      onLongPress: () async {
                        await ref
                            .read(contactsProvider.notifier)
                            .remove(contact);
                        await ref
                            .read(contactsProvider.notifier)
                            .loadContacts();
                      },
                      child: CardInformation(
                        avatarUrl: contact.avatarUrl,
                        userName: contact.userName,
                        userPhone: contact.userPhone,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
