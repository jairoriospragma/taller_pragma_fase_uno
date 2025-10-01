import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:taller_pragma_fase_uno/domain/entities/contact.dart';
import 'package:taller_pragma_fase_uno/presentation/pages/home/card_information.dart';
import 'package:taller_pragma_fase_uno/presentation/providers/contacts_provider.dart';
import 'package:taller_pragma_fase_uno/presentation/route/string_rout_names.dart';
import 'package:taller_pragma_fase_uno/presentation/widgets/text_widget.dart';
import 'package:taller_pragma_fase_uno/utils/size_constants.dart';
import 'package:taller_pragma_fase_uno/utils/string_constants.dart';
import 'package:url_launcher/url_launcher.dart';

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
                    return Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              context.push(
                                StringRoutNames.detailScreen,
                                extra: contact,
                              );
                            },
                            onLongPress: () async {
                              await showConfirmDialog(context, ref, contact);
                            },
                            child: CardInformation(
                              avatarUrl: contact.avatarUrl,
                              userName: contact.userName,
                              userPhone: contact.userPhone,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.phone, color: Colors.green),
                          onPressed: () async {
                            final Uri url = Uri(
                                scheme: StringConstants.schemeTel,
                                path: contact.userPhone);
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            } else {
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text(StringConstants.cantOpenCallApp)),
                              );
                            }
                          },
                        ),
                      ],
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

  Future<void> showConfirmDialog(
      BuildContext context, WidgetRef ref, Contact contact) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(StringConstants.deleteContact),
        content: const Text(StringConstants.deleteContactTitle),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(StringConstants.closeTitle),
          ),
          TextButton(
            onPressed: () async {
              await ref.read(contactsProvider.notifier).remove(contact);
              if (!context.mounted) return;
              Navigator.of(context).pop();
              await ref.read(contactsProvider.notifier).loadContacts();
            },
            child: const Text(StringConstants.acceptTitle),
          ),
        ],
      ),
    );
  }
}
